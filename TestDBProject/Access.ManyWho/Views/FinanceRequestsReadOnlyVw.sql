
CREATE VIEW [Access.ManyWho].[FinanceRequestsReadOnlyVw]
	AS
	SELECT   fr.FinanceRequestId
	       , fr.RequestedByPersonId
	       , rp.PersonsName as RequestedBy	   
	       , fr.RequestDate
	       , fr.ApprovalDate
	       , fr.ApprovedByPersonId
		   , ap.PersonsName as ApprovedBy
		   , fr.DepartmentId
		   , d.DepartmentName
	       , fr.ReviewerPersonId
		   , rep.PersonsName as Reviewer
	       , fr.Summary
	       , fr.Description	
	       , fr.Category
		   , fr.SubCategory
	       , fr.Status	
	       , fr.Amount
		   , CASE fr.NewTechnologyYesNo WHEN 1 THEN 'Yes' ELSE 'No' END as NewTechnologyYesNo
		   , CASE fr.NewResourceYesNo WHEN 1 THEN 'Yes' ELSE 'No' END as NewResourceYesNo
		   , CASE fr.UrgentRequestYesNo WHEN 1 THEN 'Yes' ELSE 'No' END as UrgentRequestYesNo
		   , fr.RequestType
		   , nc.NominalCode
	       , nc.AccountName
	       , ac.AccountCategory
		   , fr.JiraEPICKey
		   , fr.WorkFlowLink
		   , fr.SupplierSalesforceId
		   , fr.SupplierName
		   , fr.Invoiced
		   , fr.UnquotedCompanyId
		   , uc.UnquotedCompanyName
		   , CASE fr.UnquotedDueDiligenceYesNo WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' ELSE NULL END as UnquotedDueDiligenceYesNo			   
		   , fr.ResearchBrokerId
		   , rbr.BrokerCompanyName
		   , CASE fr.BrokerResearchYesNo WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' ELSE NULL END as BrokerResearchYesNo
		   , CASE fr.CoveredByWoodfordYesNo WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' ELSE NULL END as CoveredByWoodfordYesNo
		   , fr.FlowId		   
	       , fr.DocumentationFolderLink
	       , fr.JoinGUID	
	       , fr.RequestCreationDate
	       , fr.RequestLastModifiedDate
	FROM [Organisation].[FinanceRequests] fr
	INNER JOIN Core.Persons rp
		ON (fr.RequestedByPersonId = rp.PersonId)
	LEFT OUTER JOIN Core.Persons ap
		ON (fr.ApprovedByPersonId = ap.PersonId)
	LEFT OUTER JOIN Core.Persons rep
		ON (fr.ReviewerPersonId = rep.PersonId)
	LEFT OUTER JOIN Core.Departments d
		ON (fr.DepartmentId = d.DepartmentId)
	LEFT OUTER JOIN [Finance].[AccountNominalCodes] nc
	    ON fr.NominalCode = nc.NominalCode
	LEFT OUTER JOIN [Finance].[AccountCategories] ac
		ON nc.AccountCategoryId = ac.AccountCategoryId
	LEFT OUTER JOIN [Organisation].[UnquotedCompanies] uc
		ON uc.UnquotedCompanyId = fr.UnquotedCompanyId
	LEFT OUTER JOIN [Investment].[ResearchBrokerRegister] rbr
		ON rbr.ResearchBrokerId = fr.ResearchBrokerId

		;
