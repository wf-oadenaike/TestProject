create view [Access.ManyWho].[TrailCommissionEventsReadOnlyVw]
as
SELECT [TrailCommissionEventId]
      ,[TrailCommissionId]
      ,[EventDetails]
      ,[EventType]
      ,y.PersonsName as 'Submitted By'
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
FROM [Sales].[TrailCommissionEvents] x
		join core.persons y
			on x.submittedbypersonid = y.PersonId
