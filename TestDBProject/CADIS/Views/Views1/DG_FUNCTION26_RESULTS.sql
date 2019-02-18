CREATE VIEW "CADIS"."DG_FUNCTION26_RESULTS" AS 
SELECT ET."ConflictsRegisterUserInteractionId",ET."ConflictId",ET."UserInteractionTypeId",ET."InteractionMessage",ET."InteractionDate",ET."WorkflowVersionGUID",ET."JoinGUID" FROM "Compliance"."ConflictsRegisterUserInteractions" ET WITH (NOLOCK)
