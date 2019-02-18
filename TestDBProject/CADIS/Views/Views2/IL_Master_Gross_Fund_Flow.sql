﻿CREATE VIEW "CADIS"."IL_Master_Gross_Fund_Flow" AS 
SELECT V."FUND_SHORT_NAME" AS "Fund Short Name",V."TRANSACTION_DATE" AS "Transaction Date",V."CURRENCY" AS "Currency",V."FUND_FLOW_TYPE" AS "Fund Flow Type",V."FLOW_TYPE" AS "Flow Type",V."SOURCE_TYPE" AS "Source Type",V."SETTLEMENT_DATE" AS "Settlement Date",V."MARKET_VALUE" AS "Market Value",V."CADIS_SYSTEM_INSERTED" AS "System Inserted",V."CADIS_SYSTEM_UPDATED" AS "System Updated",V."CADIS_SYSTEM_CHANGEDBY" AS "System Changed By",V."CADIS_SYSTEM_PRIORITY" AS "System Priority",V."CADIS_SYSTEM_LASTMODIFIED" AS "System Last Modified" FROM "dbo"."T_MASTER_GROSS_FUND_FLOW" V
