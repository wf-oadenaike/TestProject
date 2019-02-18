CREATE VIEW [Investment].[DVD_Calculation]

-------------------------------------------------------------------------------------- 
-- Name:			[Investment].[DVD_Calculation]
-- 
-- Params:			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
-- D.Bacchus:		19/06/2017			JIRA: DAP-1150 View to present Dividend Calculations to ManyWho
-- D.Bacchus:		26/06/2017			As requested, added Ticker and Unique ID to the dataset 
-- D.Bacchus		15/08/2017			JIRA: DAP-1284 Optimisation 
-------------------------------------------------------------------------------------- 

AS

SELECT DISTINCT
	ROW_UNIQUE_ID
	,[EDM_SEC_ID]
	,SecurityName
	,FundShortName
	,ExDate
	,DvdValue_ExDate
	,Quantity_ExDate
	,Quantity_LastDate
	,Position_LastDate
	,Quantity_FirstDate
	,Position_FirstDate
	,PrevQuantity
	,SpecialCumTrades
	,WithholdingTax
	,DvdCCY
	,Qtr
	,Yr
	,ISNULL(fx.[SPOT_RATE], 1) AS SpotRate
	,Ticker
	
	,(
 		select fx.SPOT_RATE
			from [dbo].[T_MASTER_FXRATE] fx
			inner join [dbo].[T_MASTER_SEC] ms on ISNULL(fx.[TO_ISO_CURRENCY_CODE],'') = ISNULL(ms.SECURITY_ISO_CCY,'') and fx.DATE = 
											(SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS]
											WHERE fx.[FROM_ISO_CURRENCY_CODE]='GBP')
											and ms.EDM_SEC_ID = d.EDM_SEC_ID
			inner join [dbo].[T_MASTER_SEC_EQUITY] mse on ISNULL(fx.[TO_ISO_CURRENCY_CODE],'') = ISNULL(mse.DIVIDEND_CCY,'') and fx.DATE = 
											(SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS]
											WHERE fx.[FROM_ISO_CURRENCY_CODE]='GBP')
											and mse.EDM_SEC_ID = d.EDM_SEC_ID
	
		) as optimisation_hint -- not required in DG



FROM
(
	SELECT
		ROW_NUMBER() OVER(ORDER BY bdh.EDM_SEC_ID ASC) AS ROW_UNIQUE_ID 
		,bdh.[EDM_SEC_ID]
		,ms.SECURITY_NAME AS SecurityName
		,bdh.FUND_SHORT_NAME AS FundShortName
		,CAST(bdh.ExDate AS DATE) as ExDate
		,bdh.DvdValue_ExDate AS DvdValue_ExDate
		,mp.[QUANTITY] as Quantity_ExDate
		,bdh.Quantity_LastDate
		,bdh.Position_LastDate

		,pfh.Quantity_FirstDate
		,pfh.Position_FirstDate

		--// Get the last quantity prior to the ex-date, 
		,PrevQuantity = (SELECT TOP 1 ZZ.[QUANTITY] FROM [dbo].[T_MASTER_POS] ZZ 
							WHERE bdh.[EDM_SEC_ID] = ZZ.[EDM_SEC_ID] 
							AND bdh.FUND_SHORT_NAME = ZZ.FUND_SHORT_NAME
							AND ZZ.[POSITION_DATE] < bdh.ExDate
							ORDER BY ZZ.[POSITION_DATE] DESC)

		,0 AS SpecialCumTrades


		,ISNULL(ms.[WITHHOLDING_TAX],0) as WithholdingTax
		,ISNULL(mse.DIVIDEND_CCY,ms.SECURITY_ISO_CCY) as DvdCCY
		,DATEPART(qq, bdh.ExDate) as Qtr
		,DATEPART(yy, bdh.ExDate) as Yr
		,ms.Ticker
	FROM 
		Investment.ufn_DVD_Framework() bdh 
	INNER JOIN
		Investment.ufn_POS_FirstHeld() pfh ON pfh.[EDM_SEC_ID] = bdh.[EDM_SEC_ID] AND pfh.FUND_SHORT_NAME = bdh.FUND_SHORT_NAME

	LEFT OUTER JOIN
		[dbo].[T_MASTER_POS] mp ON bdh.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
								AND bdh.ExDate = mp.[POSITION_DATE] AND bdh.FUND_SHORT_NAME = mp.FUND_SHORT_NAME
	INNER JOIN 
		[dbo].[T_MASTER_SEC] ms ON ms.[EDM_SEC_ID] = bdh.[EDM_SEC_ID]
	INNER JOIN 
		T_MASTER_SEC_EQUITY mse ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
	WHERE
		CAST(bdh.ExDate AS DATE) >= pfh.Position_FirstDate


) d
LEFT OUTER JOIN 
(
			select fx.SPOT_RATE, ms.EDM_SEC_ID as EDM_SEC_IDms, mse.EDM_SEC_ID as EDM_SEC_IDmse
			from [dbo].[T_MASTER_FXRATE] fx
			inner join [dbo].[T_MASTER_SEC] ms on ISNULL(fx.[TO_ISO_CURRENCY_CODE],'') = ISNULL(ms.SECURITY_ISO_CCY,'') and fx.DATE = 
											(SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS]
											WHERE fx.[FROM_ISO_CURRENCY_CODE]='GBP')
			inner join [dbo].[T_MASTER_SEC_EQUITY] mse on ISNULL(fx.[TO_ISO_CURRENCY_CODE],'') = ISNULL(mse.DIVIDEND_CCY,'') and fx.DATE = 
											(SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS]
											WHERE fx.[FROM_ISO_CURRENCY_CODE]='GBP')
	
) fx
ON d.EDM_SEC_ID = fx.EDM_SEC_IDms or d.EDM_SEC_ID = fx.EDM_SEC_IDmse
WHERE
	d.ExDate IS NOT NULL --WEIRD! NATIONAL GRID PLC has a null ex-date, investigate
order by row_unique_id, EDM_SEC_ID
OFFSET  0 ROWS 