CREATE VIEW [Access.ManyWho].[MandatesReadOnlyVw]
	AS 
SELECT ma.MandateId
     , ma.PortfolioCode
     , ma.MandateName
     , ma.MandateDescription
     , ma.IsActive
     , ma.ClientId
	 , cr.ClientName
	 , cr.RelationshipManagerId
	 , mp.PersonsName as RelationshipManager	 
     , ma.IsWoodfordMandate
     , ma.IsWeeklyValuationSignOff
	 , ma.IsWeeklyReconciliation
	 , ma.ReconciliationBoxFolderId
	 , cr.ReconciliationEmailAddress
     , ma.JoinGUID
     , ma.MandateCreationDatetime
     , ma.MandateLastModifiedDatetime
  FROM [Investment].[Mandates] ma
  INNER JOIN [Sales].[ClientRegister] cr
  ON ma.ClientId = cr.ClientId
  LEFT OUTER JOIN [Core].[Persons] mp
  ON cr.RelationshipManagerId = mp.PersonId

  ;
