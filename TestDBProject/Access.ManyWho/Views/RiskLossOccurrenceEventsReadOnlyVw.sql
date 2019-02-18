CREATE view [Access.ManyWho].[RiskLossOccurrenceEventsReadOnlyVw]
as
SELECT [LossOccurrenceEventId]
      ,[LossOccurrenceid]
      ,[EventDetails]
      ,[EventType]
      ,[EventDate]
      ,[IsActive]
      ,y.PersonsName as 'SubmittedBy'
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Risk].[RiskLossOccurrenceEvents] x
		join core.persons y
			on x.submittedbypersonid = y.PersonId
