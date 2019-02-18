CREATE VIEW [Access.ManyWho].[SchedulerWorkflows]
	AS 
SELECT [FlowId]
      ,[FlowName]
      ,[TenantId]
      ,[Player]
  FROM [Scheduler].[Workflows]
