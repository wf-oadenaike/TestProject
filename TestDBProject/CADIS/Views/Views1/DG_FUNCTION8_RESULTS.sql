CREATE VIEW "CADIS"."DG_FUNCTION8_RESULTS" AS 
SELECT ET."EBIRegisterUserInteractionId",ET."EBIRegisterId",ET."UserInteractionTypeId",ET."InteractionMessage",ET."InteractionDate",ET."WorkflowVersionGUID",ET."JoinGUID" FROM "Compliance"."EBIRegisterUserInteractions" ET WITH (NOLOCK)
