CREATE VIEW "CADIS"."DG_FUNCTION212_RESULTS" AS 
SELECT ET."EBIRegisterUserInteractionId",ET."EBIRegisterId",ET."UserInteractionTypeId",ET."UserInteractionType",ET."InteractionMessage",ET."InteractionDate",ET."WorkflowVersionGUID",ET."JoinGUID" FROM "Access.ManyWho"."EBIRegisterUserInteractionsVw" ET WITH (NOLOCK)
