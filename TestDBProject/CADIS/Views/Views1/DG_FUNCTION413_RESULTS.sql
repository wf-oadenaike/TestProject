CREATE VIEW "CADIS"."DG_FUNCTION413_RESULTS" AS 
SELECT ET."ICAAPRegisterId",ET."SubmittedByPersonId",ET."FinancialYear",ET."ICAAPSubmittedDate",ET."RiskBasedICAAPAmount",ET."ICAAPAmount",ET."DocumentationFolderLink",ET."JoinGUID",ET."ICAAPRegisterCreationDatetime",ET."ICAAPRegisterLastModifiedDatetime" FROM "Investment"."ICAAPRegister" ET WITH (NOLOCK)
