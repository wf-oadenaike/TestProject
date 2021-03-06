﻿
CREATE VIEW [dbo].[T_BPS_PRICE_VIEW]
AS
SELECT [FILE_NAME], [DATE], [IDENTIFIER], 
	  CAST(
	  ( CASE
	  -- Cater for daylight saving times
		WHEN CONVERT(TIME, [DATE]) > CONVERT(TIME, '11:59:00') AND CONVERT(TIME, [DATE]) < CONVERT(TIME, '12:10:00') OR CONVERT(TIME, [DATE]) > CONVERT(TIME, '10:59:00') AND CONVERT(TIME, [DATE]) < CONVERT(TIME, '11:10:00') THEN 'Midday Mid'
		WHEN CONVERT(TIME, [DATE]) > CONVERT(TIME, '17:00:00') AND CONVERT(TIME, [DATE]) < CONVERT(TIME, '18:00:00') THEN 'EOD'
		ELSE 'Live'
	  END )
	   AS VARCHAR(50)) AS  [PRICE_TYPE]
      ,CAST('BBG' AS VARCHAR(50)) AS  [PRICE_SOURCE]
      ,CAST(CONVERT(DATE, [DATE]) AS DATETIME) AS  [PRICE_DATE]
      ,CAST(CONVERT(TIME, [DATE]) AS VARCHAR(50)) AS  [PRICE_TIME]
      ,CAST([AVG_COST] AS VARCHAR(20)) AS [AVERAGE_COST]
      ,CAST(NULL AS INT) AS  [PRICE_SOURCE_RANKING]
      ,CAST([CRNCY] AS VARCHAR(3)) AS  [PRICE_ISO_CCY]
      ,(CASE WHEN ISNUMERIC([PX_LAST]) = 1 THEN CONVERT(DECIMAL(24,10), [PX_LAST]) END) AS  [MASTER_PRICE]
      ,(CASE WHEN ISNUMERIC([PX_ASK]) = 1 THEN CONVERT(DECIMAL(24,10), [PX_ASK]) END) AS [ASK_PRICE]
      ,(CASE WHEN ISNUMERIC([PX_MID]) = 1 THEN CONVERT(DECIMAL(24,10), [PX_MID]) END) AS [MID_PRICE]
      ,(CASE WHEN ISNUMERIC([PX_BID]) = 1 THEN CONVERT(DECIMAL(24,10), [PX_BID]) END) AS [BID_PRICE]
      ,CAST((CASE WHEN ISDATE([DATE_OF_LAST_UPDATE]) = 1 THEN [DATE_OF_LAST_UPDATE] END) AS DATETIME) AS  [LAST_UPDATE_DATE]
      ,CAST((CASE WHEN ISNUMERIC([FX_MARKET_SPOT_DATE]) = 1 THEN [FX_MARKET_SPOT_DATE] END) AS DECIMAL(18,4)) AS  [FX_RATE]
      ,CAST(NULL AS DECIMAL(18,2)) AS  [MARKET_VALUE]
      ,CAST(NULL AS VARCHAR(26)) AS  [TICKER]
	  ,pvt.[CADIS_SYSTEM_UPDATED] AS [CADIS_SYSTEM_UPDATED]
FROM 
(SELECT [FILE_NAME]
      ,[DATE]
      ,[IDENTIFIER]
      ,[FIELD]
	  ,[VALUE]
	  ,[CADIS_SYSTEM_UPDATED]
FROM [dbo].[T_BPS_PRICE]) p
PIVOT
(
	MIN([VALUE])
FOR [FIELD] IN
( 
	[PX_LAST],
	[PX_BID],
	[PX_MID],
	[PX_ASK],
	[AVG_COST],
	[DATE_OF_LAST_UPDATE],
	[FX_MARKET_SPOT_DATE],
	[CRNCY]
 )
) AS pvt
WHERE [PX_LAST] IS NOT NULL
