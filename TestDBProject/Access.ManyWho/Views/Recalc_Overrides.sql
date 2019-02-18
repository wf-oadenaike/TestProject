CREATE VIEW [Access.ManyWho].[Recalc_Overrides]
-------------------------------------------------------------------------------------- 
-- Name:	[Access.ManyWho].[Recalc_Overrides]
-- 
-- Purpose:	Return income streams (dividends) for stock within 'income' funds with user 
--			overrides where appropriate.			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
-- D.Bacchus:		26/06/2017			JIRA: DAP-1150 View to present Recalc Overrides to ManyWho
-- D.Fanning:		07/08/2017			JIRA: DAP 1260 Amended DvdValue to reflect overrides
-- D.Bacchus		14/08/2017			JIRA: DAP-1284 Optimised performance 
-- D.Fanning		29/08/2017			JIRA: DAP-1331 Support override of ExDate
-- D.Fanning		30/08/2017			JIRA: DAP-1331 Added original dividend rate
-- D.Fanning		01/09/2017			JIRA: DAP-1331 Support for new override exDates
-- D.Fanning		08/09/2017			JIRA: DAP-1331 For new dividends 0 original div value, 
--										fix periods for WIMIFF, show security description after security name
-- D.Fanning		12/09/2017			JIRA: DAP-1331 handle GBp for override dividends rate 
-- D.Fanning		13/09/2017			JIRA: DAP-1331 Use lasted quantity (quantity_lastDate) for new future overrides
-- D.Fanning		15/09/2017			JIRA: DAP-1331 Handle new dividends for unquoted and new periods correctly
-------------------------------------------------------------------------------------- 
AS
SELECT
	ROW_NUMBER() OVER(ORDER BY [EDM_SEC_ID] ASC) AS ROW_UNIQUE_ID 
	,DVD_Overrides_ID
	,DVD_Fund_Overrides_ID = 0
	,[EDM_SEC_ID]
	,SecurityName = SecurityName + ' (' + SECURITY_DESCRIPTION + ')'
	,FundShortName
	,ExDate
	,DvdValue_ExDate
	,OriginalDvdValue_ExDate
	,Quantity_ExDate
	,Quantity_LastDate
	,Position_LastDate
	,Quantity_FirstDate
	,Position_FirstDate
	,Quantity_DvdCalc
	,GrossDvdValue
	,NetDvdValue
	,SpecialCumTrades
	,WithholdingTax
	,DvdCCY
	,Qtr
	,Yr
	,SpotRate
	,Ticker
	,HasOverride
FROM
(
	SELECT
		dVD_O.DVD_Overrides_ID
		,DVD.[EDM_SEC_ID]
		,DVD.SecurityName 
		,DVD.FundShortName
		,ISNULL(DVD_O.[BBG_EX_DATE], DVD.ExDate) AS ExDate
		,ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) AS DvdValue_ExDate
		,DVD.DvdValue_ExDate AS OriginalDvdValue_ExDate
		,DVD.Quantity_ExDate
		,DVD.Quantity_LastDate
		,DVD.Position_LastDate
		,DVD.Quantity_FirstDate
		,DVD.Position_FirstDate
		,DVD.Quantity_DvdCalc
		
		,		
		(CASE WHEN binary_checksum(DVD.DvdCCY) = binary_checksum('GBp') THEN
			(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.GrossDvdValue
			ELSE
				DVD.Quantity_DvdCalc * ISNULL((DVD_O.[OVERRIDE_DVD_VALUE] / 100), DVD.DvdValue_ExDate) / DVD.SpotRate
				
			END)
		ELSE
			(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.GrossDvdValue
			ELSE
				DVD.Quantity_DvdCalc * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate
			END) 
		END) AS GrossDvdValue

		,
		(CASE WHEN binary_checksum(DVD.DvdCCY) = binary_checksum('GBp') THEN
			(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.NetDvdValue
			ELSE
				(DVD.Quantity_DvdCalc * ISNULL((DVD_O.[OVERRIDE_DVD_VALUE] / 100), DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
			END)
		ELSE
			(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.NetDvdValue
			ELSE
				(DVD.Quantity_DvdCalc * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
			END) 		
		END) AS NetDvdValue
	
		/*,(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.SpecialCumTrades
		ELSE
			(DVD_FUND_O.[OVERRIDE_QUANTITY] * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
		END)*/ ,0 as SpecialCumTrades


		,DVD.WithholdingTax
		,DVD.DvdCCY
		,Qtr = DATEPART(QQ, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], ISNULL(DVD_O.[BBG_EX_DATE], DVD.ExDate)))
		,Yr = DATEPART(YYYY, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], ISNULL(DVD_O.[BBG_EX_DATE], DVD.ExDate)))
		,DVD.SpotRate
		,DVD.Ticker
		,(CASE WHEN DVD_O.[BBG_EX_DATE] IS NOT NULL THEN 'Y' ELSE 'N' END) as HasOverride
		,SEC.SECURITY_DESCRIPTION 
	FROM 
		[Investment].[ufn_BBG_DVDs]()	DVD
	INNER JOIN
		[dbo].[T_MASTER_FND]			FND on DVD.FundShortName = FND.SHORT_NAME 
	LEFT OUTER JOIN
		Investment.DVD_Overrides		DVD_O	ON DVD_O.EDM_SEC_ID		= DVD.EDM_SEC_ID
												AND DVD_O.[BBG_EX_DATE] = DVD.ExDate
												AND DVD_O.IsActive		= 1
	INNER JOIN
		[dbo].[T_MASTER_SEC]			SEC ON DVD.EDM_SEC_ID = SEC.EDM_SEC_ID
	WHERE
		DVD.Position_LastDate = (SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS])

	UNION

	SELECT
		DVD_O.DVD_Overrides_ID
		,DVD.[EDM_SEC_ID]
		,DVD.SecurityName 
		,DVD.FundShortName
		,ISNULL(DVD_O.[BBG_EX_DATE], DVD.ExDate) AS ExDate
		,ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) AS DvdValue_ExDate
		,DVD.DvdValue_ExDate AS OriginalDvdValue_ExDate
		,DVD.Quantity_ExDate
		,DVD.Quantity_LastDate
		,DVD.Position_LastDate
		,DVD.Quantity_FirstDate
		,DVD.Position_FirstDate
		,DVD.Quantity_DvdCalc

		,		
		(CASE WHEN binary_checksum(DVD.DvdCCY) = binary_checksum('GBp') THEN
			(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.GrossDvdValue
			ELSE
				DVD.Quantity_DvdCalc * ISNULL((DVD_O.[OVERRIDE_DVD_VALUE] / 100), DVD.DvdValue_ExDate) / DVD.SpotRate
				
			END)
		ELSE
			(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.GrossDvdValue
			ELSE
				DVD.Quantity_DvdCalc * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate
			END) 
		END) AS GrossDvdValue

		,
		(CASE WHEN binary_checksum(DVD.DvdCCY) = binary_checksum('GBp') THEN
			(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.NetDvdValue
			ELSE
				(DVD.Quantity_DvdCalc * ISNULL((DVD_O.[OVERRIDE_DVD_VALUE] / 100), DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
			END)
		ELSE
			(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.NetDvdValue
			ELSE
				(DVD.Quantity_DvdCalc * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
			END) 		
		END) AS NetDvdValue
	
		/*,(CASE WHEN DVD_FUND_O.[BBG_EX_DATE] IS NULL THEN DVD.SpecialCumTrades
		ELSE
			(DVD_FUND_O.[OVERRIDE_QUANTITY] * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
		END)*/, 0 as SpecialCumTrades

		,DVD.WithholdingTax
		,DVD.DvdCCY
		,Qtr = DATEPART(QQ, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], ISNULL(DVD_O.[BBG_EX_DATE], DVD.ExDate)))
		,Yr = DATEPART(YYYY, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], ISNULL(DVD_O.[BBG_EX_DATE], DVD.ExDate)))
		,DVD.SpotRate
		,DVD.Ticker
		,(CASE WHEN DVD_O.[BBG_EX_DATE] IS NOT NULL THEN 'Y' ELSE 'N' END) as HasOverride
		,SEC.SECURITY_DESCRIPTION 
	FROM 
		[Investment].[ufn_BBG_DVDs]()	DVD
	INNER JOIN
		[dbo].[T_MASTER_FND]			FND on DVD.FundShortName = FND.SHORT_NAME 
	LEFT OUTER JOIN
		Investment.DVD_Overrides		DVD_O	ON DVD_O.EDM_SEC_ID		= DVD.EDM_SEC_ID
												AND DVD_O.[BBG_EX_DATE] = DVD.ExDate
												AND DVD_O.IsActive		= 1
	INNER JOIN
		[dbo].[T_MASTER_SEC]			SEC ON DVD.EDM_SEC_ID = SEC.EDM_SEC_ID
	WHERE
		DVD.Position_LastDate <> (SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS])
	AND DVD.ExDate <= DVD.Position_LastDate


UNION
	--// Get overrides for new exDates
	SELECT
		dVD_O.DVD_Overrides_ID
		,P.[EDM_SEC_ID]
		,SEC.Security_Name 
		,P.Fund_Short_Name
		,DVD_O.OVERRIDE_EX_DATE  AS ExDate
		,DVD_O.[OVERRIDE_DVD_VALUE] AS DvdValue_ExDate
		,0 AS OriginalDvdValue_ExDate
		,Quantity_ExDate = P.QUANTITY 
		,Quantity_LastDate = P.QUANTITY

		,Position_LastDate = P.POSITION_DATE

		,Quantity_FirstDate = P.QUANTITY
		,Position_FirstDate = P.POSITION_DATE
	
		,Quantity_DvdCalc = P.QUANTITY

		,
		(CASE WHEN binary_checksum(MSE.DIVIDEND_CCY) = binary_checksum('GBp') THEN
			(P.QUANTITY * ISNULL((DVD_O.[OVERRIDE_DVD_VALUE] / 100), DVD_O.[OVERRIDE_DVD_VALUE]) / ISNULL(fx.[SPOT_RATE], 1))
		ELSE
			P.QUANTITY * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD_O.[OVERRIDE_DVD_VALUE]) / ISNULL(fx.[SPOT_RATE], 1)
		END) AS GrossDvdValue

		,
		(CASE WHEN binary_checksum(MSE.DIVIDEND_CCY) = binary_checksum('GBp') THEN
			((P.QUANTITY * ISNULL((DVD_O.[OVERRIDE_DVD_VALUE] / 100), DVD_O.[OVERRIDE_DVD_VALUE]) / ISNULL(fx.[SPOT_RATE], 1)) * (1- ISNULL(SEC.[WITHHOLDING_TAX],0)))
		ELSE
			(P.QUANTITY * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD_O.[OVERRIDE_DVD_VALUE]) / ISNULL(fx.[SPOT_RATE], 1)) * (1- ISNULL(SEC.[WITHHOLDING_TAX],0)) 
		END) AS NetDvdValue

		/*,(CASE WHEN DVD_O.[BBG_EX_DATE] IS NULL THEN DVD.SpecialCumTrades
		ELSE
			(DVD_FUND_O.[OVERRIDE_QUANTITY] * ISNULL(DVD_O.[OVERRIDE_DVD_VALUE], DVD.DvdValue_ExDate) / DVD.SpotRate) * (1- ISNULL(DVD.WithholdingTax,0))
		END)*/ ,0 as SpecialCumTrades

		,WithholdingTax = SEC.WITHHOLDING_TAX 
		,MSE.DIVIDEND_CCY
		,Qtr = DATEPART(QQ, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], DVD_O.OVERRIDE_EX_DATE))
		,Yr = DATEPART(YYYY, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], DVD_O.OVERRIDE_EX_DATE))
		,SpotRate = fx.[SPOT_RATE]
		,Ticker = SEC.TICKER 
		,'Y' as HasOverride
		,SEC.SECURITY_DESCRIPTION 
	FROM 
		Investment.DVD_Overrides		DVD_O
	INNER JOIN
		[dbo].[T_MASTER_POS]			P	ON DVD_O.EDM_SEC_ID = P.EDM_SEC_ID
	INNER JOIN
		[dbo].[T_MASTER_SEC]			SEC ON DVD_O.EDM_SEC_ID = SEC.EDM_SEC_ID
	INNER JOIN
		[dbo].[T_MASTER_FND]			FND ON P.Fund_Short_Name = FND.SHORT_NAME 
	LEFT OUTER  JOIN 
		[dbo].[T_MASTER_SEC_EQUITY]		MSE ON SEC.[EDM_SEC_ID] = MSE.[EDM_SEC_ID]
	LEFT OUTER JOIN 
		[dbo].[T_MASTER_FXRATE]			FX	ON fx.DATE = (SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS])
											AND fx.[FROM_ISO_CURRENCY_CODE]='GBP'
											AND (MSE.DIVIDEND_CCY IS NOT NULL AND FX.[TO_ISO_CURRENCY_CODE] = MSE.DIVIDEND_CCY
												OR MSE.DIVIDEND_CCY IS NULL AND FX.[TO_ISO_CURRENCY_CODE] = SEC.SECURITY_ISO_CCY)
	WHERE
		DVD_O.[BBG_EX_DATE] IS NULL
	AND DVD_O.IsActive = 1
	AND FUND_SHORT_NAME IN ('WIMEIF', 'WIMIFF') --// TODO Parameterise
	AND	P.POSITION_DATE = (SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS])
	
) D

order by ROW_UNIQUE_ID

OFFSET 0 ROWS 

