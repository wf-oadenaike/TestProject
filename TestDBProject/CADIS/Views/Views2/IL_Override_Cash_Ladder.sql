﻿CREATE VIEW "CADIS"."IL_Override_Cash_Ladder" AS 
SELECT V."OVERRIDE_ID" AS "Override ID",V."DESCRIPTION" AS "Description",V."AS_OF_DATE" AS "As Of Date", J3.DF AS "Currency",V."ACTIVE" AS "Active",V."COMMENTS" AS "Comments",V."CADIS_SYSTEM_INSERTED" AS "Inserted Date",V."CADIS_SYSTEM_UPDATED" AS "Updated Date",V."CADIS_SYSTEM_CHANGEDBY" AS "Changed By" FROM "dbo"."T_OVERRIDE_CASH_LADDER" V LEFT OUTER JOIN (SELECT DISTINCT "ISO_CCY_CD" AS JF,"ISO_CCY_CD" AS DF FROM "CADIS"."VW_Reference_Currency")  J3 ON  J3.JF=V."CCY"