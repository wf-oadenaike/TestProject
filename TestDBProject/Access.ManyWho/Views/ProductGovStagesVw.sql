
CREATE VIEW [Access.ManyWho].[ProductGovStagesVw]
	AS SELECT pgs.ProductGovStageId
			, pgs.ProductGovRegisterId
			, pgs.StageCategoryId
			, pgs.SectionName
			, pgs.OwnerPersonId
			, p.EmployeeBK as OwnerSalesforceUserId
			, p.PersonsName as OwnerPersonsName
			, pgs.OwnerRoleId
			, r.RoleName as OwnerRoleName
			, pgs.StageCompletionDate
			, pgs.JIRAEpicKey
			, pgs.DocumentationFolderLink
			, pgs.WorkflowVersionGUID
			, pgs.JoinGUID
			, pgs.ProductGovStageCreationDatetime
			, pgs.ProductGovStageLastModifiedDatetime
	 FROM [Product.Governance].[ProductGovStages] pgs
		LEFT OUTER JOIN Core.Persons p
			ON pgs.OwnerPersonId = p.PersonId
		LEFT OUTER JOIN Core.Roles r
			ON pgs.OwnerRoleId = r.RoleId
	 ;
