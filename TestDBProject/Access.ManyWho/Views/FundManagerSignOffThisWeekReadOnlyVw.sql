CREATE VIEW [Access.ManyWho].[FundManagerSignOffThisWeekReadOnlyVw]
	AS 
SELECT
	   tm.FundManagerSignOffId
	 , tm.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
	 , tm.SubmittedDate
     , tm.ReviewedByPersonId
	 , rp.PersonsName as ReviewedBy
	 , tm.ReviewDate
	 , tm.Status
     , tm.MandateId
	 , ma.MandateName
	 , ma.ClientId
	 , cr.ClientName
	 , ma.IsWeeklyValuationSignOff
	 , ma.IsWeeklyReconciliation
	 , tm.ValuationDate
	 , tm.JiraIssueKey
	 , tm.Notes
	 , tm.BoxFolderId
	 , tm.DocumentationFolderLink
     , tm.JoinGUID
     , tm.FundManagerSignOffCreationDatetime
     , tm.FundManagerSignOffLastModifiedDatetime
  FROM [Sales].[FundManagerSignOff] tm
  INNER JOIN [Core].[Persons] sp
  ON tm.SubmittedByPersonId = sp.PersonId
  LEFT OUTER JOIN [Core].[Persons] rp
  ON tm.ReviewedByPersonId = rp.PersonId
  LEFT OUTER JOIN [Investment].[Mandates] ma
  ON tm.MandateId = ma.MandateId
  LEFT OUTER JOIN [Sales].[ClientRegister] cr
  ON ma.ClientId = cr.ClientId 

  ;
