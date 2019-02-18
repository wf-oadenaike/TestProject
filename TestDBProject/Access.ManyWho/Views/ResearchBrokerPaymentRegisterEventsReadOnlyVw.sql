

CREATE VIEW [Access.ManyWho].[ResearchBrokerPaymentRegisterEventsReadOnlyVw]
	AS 

--	B.Katsadoros: 15/09/2017 JIRA: DAP-1281 [New 3rd Party Research Payments flow]

SELECT
	rbpe.ResearchBrokerPaymentEventId,
	rbpe.ResearchBrokerPaymentId,				
	rbpe.EventTypeId,	
	rbpet.EventTypeName,
	rbpe.EventDetails,
	rbpe.EventDate,
	rbpe.SubTaskJiraKey,
	rbpe.SubmittedByPersonId,
	cp.PersonsName,
	rbpe.DocumentationFolderLink,
	rbpe.JoinGUID,
	rbpe.CADIS_SYSTEM_INSERTED,
	rbpe.CADIS_SYSTEM_UPDATED,
	rbpe.CADIS_SYSTEM_CHANGEDBY,
	rbpe.CADIS_SYSTEM_LASTMODIFIED
  FROM [Investment].[ResearchBrokerPaymentEvents] rbpe
 
  INNER JOIN [Core].[Persons] cp
  ON rbpe.SubmittedByPersonId = cp.PersonId
  
  INNER JOIN [Investment].[ResearchBrokerPaymentEventTypes] rbpet
  ON rbpe.EventTypeId =  rbpet.EventTypeId


