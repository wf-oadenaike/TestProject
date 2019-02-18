
CREATE VIEW [Access.ManyWho].[FinPromRegisterReadOnlyVw]
	AS SELECT fpr.FinPromRegisterId
			, fpr.CommsNameBK
			, fpr.FinPromType
			, fpr.PromotionChannel
			, fpr.ThirdPartyYesNo
			, fpr.IssueDueDate
			, fpr.JIRAProjectInitiationDate
			, fpr.RecurrenceFrequency
			, fpr.ApprovalDate
			, fpr.ComplianceComments
			, fpr.CompliancePersonId
			, p.EmployeeBK as ComplianceSalesforceUserId
			, p.PersonsName as CompliancePersonsName
			, fpr.ComplianceRoleId
			, r.RoleName as ComplianceRoleName
			, fpr.FinPromStatus
			, fpr.JIRAEpicKey
			, fpr.DocumentationFolderLink
			, fpr.Notes
			, fpr.IsFinProm
			, fpr.IntendedAudienceDetails
			, fpr.ExpiryDate
			, fpr.ReviewFrequency
			, fpr.IssuedBy
			, fpr.IssuedDate
			, fpr.Author
			, fpr.MandateId
			, ma.MandateName
			, fpr.SubmittedByPersonId
			, sp.PersonsName as SubmittedBy
			, fpr.JiraIssueKey
	        , fpr.ComplianceJiraKey
		    , fpr.Topic
		    , fpr.Purpose
			, fpr.WorkflowVersionGUID
			, fpr.JoinGUID
			, fpr.FinPromCreationDatetime
			, fpr.FinPromLastModifiedDatetime
			, fpr.Outcome  
	 FROM [Investment].[FinPromsRegister] fpr
	 	INNER JOIN Core.Persons sp
			ON fpr.SubmittedByPersonId = sp.PersonId
		LEFT OUTER JOIN Core.Persons p
			ON fpr.CompliancePersonId = p.PersonId
		LEFT OUTER JOIN Core.Roles r
			ON fpr.ComplianceRoleId = r.RoleId
		LEFT OUTER JOIN [Investment].[Mandates] ma
		    ON fpr.MandateId = ma.MandateId
	 ;
