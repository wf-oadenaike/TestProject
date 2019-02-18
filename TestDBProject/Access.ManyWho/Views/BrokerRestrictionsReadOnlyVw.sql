CREATE VIEW [Access.ManyWho].[BrokerRestrictionsReadOnlyVw]
	AS 
SELECT
       br.BrokerRestrictionId
	 , br.BloombergId
	 , mp.Party_Short_Name as BrokerName
	 , br.RequestedByPersonId
     , rp.PersonsName as RequestedBy
	 , br.AddedByPersonId
	 , ap.PersonsName as AddedBy
	 , br.RequestedDate
	 , br.RestrictionReason
	 , br.RestrictionActive
     , br.RestrictionStartDate
     , br.RestrictionEndDate
	 , br.RemovalRequestedByPersonId
	 , rrp.PersonsName as RemovalRequestedBy
	 , br.RemovedByPersonId
	 , rep.PersonsName as RemovedBy
	 , br.EndRestrictionReason
	 , br.JoinGUID
	 , br.BrokerRestrictionCreationDatetime
	 , br.BrokerRestrictionLastModifiedDatetime
  FROM [Organisation].[BrokerRestrictions] br
  INNER JOIN [Investment].[T_MASTER_PTY] mp
  ON br.BloombergId = mp.Party_Code
  INNER JOIN [Core].[Persons] rp
  ON br.RequestedByPersonId = rp.PersonId
  INNER JOIN [Core].[Persons] ap
  ON br.AddedByPersonId = ap.PersonId
  LEFT OUTER JOIN [Core].[Persons] rrp
  ON br.RemovalRequestedByPersonId = rrp.PersonId
  LEFT OUTER JOIN [Core].[Persons] rep
  ON br.RemovedByPersonId = rep.PersonId  
  ;
