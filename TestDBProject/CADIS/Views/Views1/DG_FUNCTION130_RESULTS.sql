CREATE VIEW "CADIS"."DG_FUNCTION130_RESULTS" AS 
SELECT ET."StopListId",ET."StoppedCompanyName",ET."Ticker",ET."StatusName",ET."StoppedDate",ET."AnticipatedCleansedate",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.ManyWho"."StopListRegisterReadOnlyVw" ET WITH (NOLOCK)
