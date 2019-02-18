CREATE VIEW [Access.ManyWho].[BrokerAttestationReadOnlyVw]
	AS
SELECT [BrokerAttestationId]
	,[Year]
	,ba.[BloombergId]
	,mb.[BrokerName]
	,[BrokerServiceType]
	,[AttestationStatus]
	,ba.FollowUpDetails
	,ba.[ReviewedByPersonId]
	,sp2.PersonsName as 'ReviewedBy'
	,[DocumentationFolderLink]
	,[JoinGUID]
	,[BrokerAttestationCreationDatetime]
	,[BrokerAttestationLastModifiedDatetime]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Organisation].[BrokerAttestation] ba
	  LEFT OUTER JOIN [Core].[Persons] sp2
	  ON ba.ReviewedByPersonId = sp2.PersonId
	  LEFT OUTER JOIN [Access.ManyWho].[MasterBrokersVw] mb
	  ON ba.BloombergId = mb.BloombergId
