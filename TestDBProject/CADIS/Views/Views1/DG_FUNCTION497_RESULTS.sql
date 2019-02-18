CREATE VIEW "CADIS"."DG_FUNCTION497_RESULTS" AS 
SELECT ET."CompanyEventId",ET."CompanyId",ET."SubmittedByPersonId",ET."EventDetails",ET."EventDateTime",ET."Description",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Unquoted"."InvestmentCompanyEvents" ET WITH (NOLOCK)
