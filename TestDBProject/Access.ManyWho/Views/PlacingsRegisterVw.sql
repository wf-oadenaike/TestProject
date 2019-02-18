
CREATE VIEW [Access.ManyWho].[PlacingsRegisterVw]
	AS SELECT PlacingRegisterId
			, PlacingName
			, PlacingStatus
			, IsThisThroughABroker
			, BrokerContactName
			, BrokerSalesforceId
			, SubmitterPersonId
			, ProjectLeadId
			, InitialAllocations
			, FundCode
			, SettlementType 
			, SettlementInstructions
			, SettlementDate
			, TradeDate
			, EstimatedDate
			, ApprovalDate
			, PaymentMethod
			, Ticker
			, IsStopRequiredYesNo
			, AddedToStopListYesNo
			, DateStopped
			, IPOorPlacing
			, Notes
			, OperationsComments
			, pr.JiraIssueKey
			, pr.IrrevocableYesNo
			, pr.RaiseAmount
	        , pr.Exchange
	        , pr.WestJiraTaskKey
	        , pr.PreMoneyRange
			, DealDocumentationFolderLink
			, AllocDocumentationFolderLink
			, AdditionalFolderLink
			, JoinGUID
			, PlacingCreationDatetime
			, PlacingLastModifiedDatetime
	 FROM [Operation].[PlacingsRegister] pr

	 ;
