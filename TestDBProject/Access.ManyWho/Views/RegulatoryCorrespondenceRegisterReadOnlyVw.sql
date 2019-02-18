CREATE VIEW [Access.ManyWho].[RegulatoryCorrespondenceRegisterReadOnlyVw]
	AS 
SELECT
	   rcr.RegulatoryCorrespondenceId
	 , rcr.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
	 , rcr.CorrespondenceDate
	 , rcr.CorrespondenceType
	 , rcr.Status
	 , rcr.SummaryDescription
	 , rcr.Comments
	 , rcr.ContactedBy
	 , rcr.ContactTitle
	 , rcr.RegulatoryBody
	 , rcr.RegulatoryInteractionId
	 , rir.SummaryDescription as RegulatoryInteractionDescription
	 , rcr.BoxFolderId
	 , rcr.JIRAIssueKey
	 , rcr.DocumentationFolderLink
	 , rcr.JoinGUID
	 , rcr.RegulatoryCorrespondenceRegisterCreationDatetime
	 , rcr.RegulatoryCorrespondenceRegisterLastModifiedDatetime
  FROM [Compliance].[RegulatoryCorrespondenceRegister] rcr
  INNER JOIN [Core].[Persons] sp
  ON rcr.SubmittedByPersonId = sp.PersonId
  LEFT OUTER JOIN [Compliance].[RegulatoryInteractionRegister] rir
  ON rir.RegulatoryInteractionId = rcr.RegulatoryInteractionId

  ;
