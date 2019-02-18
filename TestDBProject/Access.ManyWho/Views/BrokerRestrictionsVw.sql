CREATE VIEW [Access.ManyWho].[BrokerRestrictionsVw]
	AS 
SELECT
       BrokerRestrictionId
     , BloombergId
	 , RequestedByPersonId
	 , AddedByPersonId	
	 , RequestedDate
	 , RestrictionReason
	 , RestrictionActive
     , RestrictionStartDate
     , RestrictionEndDate
	 , RemovalRequestedByPersonId
	 , RemovedByPersonId
	 , EndRestrictionReason
	 , JoinGUID
	 , BrokerRestrictionCreationDatetime
	 , BrokerRestrictionLastModifiedDatetime
  FROM [Organisation].[BrokerRestrictions]
