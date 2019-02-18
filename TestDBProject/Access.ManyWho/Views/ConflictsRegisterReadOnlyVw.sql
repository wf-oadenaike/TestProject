




CREATE VIEW [Access.ManyWho].[ConflictsRegisterReadOnlyVw] AS
SELECT CR.[ConflictId]
	,CR.[ConflictStatusId]
	,cfs.[FlowStatusName]
	,CR.[CreatedByPersonId]
	,p1.PersonsName as 'CreatedByPersonName'
	,CR.[NotifyingPersonId]
	,p2.PersonsName as 'NotifyingPersonName'
	,CR.[ConflictEntryDate]
	,CR.[RecognitionDate]
	,CR.[PotentialConflictSummary]
	,CR.[PotentialConflictDetails]
	,CR.[ConflictCategory1ID]
	,cc1.[ConflictsRegisterCategory] as 'ConflictsCategory1Name'
	,CR.[ConflictCategory2ID]
	,cc2.[ConflictsRegisterCategory] as 'ConflictsCategory2Name'
	,CR.[HuddleEventID]
	,CR.[DocumentationLink]
	,d.[DepartmentName]
	,CR.[NextReviewDate]
	,CR.[ConflictClosedDate]
	,CR.CADIS_SYSTEM_INSERTED
	,CR.CADIS_SYSTEM_UPDATED
	,CR.CADIS_SYSTEM_CHANGEDBY
FROM [Compliance].[ConflictsRegisterPotential] CR
	INNER JOIN [Core].[Persons] p1
		ON CR.CreatedByPersonId = p1.PersonId
	LEFT OUTER JOIN [Core].[Persons] p2
		ON CR.NotifyingPersonId = p2.PersonId
	LEFT OUTER JOIN [Compliance].[ConflictsRegisterCategories] cc1
		ON CR.ConflictCategory1ID = cc1.[ConflictsRegisterCategoryId]
	LEFT OUTER JOIN [Compliance].[ConflictsRegisterCategories] cc2
		ON CR.ConflictCategory2ID = cc2.[ConflictsRegisterCategoryId]
	LEFT OUTER JOIN [Core].[FlowStatus] cfs
		ON CR.ConflictStatusId = cfs.[FlowStatusId]
	LEFT OUTER JOIN [Core].[Departments] d
		ON d.[DepartmentID] = p2.[DepartmentID]


/* end of new view [Access.ManyWho].[ConflictsRegisterReadOnlyVw] */
--------------------------------------------------------



