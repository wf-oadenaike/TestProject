CREATE VIEW [Access.ManyWho].[RiskRegisterEventsReadOnlyVw]
	AS 
SELECT
	   rre.[RiskRegisterEventId]
     , rre.[RiskRegisterId]
     , rre.[RiskEventTypeId]
	 , rret.[RiskEventType]
	 , rre.[RiskRegisterEventPersonId]
	 , ep.[PersonsName] as [RecordedBy] 
     , rre.[RiskRegisterEventComment]
     , rre.[RiskRegisterEventCreationDate]
	 , rre.[WorkflowVersionGUID]
	 , rre.[JoinGUID]
  FROM [Risk].[RiskRegisterEvents] rre
  INNER JOIN [Risk].[RiskRegisterEventTypes] rret
  ON rre.RiskEventTypeId = rret.RiskEventTypeId
  INNER JOIN [Core].[Persons] ep
  ON rre.RiskRegisterEventPersonId = ep.PersonId
  ;
