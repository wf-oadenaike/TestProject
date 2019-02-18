CREATE VIEW "CADIS"."DG_FUNCTION443_RESULTS" AS 
SELECT ET."ConflictsRegisterUserInteractionId",ET."ConflictId",ET."UserInteractionTypeId",ET."UserInteractionType",ET."InteractionMessage",ET."InteractionDate",ET."WorkflowVersionGUID",ET."JoinGUID" FROM "Access.ManyWho"."ConflictsRegisterUserInteractionsVw" ET WITH (NOLOCK)
