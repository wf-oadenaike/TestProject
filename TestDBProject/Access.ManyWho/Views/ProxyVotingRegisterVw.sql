
CREATE VIEW [Access.ManyWho].[ProxyVotingRegisterVw]
	AS SELECT pvr.ProxyVotingRegisterId
			, pvr.SecurityName
			, pvr.ISIN
			, pvr.VoterPersonId
			, pvr.VoterRoleId
			, pvr.RecorderPersonId
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

	 ;
