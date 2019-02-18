

CREATE FUNCTION [Access.WebDev].[ufn_MarketCommentaryWeekly]  
(  
 @CommentaryDate DATE = NULL  
)  
RETURNS @Output TABLE(
		[WeekEnding] [datetime] NULL,
		[CommentaryId] [int] NULL,
		[CommentaryDate] [datetime] NULL,
		[Fund] [varchar](10) NULL,
		[FundCOW] [decimal](20,10) NULL,
		[BenchmarkCOW] [decimal](20,10) NULL,
		[SharePriceClose] [decimal](19,5)  NULL,
		[NAVClose] [decimal](19,5)  NULL,
		[Commentary] [nvarchar](max) NULL,
		[Contrib1Name] [varchar](100) NULL,
		[Contrib1Value] [decimal](20,10) NULL,
		[Contrib2Name] [varchar](100) NULL,
		[Contrib2Value] [decimal](20,10) NULL,
		[Contrib3Name] [varchar](100) NULL,
		[Contrib3Value] [decimal](20,10) NULL,
		[Contrib4Name] [varchar](100) NULL,
		[Contrib4Value] [decimal](20,10) NULL,
		[Contrib5Name] [varchar](100) NULL,
		[Contrib5Value] [decimal](20,10) NULL,
		[Laggard1Name] [varchar](100) NULL,
		[Laggard1Value] [decimal](20,10) NULL,
		[Laggard2Name] [varchar](100) NULL,
		[Laggard2Value] [decimal](20,10) NULL,
		[Laggard3Name] [varchar](100) NULL,
		[Laggard3Value] [decimal](20,10) NULL,
		[Laggard4Name] [varchar](100) NULL,
		[Laggard4Value] [decimal](20,10) NULL,
		[Laggard5Name] [varchar](100) NULL,
		[Laggard5Value] [decimal](20,10) NULL,
		AsAtDate [datetime] NULL,
		AsOfDate [datetime] NULL
		)
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Investment].[ufn_MarketCommentaryWeekly]
-- 
-- Params:			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
--R.DIXON:		30/10/2017			DAP-1406 initial version to return market commentary and weekly performance data for Woodford funds.
--R.DIXON:		20/11/2017			DAP-1539 Added the CADIS_SYSTEM_LASTMODIFIED field from the Investment.MarketCommentary tabl
-- 
-------------------------------------------------------------------------------------- 
BEGIN

IF	@CommentaryDate IS NULL
		SET @CommentaryDate = (SELECT MAX(CAST(CommentaryDate as date)) FROM [Investment].[MarketCommentary] WHERE    CommentaryType = 'Weekly');

-- WIMEIF
WITH CON_CTE AS
(
SELECT TOP 5 ASSET_NAME, TOTAL_RTN_PORT, ROW_NUMBER() OVER(ORDER  BY ISNULL(TOTAL_RTN_PORT,0) DESC) as ROWNUM
FROM   T_BBG_FUND_PERFORMANCE_ATTRIBUTION
WHERE  CAST(END_DATE AS DATE) = @CommentaryDate
AND           FUND_SHORT_NAME = 'WIMEIF'
ORDER  BY ISNULL(TOTAL_RTN_PORT,0) DESC
)
, LAG_CTE AS
(
SELECT TOP 5 ASSET_NAME, TOTAL_RTN_PORT, ROW_NUMBER() OVER(ORDER  BY ISNULL(TOTAL_RTN_PORT,0) ASC) as ROWNUM
FROM   T_BBG_FUND_PERFORMANCE_ATTRIBUTION
WHERE  CAST(END_DATE AS DATE) = @CommentaryDate
AND           FUND_SHORT_NAME = 'WIMEIF'
ORDER  BY ISNULL(TOTAL_RTN_PORT,0) ASC
)
  INSERT INTO @Output  
  (		[WeekEnding],
		[CommentaryId],
		[CommentaryDate],
		[Fund],
		[FundCOW],
		[BenchmarkCOW],
		[SharePriceClose],
		[NAVClose],
		[Commentary],
		[Contrib1Name],
		[Contrib1Value],
		[Contrib2Name],
		[Contrib2Value],
		[Contrib3Name],
		[Contrib3Value],
		[Contrib4Name],
		[Contrib4Value],
		[Contrib5Name],
		[Contrib5Value],
		[Laggard1Name],
		[Laggard1Value],
		[Laggard2Name],
		[Laggard2Value],
		[Laggard3Name],
		[Laggard3Value],
		[Laggard4Name],
		[Laggard4Value],
		[Laggard5Name],
		[Laggard5Value],
		AsAtDate, 
		AsOfDate )
SELECT	TOP 1 @CommentaryDate AS WeekEnding,
		mc.CommentaryId,
		@CommentaryDate AS CommentaryDate,
		'WIMEIF' AS Fund,
		FUND.FundCOW,
		FUND.BenchmarkCOW,
		NULL AS SharePriceClose,
		NULL AS NAVClose,
		mc.Commentary,
		CON1.ASSET_NAME AS Contrib1Name,
		CON1.TOTAL_RTN_PORT AS Contrib1Value,
		CON2.ASSET_NAME AS Contrib2Name,
		CON2.TOTAL_RTN_PORT AS Contrib2Value,
		CON3.ASSET_NAME AS Contrib3Name,
		CON3.TOTAL_RTN_PORT AS Contrib3Value,
		CON4.ASSET_NAME AS Contrib4Name,
		CON4.TOTAL_RTN_PORT AS Contrib4Value,
		CON5.ASSET_NAME AS Contrib5Name,
		CON5.TOTAL_RTN_PORT AS Contrib5Value,
		LAG1.ASSET_NAME AS Laggard1Name,
		LAG1.TOTAL_RTN_PORT AS Laggard1Value,
		LAG2.ASSET_NAME AS Laggard2Name,
		LAG2.TOTAL_RTN_PORT AS Laggard2Value,
		LAG3.ASSET_NAME AS Laggard3Name,
		LAG3.TOTAL_RTN_PORT AS Laggard3Value,
		LAG4.ASSET_NAME AS Laggard4Name,
		LAG4.TOTAL_RTN_PORT AS Laggard4Value,
		LAG5.ASSET_NAME AS Laggard5Name,
		LAG5.TOTAL_RTN_PORT AS Laggard5Value,
		mc.CADIS_SYSTEM_LASTMODIFIED,
		mc.CommentaryDate
FROM   Investment.MarketCommentary mc
LEFT   OUTER JOIN 
        (
        SELECT MAX(FUND_TOTAL_RTN_BENCH) AS BenchmarkCOW,
                    MAX(FUND_TOTAL_RTN_PORT) AS FundCOW,
                    MAX(CAST(END_DATE AS DATE)) AS CommentaryDate
        FROM   T_BBG_FUND_PERFORMANCE_ATTRIBUTION
        WHERE  CAST(END_DATE AS DATE) = @CommentaryDate
        AND           FUND_SHORT_NAME = 'WIMEIF'
        ) FUND
ON		FUND.CommentaryDate = CAST(mc.CommentaryDate AS DATE)
LEFT	OUTER JOIN CON_CTE CON1
ON		CON1.ROWNUM = 1
LEFT	OUTER JOIN CON_CTE CON2
ON		CON2.ROWNUM = 2
LEFT	OUTER JOIN CON_CTE CON3
ON		CON3.ROWNUM = 3
LEFT	OUTER JOIN CON_CTE CON4
ON		CON4.ROWNUM = 4
LEFT	OUTER JOIN CON_CTE CON5
ON		CON5.ROWNUM = 5
LEFT	OUTER JOIN LAG_CTE LAG1
ON		LAG1.ROWNUM = 1
LEFT	OUTER JOIN LAG_CTE LAG2
ON		LAG2.ROWNUM = 2
LEFT	OUTER JOIN LAG_CTE LAG3
ON		LAG3.ROWNUM = 3
LEFT	OUTER JOIN LAG_CTE LAG4
ON		LAG4.ROWNUM = 4
LEFT	OUTER JOIN LAG_CTE LAG5
ON		LAG5.ROWNUM = 5
WHERE  mc.CommentaryType= 'Weekly'
AND    CAST(mc.CommentaryDate AS DATE) = @CommentaryDate
ORDER	BY mc.CommentaryDate DESC
;
-- WIMIFF
WITH CON_CTE AS
(
SELECT TOP 5 ASSET_NAME, TOTAL_RTN_PORT, ROW_NUMBER() OVER(ORDER  BY ISNULL(TOTAL_RTN_PORT,0) DESC) as ROWNUM
FROM   T_BBG_FUND_PERFORMANCE_ATTRIBUTION
WHERE  CAST(END_DATE AS DATE) = @CommentaryDate
AND           FUND_SHORT_NAME = 'WIMIFF'
ORDER  BY ISNULL(TOTAL_RTN_PORT,0) DESC
)
, LAG_CTE AS
(
SELECT TOP 5 ASSET_NAME, TOTAL_RTN_PORT, ROW_NUMBER() OVER(ORDER  BY ISNULL(TOTAL_RTN_PORT,0) ASC) as ROWNUM
FROM   T_BBG_FUND_PERFORMANCE_ATTRIBUTION
WHERE  CAST(END_DATE AS DATE) = @CommentaryDate
AND           FUND_SHORT_NAME = 'WIMIFF'
ORDER  BY ISNULL(TOTAL_RTN_PORT,0) ASC
)
  INSERT INTO @Output  
  (		[WeekEnding],
		[CommentaryId],
		[CommentaryDate],
		[Fund],
		[FundCOW],
		[BenchmarkCOW],
		[SharePriceClose],
		[NAVClose],
		[Commentary],
		[Contrib1Name],
		[Contrib1Value],
		[Contrib2Name],
		[Contrib2Value],
		[Contrib3Name],
		[Contrib3Value],
		[Contrib4Name],
		[Contrib4Value],
		[Contrib5Name],
		[Contrib5Value],
		[Laggard1Name],
		[Laggard1Value],
		[Laggard2Name],
		[Laggard2Value],
		[Laggard3Name],
		[Laggard3Value],
		[Laggard4Name],
		[Laggard4Value],
		[Laggard5Name],
		[Laggard5Value],
		AsAtDate,
		AsOfDate)
SELECT	TOP 1 @CommentaryDate AS WeekEnding,
		mc.CommentaryId,
		@CommentaryDate AS CommentaryDate,
		'WIMIFF' AS Fund,
		FUND.FundCOW,
		FUND.BenchmarkCOW,
		NULL AS SharePriceClose,
		NULL AS NAVClose,
		mc.Commentary,
		CON1.ASSET_NAME AS Contrib1Name,
		CON1.TOTAL_RTN_PORT AS Contrib1Value,
		CON2.ASSET_NAME AS Contrib2Name,
		CON2.TOTAL_RTN_PORT AS Contrib2Value,
		CON3.ASSET_NAME AS Contrib3Name,
		CON3.TOTAL_RTN_PORT AS Contrib3Value,
		CON4.ASSET_NAME AS Contrib4Name,
		CON4.TOTAL_RTN_PORT AS Contrib4Value,
		CON5.ASSET_NAME AS Contrib5Name,
		CON5.TOTAL_RTN_PORT AS Contrib5Value,
		LAG1.ASSET_NAME AS Laggard1Name,
		LAG1.TOTAL_RTN_PORT AS Laggard1Value,
		LAG2.ASSET_NAME AS Laggard2Name,
		LAG2.TOTAL_RTN_PORT AS Laggard2Value,
		LAG3.ASSET_NAME AS Laggard3Name,
		LAG3.TOTAL_RTN_PORT AS Laggard3Value,
		LAG4.ASSET_NAME AS Laggard4Name,
		LAG4.TOTAL_RTN_PORT AS Laggard4Value,
		LAG5.ASSET_NAME AS Laggard5Name,
		LAG5.TOTAL_RTN_PORT AS Laggard5Value,
		mc.CADIS_SYSTEM_LASTMODIFIED,
		mc.CommentaryDate
FROM   Investment.MarketCommentary mc
LEFT   OUTER JOIN 
        (
        SELECT MAX(FUND_TOTAL_RTN_BENCH) AS BenchmarkCOW,
                    MAX(FUND_TOTAL_RTN_PORT) AS FundCOW,
                    MAX(CAST(END_DATE AS DATE)) AS CommentaryDate
        FROM   T_BBG_FUND_PERFORMANCE_ATTRIBUTION
        WHERE  CAST(END_DATE AS DATE) = @CommentaryDate
        AND           FUND_SHORT_NAME = 'WIMIFF'
        ) FUND
ON		FUND.CommentaryDate = CAST(mc.CommentaryDate AS DATE)
LEFT	OUTER JOIN CON_CTE CON1
ON		CON1.ROWNUM = 1
LEFT	OUTER JOIN CON_CTE CON2
ON		CON2.ROWNUM = 2
LEFT	OUTER JOIN CON_CTE CON3
ON		CON3.ROWNUM = 3
LEFT	OUTER JOIN CON_CTE CON4
ON		CON4.ROWNUM = 4
LEFT	OUTER JOIN CON_CTE CON5
ON		CON5.ROWNUM = 5
LEFT	OUTER JOIN LAG_CTE LAG1
ON		LAG1.ROWNUM = 1
LEFT	OUTER JOIN LAG_CTE LAG2
ON		LAG2.ROWNUM = 2
LEFT	OUTER JOIN LAG_CTE LAG3
ON		LAG3.ROWNUM = 3
LEFT	OUTER JOIN LAG_CTE LAG4
ON		LAG4.ROWNUM = 4
LEFT	OUTER JOIN LAG_CTE LAG5
ON		LAG5.ROWNUM = 5
WHERE  mc.CommentaryType= 'Weekly'
AND    CAST(mc.CommentaryDate AS DATE) = @CommentaryDate
ORDER	BY mc.CommentaryDate DESC

;
-- WIMPCT
WITH CON_CTE AS
(
SELECT TOP 5 ASSET_NAME, TOTAL_RTN_PORT, ROW_NUMBER() OVER(ORDER  BY ISNULL(TOTAL_RTN_PORT,0) DESC) as ROWNUM
FROM   T_BBG_FUND_PERFORMANCE_ATTRIBUTION
WHERE  CAST(END_DATE AS DATE) = @CommentaryDate
AND           FUND_SHORT_NAME = 'WIMPCT'
ORDER  BY ISNULL(TOTAL_RTN_PORT,0) DESC
)
, LAG_CTE AS
(
SELECT TOP 5 ASSET_NAME, TOTAL_RTN_PORT, ROW_NUMBER() OVER(ORDER  BY ISNULL(TOTAL_RTN_PORT,0) ASC) as ROWNUM
FROM   T_BBG_FUND_PERFORMANCE_ATTRIBUTION
WHERE  CAST(END_DATE AS DATE) = @CommentaryDate
AND           FUND_SHORT_NAME = 'WIMPCT'
ORDER  BY ISNULL(TOTAL_RTN_PORT,0) ASC
)
  INSERT INTO @Output  
  (		[WeekEnding],
		[CommentaryId],
		[CommentaryDate],
		[Fund],
		[FundCOW],
		[BenchmarkCOW],
		[SharePriceClose],
		[NAVClose],
		[Commentary],
		[Contrib1Name],
		[Contrib1Value],
		[Contrib2Name],
		[Contrib2Value],
		[Contrib3Name],
		[Contrib3Value],
		[Contrib4Name],
		[Contrib4Value],
		[Contrib5Name],
		[Contrib5Value],
		[Laggard1Name],
		[Laggard1Value],
		[Laggard2Name],
		[Laggard2Value],
		[Laggard3Name],
		[Laggard3Value],
		[Laggard4Name],
		[Laggard4Value],
		[Laggard5Name],
		[Laggard5Value],
		AsAtDate,
		AsOfDate)
SELECT	TOP 1 @CommentaryDate AS WeekEnding,
		mc.CommentaryId,
		@CommentaryDate AS CommentaryDate,
		'WIMPCT' AS Fund,
		FUND.FundCOW,
		FUND.BenchmarkCOW,
		mcd.SharePriceClose,
		mcd.NAVClose,
		mc.Commentary,
		CON1.ASSET_NAME AS Contrib1Name,
		CON1.TOTAL_RTN_PORT AS Contrib1Value,
		CON2.ASSET_NAME AS Contrib2Name,
		CON2.TOTAL_RTN_PORT AS Contrib2Value,
		CON3.ASSET_NAME AS Contrib3Name,
		CON3.TOTAL_RTN_PORT AS Contrib3Value,
		CON4.ASSET_NAME AS Contrib4Name,
		CON4.TOTAL_RTN_PORT AS Contrib4Value,
		CON5.ASSET_NAME AS Contrib5Name,
		CON5.TOTAL_RTN_PORT AS Contrib5Value,
		LAG1.ASSET_NAME AS Laggard1Name,
		LAG1.TOTAL_RTN_PORT AS Laggard1Value,
		LAG2.ASSET_NAME AS Laggard2Name,
		LAG2.TOTAL_RTN_PORT AS Laggard2Value,
		LAG3.ASSET_NAME AS Laggard3Name,
		LAG3.TOTAL_RTN_PORT AS Laggard3Value,
		LAG4.ASSET_NAME AS Laggard4Name,
		LAG4.TOTAL_RTN_PORT AS Laggard4Value,
		LAG5.ASSET_NAME AS Laggard5Name,
		LAG5.TOTAL_RTN_PORT AS Laggard5Value,
		mc.CADIS_SYSTEM_LASTMODIFIED,
		mc.CommentaryDate
FROM	Investment.MarketCommentary mc
LEFT	OUTER JOIN Investment.MarketCommentary mcd
ON		CAST(mcd.CommentaryDate AS DATE) = CAST(mc.CommentaryDate AS DATE)
AND		mcd.CommentaryType = 'Daily'
LEFT   OUTER JOIN 
        (
        SELECT MAX(FUND_TOTAL_RTN_BENCH) AS BenchmarkCOW,
                    MAX(FUND_TOTAL_RTN_PORT) AS FundCOW,
                    MAX(CAST(END_DATE AS DATE)) AS CommentaryDate
        FROM   T_BBG_FUND_PERFORMANCE_ATTRIBUTION
        WHERE  CAST(END_DATE AS DATE) = @CommentaryDate
        AND           FUND_SHORT_NAME = 'WIMPCT'
        ) FUND
ON		FUND.CommentaryDate = CAST(mc.CommentaryDate AS DATE)
LEFT	OUTER JOIN CON_CTE CON1
ON		CON1.ROWNUM = 1
LEFT	OUTER JOIN CON_CTE CON2
ON		CON2.ROWNUM = 2
LEFT	OUTER JOIN CON_CTE CON3
ON		CON3.ROWNUM = 3
LEFT	OUTER JOIN CON_CTE CON4
ON		CON4.ROWNUM = 4
LEFT	OUTER JOIN CON_CTE CON5
ON		CON5.ROWNUM = 5
LEFT	OUTER JOIN LAG_CTE LAG1
ON		LAG1.ROWNUM = 1
LEFT	OUTER JOIN LAG_CTE LAG2
ON		LAG2.ROWNUM = 2
LEFT	OUTER JOIN LAG_CTE LAG3
ON		LAG3.ROWNUM = 3
LEFT	OUTER JOIN LAG_CTE LAG4
ON		LAG4.ROWNUM = 4
LEFT	OUTER JOIN LAG_CTE LAG5
ON		LAG5.ROWNUM = 5
WHERE  mc.CommentaryType= 'Weekly'
AND    CAST(mc.CommentaryDate AS DATE) = @CommentaryDate
ORDER	BY mc.CommentaryDate DESC

RETURN

END

