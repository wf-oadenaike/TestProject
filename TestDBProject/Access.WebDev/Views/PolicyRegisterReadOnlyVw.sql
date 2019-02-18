
CREATE VIEW [Access.WebDev].[PolicyRegisterReadOnlyVw]
	AS 
	SELECT pr.PolicyId
		 , pr.PolicyName
		 , pr.Version
		 , pr.Status
		 , pr.SummaryDescription
		 , pr.ReviewFrequencyId
		 , rf.ReviewFrequencyName
		 , pr.LastReviewDate
		 , pr.NextReviewDate
		 , pr.IsActive
		 , so.RoleId as OwnerRoleId
		 , r.RoleName as OwnerRole
         , so.PersonId as OwnerPersonId
		 , p.PersonsName as OwnerPerson
		 , pr.ModifiedByPersonId
		 , mp.PersonsName as ModifiedByPerson
		 , CAST(ISNULL((SELECT TOP 1 1 FROM [PolicyProc].[SignatoryOwner] so1 
		    WHERE so1.PolicyId = pr.PolicyId AND so1.IsSignatory = 1 AND so1.IsActive = 1
			AND so1.RoleId = (SELECT RoleId FROM [Core].[Roles] WHERE RoleName = 'Chief Executive Officer')),0) as bit)  as IsCEOSignatory
		 , pr.DocumentCategoryId
		 , dc.CategoryDescription
		 , pr.DocumentationFolderLink
		 , pr.JoinGUID
		 , pr.PolicyRegisterCreationDatetime
		 , pr.PolicyRegisterLastModifiedDatetime
	FROM [PolicyProc].[PolicyRegister] pr
	INNER JOIN [PolicyProc].[ReviewFrequency] rf
	ON pr.ReviewFrequencyId = rf.ReviewFrequencyId
	LEFT OUTER JOIN [PolicyProc].[SignatoryOwner] so
	ON pr.PolicyId = so.PolicyId
	LEFT OUTER JOIN [Core].[Roles] r
	ON so.RoleId = r.RoleId
	LEFT OUTER JOIN [Core].[Persons] p
	ON so.PersonId = p.PersonId	
	LEFT OUTER JOIN [Core].[Persons] mp
	ON pr.ModifiedByPersonId = mp.PersonId
	LEFT OUTER JOIN [PolicyProc].[DocumentCategories] dc
	ON pr.DocumentCategoryId = dc.CategoryId
	WHERE ISNULL(so.IsOwner,1) = 1
;

