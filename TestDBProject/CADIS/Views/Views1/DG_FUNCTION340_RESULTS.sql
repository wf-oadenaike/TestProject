CREATE VIEW "CADIS"."DG_FUNCTION340_RESULTS" AS 
SELECT ET."Type",ET."Id",ET."PolicyName",ET."Version",ET."Status",ET."ReviewFrequencyName",ET."LastReviewDate",ET."NextReviewDate",ET."OwnerRole",ET."OwnerPersonId",ET."OwnerPerson",ET."OwnerDepartment",ET."CategoryDescription" FROM "Access.WebDev"."PolicyProcDocumentReviewOverDueVw" ET WITH (NOLOCK)
