﻿CREATE VIEW "CADIS"."DG_FUNCTION187_RESULTS" AS 
SELECT ET."VALUATION_POINT_DATE",ET."EXTERNAL_FUND_CODE",ET."FUND_REFERENCE",ET."FUND_SHORT_NAME",ET."FLOW_TYPE",ET."MCID",ET."TRUSTEE",ET."VALUATION_POINT_TIME",ET."FUND_LONG_NAME",ET."BROUGHT_FORWARD_POSITION",ET."NET_UNIT_MOVEMENT",ET."BOOK_CONVERSION_IN",ET."BOOK_CONVERSION_OUT",ET."CONVERSION_FACTOR",ET."ESTIMATED_CLOSING_BALANCE",ET."UNIT_DECISION",ET."CASH_DECISION",ET."CARRIED_FORWARD_BALANCE",ET."BOOK_BASIS",ET."DECISION_VALUE",ET."INSPECIE_FLAG",ET."NARRATIVE",ET."SIGNATORY",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "dbo"."T_OVERRIDE_FND_SHARE_CLASS_FLOW" ET WITH (NOLOCK)
