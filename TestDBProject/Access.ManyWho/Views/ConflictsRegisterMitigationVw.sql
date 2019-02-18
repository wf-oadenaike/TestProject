
CREATE VIEW [Access.ManyWho].[ConflictsRegisterMitigationVw]
AS
SELECT CRM.[ConflictsRegisterMitigationID]
	  ,CRM.[ConflictId]
      ,CRM.[MitigationDetails]
      ,CRM.[CreatedByPersionId]
	  ,p1.[PersonsName] as 'CreatedByPersonName'
      ,CRM.[CreationDate]
  FROM [Compliance].[ConflictsRegisterMitigation] CRM
	INNER JOIN [Core].[Persons] p1
		ON CRM.CreatedByPersionId = p1.PersonId
