CREATE VIEW [Access.ManyWho].[ApprovalsVw]
	AS
	SELECT   ap.ApprovalId
	       , ap.ApprovedByPersonId
	       , ap.ApprovalDate
	       , ap.ApproverComments
	       , ap.Status
	       , ap.Summary
		   , ap.Description
	       , ap.Category
		   , ap.SubCategory
		   , ap.ChangeID
		   , ap.SubmittedByPersonID
		   , ap.DepartmentId
		   , ap.ApprovalType
		   , ap.FlowId
		   , ap.JiraIssueKey
           , ap.FinanceRequestId
           , ap.SalesForceLeaveRequestId
           , ap.GTAIncidentId
	       , ap.JoinGUID1
	       , ap.JoinGUID2	
	       , ap.ApprovalCreationDate
	       , ap.ApprovalLastModifiedDate
	FROM [Organisation].[Approvals] ap
		;
