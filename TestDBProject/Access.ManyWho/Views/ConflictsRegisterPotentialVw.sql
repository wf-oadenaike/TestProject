CREATE VIEW [Access.ManyWho].[ConflictsRegisterPotentialVw]
AS
SELECT crp.[ConflictId]
      ,crp.[NotifyingPersonId]
      ,crp.[ConflictEntryDate]
      ,crp.[PotentialConflictSummary] AS PotentialConflictSummary
      ,crp.[PotentialConflictDetails]
      ,crp.[RecognitionDate]
	  ,crp.[JIRAIssueKey]
      ,crp.[WorkflowVersionGUID]
      ,crp.[JoinGUID]
      ,crp.[CreatedByPersonId]
  FROM [Compliance].[ConflictsRegisterPotential] crp
