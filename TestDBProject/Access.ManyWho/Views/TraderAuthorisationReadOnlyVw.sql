CREATE VIEW [Access.ManyWho].[TraderAuthorisationReadOnlyVw]
	AS 
SELECT
	   ta.TraderAuthorisationId
	 , ta.TraderName
	 , ta.TrainedByPersonId
	 , tap.PersonsName as TrainedBy
	 , ta.TrainingCompletedDate
	 , ta.ApprovedByPersonId	
	 , ap.PersonsName as ApprovedBy
	 , ta.ApprovalDate
	 , ta.DecisionDate
	 , ta.FCAResponseDate
	 , ta.ReasonForRequest
	 , ta.RequestedByPersonId
	 , rp.PersonsName as RequestedBy	 
	 , ta.RequiredByDate
	 , ta.ReviewerNotes
	 , ta.Status
	 , ta.JiraParentKey
	 , ta.DocumentationFolderLink
	 , ta.JoinGUID
	 , ta.TraderAuthorisationCreationDatetime
	 , ta.TraderAuthorisationLastModifiedDatetime
  FROM [Compliance].[TraderAuthorisation] ta
  INNER JOIN [Core].[Persons] rp
  ON ta.RequestedByPersonId = rp.PersonId
  LEFT OUTER JOIN [Core].[Persons] tap
  ON ta.TrainedByPersonId = tap.PersonId
  LEFT OUTER JOIN [Core].[Persons] ap
  ON ta.ApprovedByPersonId = ap.PersonId
  

  ;
