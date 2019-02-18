CREATE VIEW "CADIS"."DG_FUNCTION566_RESULTS" AS 
SELECT ET."ConflictsRegisterClientId",ET."ConflictId",ET."ClientSalesforceId",ET."ClientName",ET."CreatedByPersonId",ET."CreatedByPersonName",ET."CreationDate",ET."IsActive" FROM "Access.ManyWho"."ConflictsRegisterClients" ET WITH (NOLOCK)
