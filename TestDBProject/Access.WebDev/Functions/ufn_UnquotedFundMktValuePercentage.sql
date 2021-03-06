﻿


CREATE FUNCTION [Access.WebDev].[ufn_UnquotedFundMktValuePercentage]
(
@REPORT_DATE		datetime
)

-------------------------------------------------------------------------------------- 
-- Name: [Access.WebDev].[ufn_UnquotedFundMktValuePercentage]
-- 
-- Params:	@REPORT_DATE	 Business Date to retrieve data for
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon:		04/12/2017 JIRA: DAP-1586 Initial Draft.
-- D.Fanning:	06/12/2017 JIRA: DAP-1586 For WCPT amend TOTAL_UNQUOTED_FUND_MKT_VALUE_PCT to account for NAV - Cash. 
-- R.Dixon:		11/12/2017 JIRA: DAP-1599 Exclude 700000408 from WIMEIF unquoted securities.
-- R.Dixon:		18/01/2018 JIRA: DAP-1710 Remove exclusion for EDM_SEC_ID = 700000372 from OMNIS unquoted securities.
-- R.Dixon:		02/02/2018 JIRA: DAP-1761 Remove exclusion for EDM_SEC_ID = 700000381 from WIMEIF unquoted securities.
-- R.Dixon:		02/02/2018 JIRA: DAP-1831 Added exclusion for EDM_SEC_ID = 700000440,700000439,700000438,700000437,700000436,700000435,700000434 from WIMEIF unquoted securities.
-- Olu:			09/07/2018 JIRA: DAP-2071 Added exclusion for EDM_SEC_ID = 700000480
-- Olu:			08/10/2018 JIRA: DAP-2071 Added exclusion for EDM_SEC_ID =  700000361, 700000306, 700000107
-------------------------------------------------------------------------------------- 


RETURNS @OUTPUT TABLE (
	[FUND_SHORT_NAME] VARCHAR(256) NULL,
	[VALUATION_DATE] DATETIME NULL,
	[TOTAL_UNQUOTED_FUND_MKT_VALUE] DECIMAL(20,10) NULL,
	[TOTAL_FUND_MKT_VALUE] DECIMAL(20,10) NULL,
	[TOTAL_UNQUOTED_FUND_MKT_VALUE_PCT] DECIMAL(20,2) NULL,
	[AsAtDate] DATETIME NULL,
	[AsofDate] DATETIME NULL
	) AS

	BEGIN

	DECLARE @UNQUOTED_FUND_TOTALS TABLE (
	[FUND_SHORT_NAME] VARCHAR(256) NULL,
	[POSITION_DATE] DATETIME NULL,
	[TOTAL_UNQUOTED_FUND_MKT_VALUE] DECIMAL(20,10) NULL,
	[CADIS_SYSTEM_LASTMODIFIED] DATETIME NULL,
	[RELEVANT_DATA_DATE] DATETIME NULL
	)

	IF @REPORT_DATE IS NULL
	SELECT @REPORT_DATE = MAX(POSITION_DATE) FROM [DBO].[T_MASTER_POS]

	INSERT	INTO @OUTPUT([FUND_SHORT_NAME], [VALUATION_DATE], [TOTAL_FUND_MKT_VALUE])
	SELECT	FND.[FUND_SHORT_NAME], 
			FND.[POSITION_DATE], 
			SUM(FND.[TOTAL_ACCRUED_MARKET_VALUE_BASE])
	FROM	[dbo].[T_MASTER_FND_MARKET_VALUE] FND
	WHERE	FND.POSITION_DATE = @REPORT_DATE
	AND		FND.FUND_SHORT_NAME <> 'WIMOFF'
	GROUP	BY FND.[FUND_SHORT_NAME], FND.[POSITION_DATE]
	
	INSERT INTO @UNQUOTED_FUND_TOTALS([FUND_SHORT_NAME], [POSITION_DATE], [TOTAL_UNQUOTED_FUND_MKT_VALUE], [CADIS_SYSTEM_LASTMODIFIED],[RELEVANT_DATA_DATE])
	SELECT	POS.FUND_SHORT_NAME, POS.POSITION_DATE, SUM(PRC.MASTER_PRICE * POS.QUANTITY / PRC.FX_RATE) AS STOCK_FUND_MKT_VALUE, MAX(POS.[CADIS_SYSTEM_LASTMODIFIED]) AS [CADIS_SYSTEM_LASTMODIFIED], POS.POSITION_DATE
	FROM	[DBO].[T_MASTER_PRC] PRC
	INNER	JOIN [DBO].[T_MASTER_POS]  POS
	ON		POS.EDM_SEC_ID = PRC.EDM_SEC_ID
	AND		POS.POSITION_DATE = PRC.PRICE_DATE
	INNER	JOIN [DBO].[T_MASTER_SEC]  SEC
	ON		SEC.EDM_SEC_ID = POS.EDM_SEC_ID
	WHERE	PRC.PRICE_DATE = @REPORT_DATE
	AND		(SEC.TICKER LIKE '%.%' OR SEC.TICKER LIKE '%NWBO%')
	AND		PRC.PRICE_TYPE = 'EOD'
	AND		POS.EDM_SEC_ID NOT IN (SELECT EDM_SEC_ID FROM [dbo].[T_REF_SECURITY_EXCEPTIONS] 
									WHERE   EffectiveDate <= POSITION_DATE
									)
  
	GROUP	BY POS.FUND_SHORT_NAME, POS.POSITION_DATE

	UPDATE	O
	SET		O.TOTAL_UNQUOTED_FUND_MKT_VALUE = U.TOTAL_UNQUOTED_FUND_MKT_VALUE,
			O.TOTAL_UNQUOTED_FUND_MKT_VALUE_PCT =	(CASE WHEN U.FUND_SHORT_NAME = 'WIMPCT' 
														THEN U.TOTAL_UNQUOTED_FUND_MKT_VALUE / (O.TOTAL_FUND_MKT_VALUE - CSH.BASE_VALUE) * 100
														ELSE U.TOTAL_UNQUOTED_FUND_MKT_VALUE / (O.TOTAL_FUND_MKT_VALUE) * 100 END),
			O.AsAtDate = U.CADIS_SYSTEM_LASTMODIFIED,
			O.AsofDate = U.RELEVANT_DATA_DATE
	FROM	@OUTPUT O
	INNER	JOIN @UNQUOTED_FUND_TOTALS U	ON U.FUND_SHORT_NAME = O.FUND_SHORT_NAME
											AND	U.POSITION_DATE = O.VALUATION_DATE
	LEFT JOIN 
		(
			select 
				c.POSITION_DATE, 
				c.FUND_SHORT_NAME, 
				sum(c.BASE_VALUE) BASE_VALUE 
			from 
				dbo.T_MASTER_POS_ACCOUNT_BALANCE c
			where
				c.FUND_SHORT_NAME = 'WIMPCT'
			group by
				c.POSITION_DATE, 
				c.FUND_SHORT_NAME
		) CSH	ON CSH.FUND_SHORT_NAME = O.FUND_SHORT_NAME
				AND	CSH.POSITION_DATE = VALUATION_DATE

	
	RETURN

	END


