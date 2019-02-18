CREATE VIEW "CADIS"."DG_FUNCTION178_RESULTS" AS 
SELECT ET."RiskRegisterEventId",ET."RiskRegisterId",ET."RiskEventTypeId",ET."RiskEventType",ET."RiskRegisterEventPersonId",ET."RecordedBy",ET."RiskRegisterEventComment",ET."RiskRegisterEventCreationDate",ET."WorkflowVersionGUID",ET."JoinGUID" FROM "Access.ManyWho"."RiskRegisterEventsReadOnlyVw" ET WITH (NOLOCK)
