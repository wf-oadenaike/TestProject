CREATE VIEW [Access.ManyWho].[ValuationReviewsVw]
AS
SELECT 
		[ValuationReviewId]
		,[UnquotedCompanyId]
      ,[ValuationReviewMeetingDate]
      ,[BoxUrl]
      ,[WorkflowVersionGUID]
      ,[JoinGUID]
      ,[ValuationReviewCreationDate]
      ,[ValuationReviewCreatedByPersonId]
      ,[ValuationReviewModifiedDate]
      ,[ValuationReviewLastModifiedByPersonId]
  FROM [Organisation].[ValuationReviews]
