CREATE VIEW [Access.ManyWho].[RFPRegisterReadOnlyVw]
	AS 
SELECT
	   rfpr.RFPId
     , rfpr.ClientId
	 , cr.ClientName
	 , rfpr.RFPName
     , rfpr.FirstDraftDeadlineDate
     , rfpr.FinalDraftDeadlineDate
     , rfpr.RFPDeadlineDate
     , rfpr.RFPStatus
	 , rfpr.RelationshipManagerId
	 , mp.PersonsName as RelationshipManager
     , rfpr.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
     , rfpr.ApprovedByPersonId
	 , ap.PersonsName as ApprovedBy
     , rfpr.JiraTaskKey
	 , rfpr.FinalDraftLink
     , rfpr.RelationshipManagerNotes
	 , rfpr.ClientTakeOnYesNo
	 , rfpr.HeadOfSalesPersonId
	 , salesp.PersonsName as HeadOfSales
	 , rfpr.ProjectId
	 , npr.ProjectName
     , rfpr.DocumentationFolderLink
	 , rfpr.DocumentationFolderLink2
     , rfpr.JoinGUID
     , rfpr.RFPRegisterCreationDatetime
     , rfpr.RFPRegisterLastModifiedDatetime
  FROM [Sales].[RFPRegister] rfpr
  INNER JOIN [Sales].[ClientRegister] cr
  ON rfpr.ClientId = cr.ClientId
  LEFT OUTER JOIN [Core].[Persons] sp
  ON rfpr.SubmittedByPersonId = sp.PersonId
  LEFT OUTER JOIN [Core].[Persons] ap
  ON rfpr.ApprovedByPersonId = ap.PersonId
  LEFT OUTER JOIN [Core].[Persons] mp
  ON rfpr.RelationshipManagerId = mp.PersonId
  LEFT OUTER JOIN [Core].[Persons] salesp
  ON rfpr.HeadOfSalesPersonId = salesp.PersonId 
  LEFT OUTER JOIN [Organisation].[NewProjectsRegister] npr
  ON rfpr.ProjectId = npr.ProjectId
  ;
