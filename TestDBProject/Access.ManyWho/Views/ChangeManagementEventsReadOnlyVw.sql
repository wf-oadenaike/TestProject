CREATE VIEW [Access.ManyWho].[ChangeManagementEventsReadOnlyVw]
	AS 

SELECT [ChangeManagementEventID]
      ,[ChangeManagementID]
      ,cmet.ChangeManagementEventType
      ,p.PersonsName as SubmittedBy
      ,[EventDetails]
      ,[EventDate]
      ,[EventTrueFalse]
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[ChangeManagementEventCreationDatetime]
      ,[ChangeManagementEventLastModifiedDatetime]
FROM [ChangeManagement].[ChangeManagementEvents] cme
		inner join core.Persons p
			on cme.SubmittedByPersonID = p.PersonId
		left join ChangeManagement.ChangeManagementEventTypes cmet
			on cme.ChangeManagementEventTypeID = cmet.ChangeManagementEventTypeId
