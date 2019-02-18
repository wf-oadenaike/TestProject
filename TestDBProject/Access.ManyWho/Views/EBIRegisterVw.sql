CREATE VIEW [Access.ManyWho].[EBIRegisterVw]
	AS
	SELECT 	  ebir.EBIRegisterId
			, ebir.EBIExternalReference
			, ebir.DateIdentified
			, ebir.ReportedByPersonId
			, ebir.RecordedByPersonId
			, ebir.EBITypeCode
			, ebir.EBIBreachTypeId
	        , ebir.EBIImpactTypeId
            , ebir.EBICategorisationId
			, ebir.EBISummary
            , ebir.EBIStartDate
	        , ebir.EBIEndDate
	        , ebir.EBIClosureDate
			, ebir.EBIResolvedYesNo
	        , ebir.RemedyAction
	        , ebir.MitigationSteps
	        , ebir.IncidentReportFinalizationDate
	        , ebir.ExternalNotificationRequiredYesNo
	        , ebir.ExternalNotificationDetails
			, ebir.ExternalBodyId
			, ebir.NotifiedDepartmentHeadId
	        , ebir.ReimbursementRequiredYesNo
	        , ebir.ReimbursementAmount
	        , ebir.ReimbursementComments
	        , ebir.ReimbursementDate
			, ebir.SentBackYesNo
			, ebir.DisputedPendingLitigationYesNo
			, ebir.InvestmentRelatedYesNo
			, ebir.DataProtectionRelatedYesNo
			, ebir.RegulatoryRelatedYesNo
			, ebir.ReportableYesNo
	        , ebir.ServiceIssueID
	        , ebir.ServiceProviderName
			, ebir.ClientsNotifiedYesNo
			, ebir.Status
            , ebir.WorkflowVersionGUID
            , ebir.JoinGUID
			, ebir.EBIRegisterCreationDatetime
			, ebir.EBIRegisterLastModifiedDatetime
	FROM [Compliance].[EBIRegister] ebir
		;
