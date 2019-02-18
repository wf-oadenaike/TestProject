CREATE VIEW "CADIS"."DG_FUNCTION428_RESULTS" AS 
SELECT ET."ICAAPRegisterId",ET."SubmittedByPersonId",ET."SubmittedBy",ET."FinancialYear",ET."ICAAPSubmittedDate",ET."RiskBasedICAAPAmount",ET."ICAAPAmount",ET."DocumentationFolderLink",ET."JoinGUID",ET."ICAAPRegisterCreationDatetime",ET."ICAAPRegisterLastModifiedDatetime" FROM "Access.ManyWho"."ICAAPRegisterReadOnlyVw" ET WITH (NOLOCK)
