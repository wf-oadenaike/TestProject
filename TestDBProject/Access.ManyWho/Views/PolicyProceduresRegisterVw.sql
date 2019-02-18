CREATE VIEW [Access.ManyWho].[PolicyProceduresRegisterVw]
	AS SELECT ptr.PolicyThemeRegisterId as PolicyProcedureRegisterId, ptr.PolicyThemeNameBK as PolicyNameBK, ptr.PolicyThemeVersionNo as PolicyVersion
		, ptr.PolicyThemeExpiryDate as PolicyExpiryDate, ptr.PolicyThemeDocumentStatus as PolicyStatus
		, ptr.ChangeStatus as ChangeStatus, ptr.ChangeReason , ptr.PolicyThemeSummary as PolicySummary
		, ptr.DocumentationFolderLink
		, ptr.WorkflowVersionGUID, ptr.JoinGUID
		, ptr.PolicyThemeCreationDatetime as PolicyCreationDate, ptr.PolicyThemeLastModifiedDatetime as PolicyLastModifiedDate
	FROM [Organisation].[PolicyThemeRegister] ptr
	;
