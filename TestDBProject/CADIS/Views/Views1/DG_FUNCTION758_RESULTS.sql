CREATE VIEW "CADIS"."DG_FUNCTION758_RESULTS" AS 
SELECT ET."DocumentType",ET."Id",ET."PolicyName",ET."Version",ET."Status",ET."ReviewFrequencyName",ET."LastReviewDate",ET."NextReviewDate",ET."OwnerRole",ET."OwnerPersonId",ET."OwnerPerson",ET."OwnerDepartment",ET."CategoryDescription",ET."RAGStatus" FROM "Access.ManyWho"."PolicyProcDocumentReviewOverDueVw" ET WITH (NOLOCK)
