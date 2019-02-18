CREATE VIEW [Access.ManyWho].[AnnualBudgetReviewsVw]
	AS 
SELECT
      AnnualBudgetReviewId
	, AnnualBudgetId
	, ReviewTypeId
	, ReviewComments
	, ReviewDate
	, BudgetApproved
	, ReviewedByPersonId
	, DocumentationFolderLink
	, JoinGUID
	, ReviewCreationDatetime
	, ReviewLastModifiedDatetime
  FROM [Organisation].[AnnualBudgetReviews]
