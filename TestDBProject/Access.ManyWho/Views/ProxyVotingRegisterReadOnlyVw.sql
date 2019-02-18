
CREATE VIEW [Access.ManyWho].[ProxyVotingRegisterReadOnlyVw]
	AS SELECT pvr.ProxyVotingRegisterId
			, pvr.SecurityName
			, pvr.ISIN
			, pvr.VoterPersonId
			, pvr.VoterJiraKey
			, p.EmployeeBK as VoterSalesforceUserId
			, p.PersonsName as VoterPersonsName
			, pvr.VoterRoleId
			, r.RoleName as VoterRoleName
			, pvr.RecorderPersonId
			, rp.EmployeeBK as RecorderSalesforceUserId
			, rp.PersonsName as RecorderPersonsName
			, pvr.DateFiled
			, pvr.CoveredByIVISYesNo
			, pvr.ProxyVotingCategory
			, pvr.ProxyVotingStatus
			, pvr.MeetingDate
			, pvr.DeadlineDate
			, pvr.SuggestedDecision
			, pvr.ActualDecision
			, pvr.OperationsNotes
            , pvr.InvestmentNotes
			, pvr.CompletedProxyVoteYesNo
			, pvr.IrrevocableUndertakingYesNo
			, pvr.DocumentationFolderLink
			, pvr.JoinGUID
			, pvr.ProxyVotingCreationDatetime
			, pvr.ProxyVotingLastModifiedDatetime
	 FROM [Operation].[ProxyVotingRegister] pvr
		INNER JOIN Core.Persons p
			ON pvr.VoterPersonId = p.PersonId
		INNER JOIN Core.Roles r
			ON pvr.VoterRoleId = r.RoleId
		LEFT OUTER JOIN Core.Persons rp
			ON pvr.RecorderPersonId = rp.PersonId
	 ;

