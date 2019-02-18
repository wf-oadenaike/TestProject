CREATE VIEW [Access.ManyWho].[SchedulerWorkflowParameters]
	AS 
SELECT [Id]
      ,[WorkflowLaunchId]
      ,[Key] AS [ValueName]
      ,[Value]
      ,[ContentType]
	  ,[JoinGUID]
  FROM [Scheduler].[WorkflowParameters]
