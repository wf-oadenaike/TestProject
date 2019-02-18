CREATE VIEW [Access.ManyWho].[ApprovalsReadOnlyVw]
AS
SELECT ap.ApprovalId
, ap.ApprovedByPersonId
, p.PersonsName as ApprovedBy
, ap.ApprovalDate
, ap.ApproverComments
, ap.Status
, ap.Summary
, ap.Description
, ap.Category
, ap.SubCategory
, ap.ChangeID
, ap.SubmittedByPersonId
, sp.PersonsName as SubmittedBy	
, ap.DepartmentId
, d.DepartmentName	
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
, ap.VisitorAccessRequestID
FROM [Organisation].[Approvals] ap
INNER JOIN Core.Persons p
ON (ap.ApprovedByPersonId = p.PersonId)
INNER JOIN Core.Persons sp
ON (ap.SubmittedByPersonId = sp.PersonId)
LEFT OUTER JOIN Core.Departments d
ON ap.DepartmentId = d.DepartmentId
;
