
CREATE VIEW [Access.ManyWho].[ChangeManagementRegisterReadOnlyVw]
	AS 

SELECT [ChangeID]
      ,cst.ChangeServiceTypeName
      ,cs.ChangeStatusName
      ,[ChangeTitle]
      ,cp.ChangePriorityName
      ,cu.ChangeUrgencyName
      ,[DueLiveDate]
      ,[PlanDueDate]
      ,ct.ChangeTypeName
      ,[Description]
      ,[ReasonJustification]
      ,ci.ChangeImpactName
      ,[ImpactDesc]
      ,cc.ChangeComplexityName
	  ,cmr.ComplexityDesc
      ,cr.ChangeRiskName
	  ,cmr.RiskDesc
      ,[EstimatedHoursRequired]
      ,[BuildInstruction]
      ,[ProgressNote]
      ,[IsBuildComplete]
      ,p2.PersonsName as 'Tester'
      ,[TestCompleteDueDate]
      ,[TestPlan]
      ,[TestingComplete]
      ,[JIRAIssueKey]
      ,[IsDocumentationProvided]
      ,[AttachmentsFolder]
      ,[IsChangeReady]
	  ,IncidentId
	  ,IncidentTitle
      ,[CreatedDate]
      ,p3.PersonsName as 'PlanApprovedBy'
      ,p4.PersonsName as 'DeploymentApprovedBy'
      ,p1.PersonsName as 'SubmittedBy'
	  ,cmr.Backout
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[ChangeManagementRegisterCreationDatetime]
      ,[ChangeManagementRegisterLastModifiedDatetime]
	  ,cmr.RuleID
	  ,cmr.RuleDescription
	  ,cmr.DashboardUpdate
  FROM ChangeManagement.ChangeManagementRegister cmr
		INNER JOIN [Core].[Persons] p1
			ON cmr.SubmittedByPersonId = p1.PersonId
		LEFT OUTER JOIN [Core].[Persons] p2
			ON cmr.TesterPersonId = p2.PersonId
		LEFT OUTER JOIN [Core].[Persons] p3
			ON cmr.PlanApproverPersonID = p3.PersonId
		LEFT OUTER JOIN [Core].[Persons] p4
			ON cmr.DeploymentApproverPersonID = p4.PersonId
		LEFT OUTER JOIN [ChangeManagement].ChangeServiceTypes cst
			ON cmr.ServiceTypeID = cst.ChangeServiceTypeID
		LEFT OUTER JOIN [ChangeManagement].ChangeStatus cs
			ON cmr.StatusID = cs.ChangeStatusID
		LEFT OUTER JOIN [ChangeManagement].Changepriority cp
			ON cmr.PriorityID = cp.ChangePriorityID
		LEFT OUTER JOIN [ChangeManagement].ChangeUrgency cu
			ON cmr.UrgencyID = cu.ChangeUrgencyID
		LEFT OUTER JOIN [ChangeManagement].changetypes ct
			ON cmr.ChangeTypeID = ct.changetypeid
		LEFT OUTER JOIN [ChangeManagement].ChangeImpact ci
			ON cmr.ImpactID = ci.ChangeImpactID
		LEFT OUTER JOIN [ChangeManagement].ChangeComplexity cc
			ON cmr.ComplexityID = cc.changecomplexityid
		LEFT OUTER JOIN [ChangeManagement].ChangeRisk cr
			ON cmr.RiskID = cr.ChangeRiskID


