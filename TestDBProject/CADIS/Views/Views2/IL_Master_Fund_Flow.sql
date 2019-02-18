CREATE VIEW "CADIS"."IL_Master_Fund_Flow" AS 
SELECT V."FUND_SHORT_NAME" AS "Fund Short Name",V."TRANSACTION_DATE" AS "Transaction Date",V."CURRENCY" AS "Currency",V."FUND_FLOW_TYPE" AS "Fund Flow Type",V."FLOW_TYPE" AS "Flow Type",V."SOURCE_TYPE" AS "Source Type",V."MARKET_VALUE" AS "Market Value",V."SOURCE" AS "Source",V."DATA_SOURCE" AS "Data Source" FROM "dbo"."VW_MASTER_FUND_FLOW" V
