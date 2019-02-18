
CREATE VIEW [DBO].[V_POLICY_PROC] AS

	SELECT 'Policy' as Type
	     , pr.PolicyId as Id
		 , pr.PolicyName
		 , CAST (pr.Version AS NVARCHAR) Version
		 , pr.Status
		 , pr.LastReviewDate
		 , pr.NextReviewDate
		 , p.PersonId
		 , p.PersonsName
		 , pr.IsActive
		 , CAST((CASE WHEN (pr.NextReviewDate IS NULL OR pr.NextReviewDate < GetDate()) THEN '1' ELSE '0' END) AS BIT) AS LATE
	FROM [PolicyProc].[PolicyRegister] pr 
	INNER JOIN [PolicyProc].[ReviewFrequency]		rf			ON	pr.ReviewFrequencyId		= rf.ReviewFrequencyId
	LEFT OUTER JOIN [PolicyProc].[SignatoryOwner]	so			ON	pr.PolicyId				= so.PolicyId
	LEFT OUTER JOIN [Core].[Roles]					r			ON	so.RoleId				= r.RoleId
	LEFT OUTER JOIN [Core].[Persons]				p			ON	so.PersonId				= p.PersonId	
	LEFT OUTER JOIN [PolicyProc].[DocumentCategories] dc		ON	pr.DocumentCategoryId	= dc.CategoryId
	WHERE ISNULL(so.IsOwner,1) = 1
	UNION
	SELECT 'ProcDocument' as Type
	     , pd.ProcDocumentId as Id
		 , pd.DocumentName
		 , CAST (pd.Version AS NVARCHAR) Version
		 , pd.Status
		 , pd.LastReviewDate
		 , pd.NextReviewDate
		 , p.PersonId
		 , p.PersonsName
		 , pd.IsActive
		 , CAST((CASE WHEN (pd.NextReviewDate IS NULL OR pd.NextReviewDate < GetDate()) THEN '1' ELSE '0' END) AS BIT) AS LATE
	FROM [PolicyProc].[ProceduresDocument]			pd	
	INNER JOIN [PolicyProc].[ReviewFrequency]		rf		ON	pd.ReviewFrequencyId = rf.ReviewFrequencyId
	LEFT OUTER JOIN [PolicyProc].[SignatoryOwner]	so		ON	pd.ProcDocumentId = so.ProcDocumentId
	LEFT OUTER JOIN [Core].[Roles]					r		ON	so.RoleId = r.RoleId
	LEFT OUTER JOIN [Core].[Persons]				p		ON	so.PersonId = p.PersonId	
	LEFT OUTER JOIN [Core].[Departments]			d		ON	p.DepartmentId = d.DepartmentId
	LEFT OUTER JOIN [PolicyProc].[DocumentCategories] dc	ON	pd.DocumentCategoryId = dc.CategoryId
	WHERE ISNULL(so.IsOwner,1) = 1