create view [Access.ManyWho].[ClientPricingApprovalEventsReadOnlyVw]
as
SELECT [ClientPricingApprovalEventId]
      ,[ClientPricingApprovalId]
      ,[EventDetails]
      ,y.PersonsName as 'Submitted By'
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Sales].[ClientPricingApprovalEvents] x
		inner join core.persons y
			on x.SubmittedByPersonId = y.PersonsName
