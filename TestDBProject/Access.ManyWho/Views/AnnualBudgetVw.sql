CREATE VIEW [Access.ManyWho].[AnnualBudgetVw]
	AS 
SELECT
      AnnualBudgetId
	, DepartmentId
	, BudgetOwnerPersonId
	, FinancialYear
	, BudgetSubmittedDate
	, BudgetApproved
	, BudgetStatus
	, DiscrBudgetSummary
	, DiscrEstimatedBudgetImpact
	, DiscrBudgetImpactExceeds500K
	, DiscrJIRAEpicKey
	, DiscrReviewerComments
	, NonDiscrBudgetSummary
	, NonDiscrEstimatedBudgetImpact
	, NonDiscrBudgetImpactExceeds500K
	, NonDiscrJIRAEpicKey
	, NonDiscrReviewerComments
	, DocumentationFolderLink
	, SubflowJoinURL
	, JoinGUID
	, AnnualBudgetCreationDatetime
	, AnnualBudgetLastModifiedDatetime
  FROM [Organisation].[AnnualBudget]
