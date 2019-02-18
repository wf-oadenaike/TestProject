﻿CREATE VIEW "CADIS"."IL_Unquoted_Investment_Revaluation" AS 
SELECT V."REVALUATION_ID" AS "Revaluation ID",V."FUNDING_ID" AS "Funding  ID", J2.DF AS "Issuer", J3.DF AS "Security ID", J4.DF AS "Revaluation Type", J5.DF AS "Revaluation Sub Type",V."EXPECTED_ENACTMENT_DATE" AS "Expected Date",V."ACTUAL_ENACTMENT_DATE" AS "Actual Date",V."FM_LOW" AS "FM Low",V."FM_HIGH" AS "FM High",V."DP_LOW" AS "D & P Low",V."DP_HIGH" AS "D & P High",V."ACD" AS "ACD", J13.DF AS "Internal Status", J14.DF AS "External Status",V."TECH_STATUS" AS "Complete",V."JiraIssueKey",V."IssuerID" FROM "dbo"."T_UNQUOTED_REVALUATION" V LEFT OUTER JOIN (SELECT DISTINCT "NAME" AS JF,"VALUE" AS DF FROM "dbo"."V_REF_UNQUOTED_ISSUER_LOOKUP")  J2 ON  J2.JF=V."ISSUER" LEFT OUTER JOIN (SELECT DISTINCT "NAME" AS JF,"VALUE" AS DF FROM "dbo"."V_REF_UNQUOTED_SECURITY_LOOKUP")  J3 ON  J3.JF=V."EDM_SEC_ID" LEFT OUTER JOIN (SELECT DISTINCT "NAME" AS JF,"VALUE" AS DF FROM "dbo"."V_REF_UNQUOTED_REVALUATION_TYPE_LOOKUP")  J4 ON  J4.JF=V."REVALUATION_TYPE" LEFT OUTER JOIN (SELECT DISTINCT "NAME" AS JF,"VALUE" AS DF FROM "dbo"."V_REF_UNQUOTED_REVALUATION_SUB_TYPE_LOOKUP")  J5 ON  J5.JF=V."REVALUATION_SUB_TYPE" LEFT OUTER JOIN (SELECT DISTINCT "NAME" AS JF,"VALUE" AS DF FROM "dbo"."V_REF_UNQUOTED_REVALUATION_STATUS_INTERNAL_LOOKUP")  J13 ON  J13.JF=V."STATUS_INTERNAL" LEFT OUTER JOIN (SELECT DISTINCT "NAME" AS JF,"VALUE" AS DF FROM "dbo"."V_REF_UNQUOTED_REVALUATION_STATUS_EXTERNAL_LOOKUP")  J14 ON  J14.JF=V."STATUS_EXTERNAL"