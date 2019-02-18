
CREATE VIEW [Access.ManyWho].[FinanceRequestsVw]
	AS
	SELECT   fr.FinanceRequestId
	       , fr.RequestedByPersonId
	       , fr.RequestDate
	       , fr.ApprovalDate
	       , fr.ApprovedByPersonId
		   , fr.DepartmentId
		   , fr.ReviewerPersonId
	       , fr.Summary
	       , fr.Description	
	       , fr.Category
		   , fr.SubCategory
	       , fr.Status	
	       , fr.Amount
		   , fr.NewTechnologyYesNo
		   , fr.NewResourceYesNo
		   , fr.UrgentRequestYesNo
		   , fr.RequestType
		   , fr.NominalCode
		   , fr.JiraEPICKey
		   , fr.WorkFlowLink
		   , fr.SupplierSalesforceId
		   , fr.SupplierName
		   , fr.Invoiced
           , fr.UnquotedCompanyId
		   , fr.UnquotedDueDiligenceYesNo
		   , fr.ResearchBrokerId
	       , fr.BrokerResearchYesNo
		   , fr.CoveredByWoodfordYesNo
		   , fr.FlowId
	       , fr.DocumentationFolderLink
	       , fr.JoinGUID	
	       , fr.RequestCreationDate
	       , fr.RequestLastModifiedDate
	FROM [Organisation].[FinanceRequests] fr
		;
