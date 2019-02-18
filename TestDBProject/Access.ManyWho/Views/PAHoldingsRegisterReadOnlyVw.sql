CREATE view [Access.ManyWho].[PAHoldingsRegisterReadOnlyVw]
as
SELECT [PAHoldingRegisterId]
      ,[SecurityName]
      ,[SecurityType]
      ,[SecurityIdentifier]
      ,y.personsname as 'OwnerName'
      ,[Active]
      ,[InActiveDate]
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[PAHoldingCreationDatetime]
      ,[PAHoldingLastModifiedDatetime]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Compliance].[PAHoldingsRegister] x
		join core.persons y
			on x.OwnerId = y.PersonId
