CREATE VIEW [Access.ManyWho].[BrokerAttestationEventsReadOnlyVw]
	AS
SELECT [BrokerAttestationEventId]
	  ,[BrokerAttestationId]
      ,[BrokerAttestationEventType]
      ,[EventDetails]
      ,[EventDate]
      ,[SubmittedByPersonId]
	  ,sp2.PersonsName as 'SubmittedBy'
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[BrokerAttestationEventCreationDatetime]
      ,[BrokerAttestationEventLastModifiedDatetime]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Organisation].[BrokerAttestationEvents] bae
	  LEFT OUTER JOIN [Core].[Persons] sp2
	  ON bae.SubmittedByPersonId = sp2.PersonId
