CREATE view [Access.ManyWho].[InvestmentOpsEventsReadOnlyVw]
as
SELECT x.[InvestmentOpsEventId]
      ,x.[InvestmentOpsDailyTasksRegisterId]
      ,x.[InvestmentOpsEventDate]
      ,x.[InvestmentOpsEventStatus]
	  ,y.[Frequency]
	  ,x.[JIRAIssueKey]
      ,x.[JoinGUID]
      ,x.[CADIS_SYSTEM_INSERTED]
      ,x.[CADIS_SYSTEM_UPDATED]
      ,x.[CADIS_SYSTEM_CHANGEDBY]
      ,x.[CADIS_SYSTEM_PRIORITY]
      ,x.[CADIS_SYSTEM_TIMESTAMP]
      ,x.[CADIS_SYSTEM_LASTMODIFIED]
FROM [Operation].[InvestmentOpsEvents] x
		join [Operation].[InvestmentOpsDailyTasksRegister] y
			on x.[InvestmentOpsDailyTasksRegisterId] = y.[InvestmentOpsDailyTasksRegisterId]
