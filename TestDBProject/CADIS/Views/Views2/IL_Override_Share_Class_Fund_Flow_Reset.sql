﻿CREATE VIEW "CADIS"."IL_Override_Share_Class_Fund_Flow_Reset" AS 
SELECT V."FUND_SHORT_NAME" AS "Fund Short Name",V."FLOW_TYPE" AS "Flow Type",V."MCID" AS "MCID",V."TRUSTEE" AS "Trustee",V."VALUATION_POINT_DATE" AS "Valuation Point Date",V."VALUATION_POINT_TIME" AS "Valuation Point Time",V."FUND_LONG_NAME" AS "Fund Long Name",V."EXTERNAL_FUND_CODE" AS "External Fund Code",V."FUND_REFERENCE" AS "Fund Reference",V."BROUGHT_FORWARD_POSITION" AS "Brought Forward Position",V."NET_UNIT_MOVEMENT" AS "Net Unit Movement",V."BOOK_CONVERSION_IN" AS "Book Conversion In",V."BOOK_CONVERSION_OUT" AS "Book Conversion Out",V."CONVERSION_FACTOR" AS "Conversion Factor",V."ESTIMATED_CLOSING_BALANCE" AS "Estimated Closing Balance",V."UNIT_DECISION" AS "Unit Decision",V."CASH_DECISION" AS "Cash Decision",V."CARRIED_FORWARD_BALANCE" AS "Carried Forward Balance",V."BOOK_BASIS" AS "Book Basis",V."DECISION_VALUE" AS "Decision Value",V."INSPECIE_FLAG" AS "Inspecie Flag",V."NARRATIVE" AS "Narrative",V."SIGNATORY" AS "Signatory",V."CADIS_SYSTEM_INSERTED" AS "System Inserted",V."CADIS_SYSTEM_UPDATED" AS "System Updated",V."CADIS_SYSTEM_CHANGEDBY" AS "System Changed By",V."CADIS_SYSTEM_PRIORITY" AS "System Priority",V."CADIS_SYSTEM_LASTMODIFIED" AS "System Last Modified",V."CADIS_SYSTEM_TIMESTAMP" FROM "dbo"."T_OVERRIDE_FND_SHARE_CLASS_FLOW_RESET" V
