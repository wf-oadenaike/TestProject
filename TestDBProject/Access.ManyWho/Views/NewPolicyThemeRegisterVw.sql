CREATE VIEW [Access.ManyWho].[NewPolicyThemeRegisterVw]
	AS 
SELECT 
          PolicyThemeRegisterId 
		, PTPCategoryId
		, PolicyThemeNameBK
		, PolicyThemeVersionNo
		, PolicyThemeExpiryDate
		, PolicyThemeDocumentStatus
		, ActiveFlag
		, ChangeStatus
		, ChangeReason
		, PolicyThemeSummary
		, PolicyThemeReviewFrequencyId
		, DocumentationFolderLink
		, DocumentationFolderId
		, WorkflowVersionGUID
		, JoinGUID
		, PolicyThemeCreationDatetime
		, PolicyThemeLastModifiedDatetime
  FROM [Organisation].[PolicyThemeRegister]
;
