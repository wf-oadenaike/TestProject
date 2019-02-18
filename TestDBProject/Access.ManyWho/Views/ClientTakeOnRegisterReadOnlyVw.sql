CREATE VIEW [Access.ManyWho].[ClientTakeOnRegisterReadOnlyVw]
	AS 
SELECT
	   ctr.ClientTakeOnId
	 , ctr.ClientTakeOnName
     , ctr.ClientId
	 , cr.ClientName
	 , ctr.LatestTasks
	 , ctr.LatestApproval
	 , ma.MandateId
	 , ma.MandateName
	 , ctr.RFPId
	 , rfpr.RFPName
	 , rfpr.RFPStatus
	 , ctr.ProjectId
	 , npr.ProjectName
	 , ctr.ProjectManagerPersonId
	 , pm.PersonsName as ProjectManagerName
	 ,CASE WHEN CHARINDEX('/',npr.[DocumentationFolderLink]) > 0 THEN 
	       SUBSTRING(RIGHT(npr.[DocumentationFolderLink], CHARINDEX('/', REVERSE(npr.[DocumentationFolderLink]))),2,100)
           ELSE npr.[DocumentationFolderLink] END as [ProjectBoxFolderId]
	 , ctr.RelationshipManagerId
	 , mp.PersonsName as RelationshipManager
	 , ctr.RecordedByPersonId
	 , rp.PersonsName as RecordedBy
     , ctr.Status
	 , ctr.MandateTypeId
	 , mt.MandateType
	 , ctr.InvestmentTeamPersonId
	 , ip.PersonsName as InvestmentTeamResource
	 , ctr.HeadofSalesPersonId
	 , sp.PersonsName as HeadOfSales
     , ctr.JiraLabel
	 , ctr.JiraEpicKey
	 , ctocc.Classification
	 , ctocc.ClientCategorisationChangeNotes
	 , ctocc.IMADocumentationFolderLink as ComplianceIMADocumentationFolderLink
	 , ctocc.ClientContactName
	 , ctocc.ClientContactSalesForceId
	 , ctocc.ClientAuthorityContactName
	 , ctocc.ClientAuthorityContactSalesForceId
	 , ctodc.IMADocumentationFolderLink as DistributionIMADocumentationFolderLink
	 , ctodc.IMABoxFolderId
	 , ctodc.ClientFileFolderLink
	 , ctodc.ReportingFrequency
	 , ctr.DocumentationFolderLink
     , ctr.JoinGUID
     , ctr.ClientTakeOnRegisterCreationDatetime
     , ctr.ClientTakeOnRegisterLastModifiedDatetime
  FROM [Sales].[ClientTakeOnRegister] ctr
  INNER JOIN [Sales].[ClientRegister] cr
  ON ctr.ClientId = cr.ClientId
  LEFT OUTER JOIN [Sales].[ClientTakeOnMandates] ma
  ON ctr.ClientTakeOnId = ma.ClientTakeOnId
  LEFT OUTER JOIN [Core].[Persons] mp
  ON ctr.RelationshipManagerId = mp.PersonId
  LEFT OUTER JOIN [Core].[Persons] rp
  ON ctr.RecordedByPersonId = rp.PersonId
  LEFT OUTER JOIN [Sales].[RFPRegister] rfpr
  ON ctr.RFPId = rfpr.RFPId
  LEFT OUTER JOIN [Organisation].[NewProjectsRegister] npr
  ON ctr.ProjectId = npr.ProjectId
  LEFT OUTER JOIN [Core].[Persons] pm
  ON pm.PersonId = ctr.ProjectManagerPersonId
  LEFT OUTER JOIN [Core].[Persons] ip
  ON ip.PersonId = ctr.InvestmentTeamPersonId
  LEFT OUTER JOIN [Core].[Persons] sp
  ON sp.PersonId = ctr.HeadofSalesPersonId
  LEFT OUTER JOIN [Sales].[MandateTypes] mt
  ON ctr.MandateTypeId = mt.MandateTypeId
  LEFT OUTER JOIN [Sales].[ClientTakeOnComplianceChecks] ctocc
  ON ctr.ClientTakeOnId = ctocc.ClientTakeOnId   
  LEFT OUTER JOIN [Sales].[ClientTakeOnDistributionChecks] ctodc
  ON ctr.ClientTakeOnId = ctodc.ClientTakeOnId  
   
 ;
