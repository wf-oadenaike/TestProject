CREATE VIEW "CADIS"."IL_PolicyProcDocumentReviewOverDueVw" AS 
SELECT V."PolicyName" AS "Policy Name",V."Version" AS "Version",V."Status" AS "Status",V."LastReviewDate" AS "Last Review Date",V."NextReviewDate" AS "Next Review Date",V."OwnerPerson" AS "Owner" FROM "Access.WebDev"."PolicyProcDocumentReviewOverDueVw" V
