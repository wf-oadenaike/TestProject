
CREATE VIEW [Access.ManyWho].[PlacingsRegisterReadOnlyVw]
	AS SELECT pr.PlacingRegisterId
			, pr.PlacingName
			, pr.PlacingStatus
			, pr.IsThisThroughABroker
			, pr.BrokerContactName
			, pr.BrokerSalesforceId
			, pr.SubmitterPersonId
			, sp.PersonsName as SubmittedBy
			, pr.ProjectLeadId
			, pp.PersonsName as ProjectLead		
			, pr.InitialAllocations
			, pr.FundCode
			, pr.SettlementType 
			, pr.SettlementInstructions
			, pr.SettlementDate
			, pr.TradeDate
			, pr.EstimatedDate
			, pr.ApprovalDate
			, pr.PaymentMethod
			, pr.Ticker
			, pr.IsStopRequiredYesNo
			, pr.AddedToStopListYesNo
			, pr.DateStopped
			, pr.IPOorPlacing
			, pr.Notes
			, pr.OperationsComments
			, pr.JiraIssueKey
			, pr.IrrevocableYesNo
			, pr.RaiseAmount
	        , pr.Exchange
	        , pr.WestJiraTaskKey
	        , pr.PreMoneyRange
			, pr.DealDocumentationFolderLink
			, pr.AllocDocumentationFolderLink
			, pr.AdditionalFolderLink
			, pr.IsFCARegulated
			, pr.IsSRARegulated
			, pr.JoinGUID
			, pr.PlacingCreationDatetime
			, pr.PlacingLastModifiedDatetime
	 FROM [Operation].[PlacingsRegister] pr
	 INNER JOIN [Core].[Persons] sp
	 ON pr.SubmitterPersonId = sp.PersonId
	 INNER JOIN [Core].[Persons] pp
	 ON pr.ProjectLeadId = pp.PersonId
	 ;
