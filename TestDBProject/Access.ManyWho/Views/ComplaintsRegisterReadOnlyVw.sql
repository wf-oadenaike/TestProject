CREATE VIEW  [Access.ManyWho].[ComplaintsRegisterReadOnlyVw]
AS
	SELECT 	  cr.ComplaintRegisterId
	        , cr.ComplainantClientName
	        , cr.PartyComplaintAgainst
	        , cr.ReferenceNumbers
			, cr.RecordedByPersonId
			, rp.PersonsName as RecordedBy
			, rp.EmployeeBK as RecordedSalesforceUserId
			, cr.ReportedBy
			, cr.ReportedByCompany
			, cr.ComplaintStatus
			, cr.ComplaintCategoryId
			, cc.Category
	        , cr.FundsAffected
	        , cr.ComplaintDetails
	        , cr.ComplaintDate
			, cr.ReportedToWIMDate
	        , cr.CompOrRestitutionSummary
			, cr.ComplaintRootCauseId
			, rc.RootCause
			, rc.RootCauseDescription
	        , cr.RootCauseDetails
	        , cr.RemedialAction
	        , cr.MitigationSteps
	        , cr.ComplaintClosed
			, cr.ThirdPartyId
			, tp.ThirdPartyName
			, cr.ExternalPartyFwdTo
			, cr.JIRAIssueKey
	        , cr.DocumentationFolderLink
			, cr.SubflowJoinGUID
	        , cr.JoinGUID
	        , cr.ComplaintCreationDate
	        , cr.ComplaintLastModifiedDate
			---, cre.EventDate as 'DateForwarded' 
			,(SELECT max([EventDate]) from [Compliance].[ComplaintsRegisterEvents] WHERE [ComplaintRegisterId] = cr.ComplaintRegisterId AND ComplaintEventTypeID = 2) as 'DateForwarded'
			,(SELECT max([EventDate]) from [Compliance].[ComplaintsRegisterEvents] WHERE [ComplaintRegisterId] = cr.ComplaintRegisterId AND ComplaintEventTypeID = 13) as 'DateThirdPartyConfirmedReceipt'
			,(SELECT max([EventDate]) from [Compliance].[ComplaintsRegisterEvents] WHERE [ComplaintRegisterId] = cr.ComplaintRegisterId AND ComplaintEventTypeID = 5) as 'FinalResponseDate'
			, (CASE WHEN cr.ThirdPartyComplaintReceived = '1' Then 'Yes' ELSE 'No' END) as ThirdPartyComplaintReceived
     	FROM [Compliance].[ComplaintsRegister] cr
		INNER JOIN Core.Persons rp
		ON (cr.RecordedByPersonId = rp.PersonId)
		LEFT OUTER JOIN [Compliance].[ComplaintCategories] cc
	    ON cr.ComplaintCategoryId = cc.CategoryId
		LEFT OUTER JOIN [Compliance].[ComplaintRootCauses] rc
	    ON cr.ComplaintRootCauseId = rc.RootCauseId
		LEFT OUTER JOIN [Core].[ThirdParties] tp
	    ON cr.[ThirdPartyId] = tp.[ThirdpartyId]
		;
