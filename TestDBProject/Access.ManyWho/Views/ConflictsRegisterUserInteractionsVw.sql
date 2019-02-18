CREATE VIEW [Access.ManyWho].[ConflictsRegisterUserInteractionsVw]
AS
SELECT [ConflictsRegisterUserInteractionId]
      ,[ConflictId]
      ,crui.[UserInteractionTypeId]
	  ,cruit.[UserInteractionType]
      ,[InteractionMessage]
      ,[InteractionDate]
      ,[WorkflowVersionGUID]
      ,[JoinGUID]
  FROM [Compliance].[ConflictsRegisterUserInteractions] crui
  LEFT JOIN [Compliance].[ConflictsRegisterUserInteractionTypes] cruit ON crui.[UserInteractionTypeId] = cruit.[UserInteractionTypeId]
