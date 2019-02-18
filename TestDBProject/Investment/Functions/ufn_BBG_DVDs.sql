-- Table Value Function
CREATE FUNCTION [Investment].[ufn_BBG_DVDs]()

RETURNS @BBG_DVDs TABLE
(
	[ROW_UNIQUE_ID] [bigint] NULL,
	[EDM_SEC_ID] [int] NULL,
	[SecurityName] [varchar](100) NULL,
	[FundShortName] [varchar](50) NULL,
	[ExDate] [date] NULL,
	[DvdValue_ExDate] [decimal](20, 6) NULL,
	[Quantity_ExDate] [decimal](20, 6) NULL,
	[Quantity_LastDate] [decimal](20, 6) NULL,
	[Position_LastDate] [date] NULL,
	[Quantity_FirstDate] [decimal](20, 6) NULL,
	[Position_FirstDate] [date] NULL,
	[Ticker] [varchar](26) NULL,
	[Quantity_DvdCalc] [decimal](20, 6) NULL,
	[GrossDvdValue] [decimal](38, 6) NULL,
	[NetDvdValue] [decimal](38, 6) NULL,
	[SpecialCumTrades] [int] NOT NULL,
	[WithholdingTax] [decimal](26, 6) NOT NULL,
	[DvdCCY] [varchar](10) NULL,
	[Qtr] [int] NULL,
	[Yr] [int] NULL,
	[SpotRate] [decimal](24, 16) NOT NULL,
	[IsActive] [int] NOT NULL
)
AS

-------------------------------------------------------------------------------------- 
-- Name:			[Investment].[ufn_BBG_DVDs]
-- 
-- Params:			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
-- D.Bacchus:		28/06/2017			JIRA: DAP-1150 used in View: [Investment].[Recalc_Overrides]
--
-- 
-------------------------------------------------------------------------------------- 
 
BEGIN

	DECLARE @currentDate AS DATETIME

	SET @currentDate = (SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS])


	INSERT INTO @BBG_DVDs

	SELECT
		ROW_NUMBER() OVER(ORDER BY XX.EDM_SEC_ID ASC) AS ROW_UNIQUE_ID 
		,XX.[EDM_SEC_ID]
		,XX.SecurityName 
		,XX.FundShortName
		,XX.ExDate
		,XX.DvdValue_ExDate
		,XX.Quantity_ExDate
		,XX.Quantity_LastDate
		,XX.Position_LastDate
		,XX.Quantity_FirstDate
		,XX.Position_FirstDate
		,XX.Ticker

		,Quantity_DvdCalc = (CASE WHEN XX.ExDate > XX.Position_LastDate THEN XX.Quantity_LastDate ELSE XX.PrevQuantity END)

		,(
			(CASE WHEN binary_checksum(XX.DvdCCY) = binary_checksum('GBp') THEN
				(CASE WHEN XX.ExDate > XX.Position_LastDate THEN 
					XX.Quantity_LastDate * XX.DvdValue_ExDate / XX.SpotRate
				ELSE XX.PrevQuantity * XX.DvdValue_ExDate / XX.SpotRate 
				END) / 100

			ELSE
				(CASE WHEN XX.ExDate > XX.Position_LastDate THEN 
					XX.Quantity_LastDate * XX.DvdValue_ExDate / XX.SpotRate
				ELSE XX.PrevQuantity * XX.DvdValue_ExDate / XX.SpotRate END)
			END)

		) AS GrossDvdValue

		,(
			(CASE WHEN binary_checksum(XX.DvdCCY) = binary_checksum('GBp') THEN
				(CASE WHEN XX.ExDate > XX.Position_LastDate THEN 
					XX.Quantity_LastDate * XX.DvdValue_ExDate / XX.SpotRate * ( 1-ISNULL(XX.WithholdingTax,0) )
				ELSE XX.PrevQuantity * XX.DvdValue_ExDate / XX.SpotRate * ( 1-ISNULL(XX.WithholdingTax,0) ) END) / 100

			ELSE
				(CASE WHEN XX.ExDate > XX.Position_LastDate THEN 
					XX.Quantity_LastDate * XX.DvdValue_ExDate / XX.SpotRate * ( 1-ISNULL(XX.WithholdingTax,0) )
				ELSE XX.PrevQuantity * XX.DvdValue_ExDate / XX.SpotRate * ( 1-ISNULL(XX.WithholdingTax,0) ) END)
			END)
		) AS NetDvdValue

		,XX.SpecialCumTrades
		,XX.WithholdingTax
		,XX.DvdCCY
		,XX.Qtr
		,XX.Yr
		,XX.SpotRate
		,1 as IsActive
	FROM
	(
		/*
			Calculate dividends for current investment scope. ie period of holding.
			Need special cum stuff!
		*/
		SELECT 
			bdh.[EDM_SEC_ID]
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
			,ISNULL(fx.[SPOT_RATE], 1) AS SpotRate
			,ms.Ticker
		FROM 
			investment.ufn_DVD_Framework() bdh 
		INNER JOIN
			investment.ufn_POS_FirstHeld() pfh ON pfh.[EDM_SEC_ID] = bdh.[EDM_SEC_ID] AND pfh.FUND_SHORT_NAME = bdh.FUND_SHORT_NAME

		LEFT OUTER JOIN
			[dbo].[T_MASTER_POS] mp ON bdh.[EDM_SEC_ID] = mp.[EDM_SEC_ID]
									AND bdh.ExDate = mp.[POSITION_DATE] AND bdh.FUND_SHORT_NAME = mp.FUND_SHORT_NAME
		INNER JOIN 
			[dbo].[T_MASTER_SEC] ms ON ms.[EDM_SEC_ID] = bdh.[EDM_SEC_ID]
		INNER JOIN 
			T_MASTER_SEC_EQUITY mse ON ms.[EDM_SEC_ID] = mse.[EDM_SEC_ID]
		LEFT OUTER JOIN 
			[dbo].[T_MASTER_FXRATE] fx	ON fx.DATE = @currentDate
										AND fx.[FROM_ISO_CURRENCY_CODE]='GBP'
										AND (mse.DIVIDEND_CCY IS NOT NULL AND fx.[TO_ISO_CURRENCY_CODE] = mse.DIVIDEND_CCY
											OR mse.DIVIDEND_CCY IS NULL AND fx.[TO_ISO_CURRENCY_CODE] = ms.SECURITY_ISO_CCY)
		WHERE
			CAST(bdh.ExDate AS DATE) >= pfh.Position_FirstDate
	) XX
	WHERE
		XX.ExDate IS NOT NULL --WEIRD! NATIONAL GRID PLC has a null ex-date, investigate
	
	RETURN

END

