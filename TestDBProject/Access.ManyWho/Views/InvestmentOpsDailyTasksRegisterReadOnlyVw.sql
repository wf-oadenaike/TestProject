
CREATE VIEW [Access.ManyWho].[InvestmentOpsDailyTasksRegisterReadOnlyVw]

-- DAP-1030 D. Bacchus	added ISACTIVE

as
SELECT [InvestmentOpsDailyTasksRegisterId]
      ,[JIRASummary]
      ,[JIRADescription]
      ,[EpicLink]
      ,[Labels]
	  ,[Type]
      ,[Triggers]
	  ,DelayBeforeLaunch
	  ,TimeBeforeAlert
      ,p1.PersonsName as 'AssignedTo'
      ,p2.PersonsName as 'SubmittedBy'
	  ,Frequency
      ,[DocumentationFolderLink]
      ,[JoinGUID]
	  ,[ISACTIVE]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Operation].[InvestmentOpsDailyTasksRegister] r
		inner join core.persons p1
			on r.AssignedToPersonID = p1.personid
		inner join core.persons p2
			on r.SubmittedByPersonID = p2.personid

