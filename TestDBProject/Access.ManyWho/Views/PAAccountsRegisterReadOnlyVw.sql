CREATE view [Access.ManyWho].[PAAccountsRegisterReadOnlyVw]
as
SELECT [PAAccountRegisterId]
      ,[AccountName]
      ,[AccountNumber]
      ,[Entity]
      ,y.personsname as 'OwnerName'
      ,[Active]
      ,[InActiveDate]
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[PAAccountCreationDatetime]
      ,[PAAccountLastModifiedDatetime]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
FROM [Compliance].[PAAccountsRegister] x
		join core.persons y
			on x.OwnerId = y.PersonId
