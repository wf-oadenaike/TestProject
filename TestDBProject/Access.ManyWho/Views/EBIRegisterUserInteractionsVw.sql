

CREATE VIEW [Access.ManyWho].[EBIRegisterUserInteractionsVw]
AS
SELECT [EBIRegisterUserInteractionId]
      ,[EBIRegisterId]
      , ui.[UserInteractionTypeId]
	  , uit.[UserInteractionType]
      ,[InteractionMessage]
      ,[InteractionDate]
      ,[WorkflowVersionGUID]
      ,[JoinGUID]
  FROM [Compliance].[EBIRegisterUserInteractions] ui
  LEFT JOIN [Compliance].[EBIRegisterUserInteractionTypes] uit
  ON ui.[UserInteractionTypeId] = uit.[UserInteractionTypeId]
