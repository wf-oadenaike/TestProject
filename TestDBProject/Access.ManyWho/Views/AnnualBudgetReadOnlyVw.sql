CREATE VIEW [Access.ManyWho].[AnnualBudgetReadOnlyVw]
	AS 
SELECT
      ab.AnnualBudgetId
	, ab.DepartmentId
	, d.DepartmentName
	, ab.BudgetOwnerPersonId
    , rp.PersonsName as BudgetOwner
	, rp.EmployeeBK as BudgetOwnerSalesforceUserId
	, ab.FinancialYear
	, ab.BudgetSubmittedDate
	, ab.BudgetApproved
	, ab.BudgetStatus
	, ab.DiscrBudgetSummary
	, ab.DiscrEstimatedBudgetImpact
	, ab.DiscrBudgetImpactExceeds500K
	, ab.DiscrJIRAEpicKey
	, ab.DiscrReviewerComments
	, ab.NonDiscrBudgetSummary
	, ab.NonDiscrEstimatedBudgetImpact
	, ab.NonDiscrBudgetImpactExceeds500K
	, ab.NonDiscrJIRAEpicKey
	, ab.NonDiscrReviewerComments
	, ab.DocumentationFolderLink
	, ab.SubflowJoinURL
	, ab.JoinGUID
	, ab.AnnualBudgetCreationDatetime
	, ab.AnnualBudgetLastModifiedDatetime
  FROM [Organisation].[AnnualBudget] ab
  INNER JOIN [Core].[Persons] rp
  ON ab.BudgetOwnerPersonId = rp.PersonId
  INNER JOIN [Core].[Departments] d
  ON ab.DepartmentId = d.DepartmentId
