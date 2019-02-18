


/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [Access.ManyWho].[ConflictRegisterActionsVw]
AS
SELECT CRA.[ConflictsRegisterActionId]
      ,CRA.[ConflictId]
      ,CRA.[ActionTypeId]
	  ,crat.[ActionType]
      ,CRA.[ActionDate]
      ,CRA.[ActionComment]
      ,CRA.[CreatedByPersonId]
	  ,p1.[PersonsName] as 'CreatedByPersonName'
      ,CRA.[CreationDate]
	  ,CRA.[JIRAIssueKey]
	  ,CRA.IsActive
	  ,CRA.CADIS_SYSTEM_INSERTED
	  ,CRA.CADIS_SYSTEM_UPDATED
	  ,CRA.CADIS_SYSTEM_CHANGEDBY
  FROM [Compliance].[ConflictsRegisterActions] CRA
	INNER JOIN [Compliance].[ConflictsRegisterActionTypes] crat
		ON CRA.[ActionTypeId] = crat.[ActionTypeId]
	INNER JOIN [Core].[Persons] p1
		ON p1.[PersonId] = CRA.[CreatedByPersonId]
	



