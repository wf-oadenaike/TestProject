CREATE VIEW [Access.ManyWho].[VisitorAccessRegisterVw] AS
SELECT [VisitorAccessID]
    ,[VisitorAccessEventID]
    ,[Version]
    ,[IsActive]
    ,cs.ChangeStatusName
    ,[EventTitle]
	,[EventDetails]
    ,[Comments]
    ,[VisitorCompany]
    ,[VisitorName]
    ,[EventStartDateTime]
    ,[EventEndDateTime]
    ,[VisitorAccessRegisterLastModifiedDatetime] as 'LastModifiedDateTime'
    ,p1.PersonsName as 'Approver'
    ,p2.PersonsName as 'Supervisor'
    ,p3.PersonsName as 'SubmittedBy'
    ,[VisitorAccessRegisterCreationDateTime]
    ,[JIRAIssueKey]
    ,[SupervisorJIRAIssueKey]
    ,[CommentsBy]
FROM ChangeManagement.VisitorAccessRegister va
    INNER JOIN [Core].[Persons] p1
        ON va.ApproverID = p1.PersonId
    LEFT OUTER JOIN [Core].[Persons] p2
        ON va.SupervisorID = p2.PersonId
    LEFT OUTER JOIN [Core].[Persons] p3
        ON va.SubmittedByPersonID = p3.PersonId
    LEFT OUTER JOIN [ChangeManagement].[ChangeStatus] cs
        ON va.RequestStatusID = cs.ChangeStatusID


