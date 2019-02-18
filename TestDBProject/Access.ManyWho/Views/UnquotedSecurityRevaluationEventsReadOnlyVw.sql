CREATE VIEW [Access.ManyWho].[UnquotedSecurityRevaluationEventsReadOnlyVw]
	AS
SELECT sre.[RevaluationEventId]
     , sre.[SecurityRevaluationId]
	 , sr.[SecurityBloombergId]
     , ms.[SECURITY_NAME] as SecurityName 
     , sre.[SecurityEventTypeId]
	 , seet.[SecurityEventType]
	 , sre.[SubmittedByPersonId]
	 , sp.PersonsName
     , sre.[EventDetails]
     , sre.[EventDate]
     , sre.[EventTrueFalse]
     , sre.[DocumentationFolderLink]
     , sre.[JoinGUID]
     , sre.[RevaluationEventCreationDatetime]
     , sre.[RevaluationEventLastModifiedDatetime]
  FROM [Unquoted].[SecurityRevaluationEvents] sre
  INNER JOIN [Unquoted].[SecurityRevaluation] sr
  ON sre.SecurityRevaluationId = sr.SecurityRevaluationId
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON sr.SecurityBloombergId = ms.UNIQUE_BLOOMBERG_ID
  INNER JOIN [Unquoted].[SecurityEventTypes] seet
  ON sre.SecurityEventTypeId = seet.SecurityEventTypeId
  LEFT OUTER JOIN [Core].[Persons] sp
  ON sre.SubmittedByPersonId = sp.PersonId
