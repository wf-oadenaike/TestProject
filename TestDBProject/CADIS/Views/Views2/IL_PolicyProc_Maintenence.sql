CREATE VIEW "CADIS"."IL_PolicyProc_Maintenence" AS 
SELECT V."Type" AS "Type",V."PolicyName" AS "Policy Name",V."Version" AS "Version",V."Status" AS "Status",V."LastReviewDate" AS "Last Review Date",V."NextReviewDate" AS "Next Review Date",V."OwnerPerson" AS "Owner",V."IsActive" AS "Active" FROM "dbo"."V_POLICY_PROC" V
