CREATE VIEW "CADIS"."DG_FUNCTION571_RESULTS" AS 
SELECT ET."Type",ET."Id",ET."PolicyName",ET."Version",ET."Status",ET."LastReviewDate",ET."NextReviewDate",ET."PersonId",ET."PersonsName",ET."IsActive",ET."LATE" FROM "dbo"."V_POLICY_PROC" ET WITH (NOLOCK)
