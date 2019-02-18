
CREATE VIEW [Access.ManyWho].[ProductGovRegisterVw]
	AS SELECT pgr.ProductGovRegisterId
			, pgr.ProductName
			, pgr.ProductGovStatus
			, pgr.ProductLaunchedYesNo
			, pgr.DocumentationFolderLink
			, pgr.WorkflowVersionGUID
			, pgr.JoinGUID
			, pgr.ProductGovRegisterCreationDatetime
			, pgr.ProductGovRegisterLastModifiedDatetime
	 FROM [Product.Governance].[ProductGovRegister] pgr
	 ;
