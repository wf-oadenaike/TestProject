
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [Access.ManyWho].[ConflictRegisterMeetingsVw]
AS
SELECT CRM.[ConflictId]
	  ,CRM.[ConflictsRegisterMeetingID]
      ,CRM.[MeetingDate]
      ,CRM.[MeetingOutcome]
      ,CRM.[CreatedByPersionId]
	  ,p1.[PersonsName] as 'CreatedByPersonName'
      ,CRM.[CreationDate]
	  ,CRM.[JIRAIssueKey]
  FROM [Compliance].[ConflictsRegisterMeetings] CRM
	INNER JOIN [Core].[Persons] p1
		ON p1.PersonId = CRM.CreatedByPersionId
