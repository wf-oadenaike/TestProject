CREATE VIEW "CADIS"."DG_FUNCTION22_RESULTS" AS 
SELECT ET."ConflictsRegisterClientId",ET."ConflictId",ET."ClientSalesforceId",ET."ClientName",ET."CreatedByPersonId",ET."CreationDate",ET."IsActive" FROM "Compliance"."ConflictsRegisterClients" ET WITH (NOLOCK)
