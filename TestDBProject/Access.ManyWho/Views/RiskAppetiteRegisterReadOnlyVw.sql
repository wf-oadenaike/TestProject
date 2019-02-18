

CREATE VIEW [Access.ManyWho].[RiskAppetiteRegisterReadOnlyVw]
		AS 
	SELECT
		R.RiskAppetiteRegisterId,
		R.RiskOwnerId,  
		CP1.PersonsName RiskOwner,
		RC.CategoryId,
		RC.Category,
		R.SubCategoryID,
		RS.SubCategory,
		R.CurrentRiskAppetite,
		R.ProposedRiskAppetite,
		R.StatusID,  
		FS.FlowStatusName,
		R.SubmittedByPersonId,
		CP2.PersonsName SubmittedBy,  
		R.CreatedDate,
		R.LastModifiedDate,
		R.JiraIssueKey,
		R.JoinGUID,
		R.IsActive,
		R.IndividualReview
	FROM [Risk].[RiskAppetiteRegister]  R

	INNER JOIN [Core].[Persons] CP1 
	ON R.RiskOwnerId = CP1.PersonId

	INNER JOIN [Core].[Persons] CP2 
	ON R.SubmittedByPersonId = CP2.PersonId

	INNER JOIN [Risk].[SubCategories] RS 
	ON R.SubCategoryID = RS.SubCategoryID

	INNER JOIN [Risk].[Categories] RC 
	ON RS.CategoryId = RC.CategoryId

	INNER JOIN [Core].[FlowStatus] FS 
	ON R.StatusID = FS.FlowStatusId

