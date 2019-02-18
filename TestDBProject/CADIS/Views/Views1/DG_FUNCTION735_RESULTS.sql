CREATE VIEW "CADIS"."DG_FUNCTION735_RESULTS" AS 
SELECT ET."TensionId",ET."CircleId",ET."TensionSummary",ET."TensionDescription",ET."TensionResolution",ET."ResolutionDate",ET."RaisedByPersonId",ET."JIRAKey",ET."JoinGUID",ET."SlackChannel",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."IsActive" FROM "dbo"."TensionRegister" ET WITH (NOLOCK)
