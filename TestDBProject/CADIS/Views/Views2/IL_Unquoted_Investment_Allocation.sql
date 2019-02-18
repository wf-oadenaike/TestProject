﻿CREATE VIEW "CADIS"."IL_Unquoted_Investment_Allocation" AS 
SELECT  J1.DF AS "Fund",V."ALLOCATION" AS "Allocation",V."FUNDING_ID" AS "Funding  ID",V."REVALUATION_ID" AS "Revaluation ID" FROM "dbo"."T_UNQUOTED_ALLOCATION" V LEFT OUTER JOIN (SELECT DISTINCT "NAME" AS JF,"VALUE" AS DF FROM "dbo"."V_REF_UNQUOTED_FUND")  J1 ON  J1.JF=V."FUND_SHORT_NAME"
