CREATE VIEW [Access.ManyWho].[ComplaintsRegisterVw]
	AS
	SELECT 	  cr.ComplaintRegisterId
	        , cr.ComplainantClientName
	        , cr.PartyComplaintAgainst
	        , cr.ReferenceNumbers
	        , cr.RecordedByPersonId
	        , cr.ReportedBy
			, cr.ReportedByCompany 
			, cr.ComplaintStatus
			, cr.ComplaintCategoryid
	        , cr.FundsAffected
	        , cr.ComplaintDetails
	        , cr.ComplaintDate
			, cr.ReportedToWIMDate
	        , cr.CompOrRestitutionSummary
			, cr.ComplaintRootCauseId
	        , cr.RootCauseDetails
	        , cr.RemedialAction
	        , cr.MitigationSteps
	        , cr.ComplaintClosed
			, cr.ThirdPartyId
			, cr.ExternalPartyFwdTo
			, cr.JIRAIssueKey
	        , cr.DocumentationFolderLink
			, cr.SubflowJoinGUID
	        , cr.JoinGUID
	        , cr.ComplaintCreationDate
	        , cr.ComplaintLastModifiedDate
	FROM [Compliance].[ComplaintsRegister] cr
		;
