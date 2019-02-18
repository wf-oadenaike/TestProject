﻿
CREATE VIEW [dbo].[VW_MASTER_FUND_FLOW_DISCREPANCY]
AS

SELECT	TOP 100000 GROSS.FUND_SHORT_NAME, 
		GROSS.TRANSACTION_DATE, 
		GROSS.CURRENCY, 
		GROSS.SOURCE_TYPE, 
		NET.MARKET_VALUE as NT_IOO_MARKET_VALUE, 
		GROSS.MARKET_VALUE AS TA_MARKET_VALUE,
		ABS(ISNULL(GROSS.MARKET_VALUE,0) - ISNULL(NET.MARKET_VALUE,0)) AS MARKET_VALUE_DIFFERENCE
FROM
        (
        SELECT FUND_SHORT_NAME, CONVERT(DATE,TRANSACTION_DATE) AS TRANSACTION_DATE, CURRENCY, FUND_FLOW_TYPE, SOURCE_TYPE, SUM((CASE FLOW_TYPE WHEN 'REDEMPTION' THEN -1 ELSE 1 END) * (MARKET_VALUE)) AS MARKET_VALUE
        FROM   T_MASTER_FUND_FLOW
        WHERE  FUND_FLOW_TYPE = 'GROSS' 
        AND           SOURCE_TYPE = 'CONFIRMED'
        GROUP  BY FUND_SHORT_NAME, TRANSACTION_DATE, CURRENCY, FUND_FLOW_TYPE, SOURCE_TYPE
        ) GROSS
LEFT	OUTER JOIN 
		(
		SELECT FUND_SHORT_NAME, CONVERT(DATE,TRANSACTION_DATE) AS TRANSACTION_DATE, CURRENCY, FUND_FLOW_TYPE, SOURCE_TYPE, SUM((CASE FLOW_TYPE WHEN 'REDEMPTION' THEN -1 ELSE 1 END) * (MARKET_VALUE)) AS MARKET_VALUE
		FROM   T_MASTER_FUND_FLOW
		WHERE  FUND_FLOW_TYPE = 'NET' 
		GROUP  BY FUND_SHORT_NAME, TRANSACTION_DATE, CURRENCY, FUND_FLOW_TYPE, SOURCE_TYPE
		) NET
ON		NET.CURRENCY = GROSS.CURRENCY
AND		NET.FUND_SHORT_NAME = GROSS.FUND_SHORT_NAME
AND		NET.TRANSACTION_DATE = GROSS.TRANSACTION_DATE
AND		NET.SOURCE_TYPE = GROSS.SOURCE_TYPE
WHERE	ABS(ISNULL(NET.MARKET_VALUE,0) - GROSS.MARKET_VALUE) > 50
AND		GROSS.TRANSACTION_DATE < CONVERT(DATE,GETDATE())
ORDER	BY TRANSACTION_DATE DESC