CREATE VIEW [Access.ManyWho].[RiskRegisterEventsVw]
	AS 
SELECT
	   [RiskRegisterEventId]
      ,[RiskRegisterId]
      ,[RiskEventTypeId]
	  ,[RiskRegisterEventPersonId]
      ,[RiskRegisterEventComment]
      ,[RiskRegisterEventCreationDate]
	  ,[WorkflowVersionGUID]
	  ,[JoinGUID]
  FROM [Risk].[RiskRegisterEvents]
