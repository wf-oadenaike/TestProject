CREATE VIEW [Access.ManyWho].[FinPromRegisterVw]
	AS SELECT FinPromRegisterId
			, CommsNameBK
			, FinPromType
			, PromotionChannel
			, ThirdPartyYesNo
			, IssueDueDate
			, JIRAProjectInitiationDate
			, RecurrenceFrequency
			, ApprovalDate
			, ComplianceComments
			, CompliancePersonId
			, ComplianceRoleId
			, FinPromStatus
			, JIRAEpicKey
			, DocumentationFolderLink
			, Notes
			, IsFinProm
			, IntendedAudienceDetails
			, ExpiryDate
			, ReviewFrequency
			, IssuedBy
			, IssuedDate
			, Author
			, MandateId
			, SubmittedByPersonId
			, Topic
		    , Purpose
			, JiraIssueKey
	        , ComplianceJiraKey
			, WorkflowVersionGUID
			, JoinGUID
			, FinPromCreationDatetime
			, FinPromLastModifiedDatetime
	 FROM [Investment].[FinPromsRegister]
;
