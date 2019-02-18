create view [Access.ManyWho].[TrailCommissionRegisterReadOnlyVw]
as
SELECT [TrailCommissionId]
      ,[MandateName]
      ,[Status]
      ,[ShareClass]
      ,[CommissionRate]
      ,[RegulatorName]
      ,[RegulatorNumber]
      ,[Decision]
      ,y.PersonsName as 'Submitted By'
      ,z.PersonsName as 'Reviewed By'
      ,[ReviewedDate]
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
FROM [Sales].[TrailCommissionRegister] x
		join core.persons y
			on x.SubmittedByPersonId = y.PersonId
		join core.persons z
			on x.ReviewedByPersonId = z.PersonId
