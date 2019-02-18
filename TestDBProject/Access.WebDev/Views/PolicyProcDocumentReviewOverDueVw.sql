
CREATE VIEW [Access.WebDev].[PolicyProcDocumentReviewOverDueVw]
/******************************
** Desc:
** Auth: D.Fanning
** Date: 31/05/2017
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1047     31/10/2008  D.Fanning   Add Category description field
**
*******************************/
	AS 
	SELECT 'Policy' as Type
	     , pr.PolicyId as Id
		 , pr.PolicyName
		 , pr.Version
		 , pr.Status
		 , rf.ReviewFrequencyName
		 , pr.LastReviewDate
		 , pr.NextReviewDate
		 , r.RoleName as OwnerRole
         , so.PersonId as OwnerPersonId
		 , p.PersonsName as OwnerPerson
		 , d.DepartmentName as OwnerDepartment
		 , dc.CategoryDescription
	FROM [PolicyProc].[PolicyRegister] pr
	INNER JOIN [PolicyProc].[ReviewFrequency] rf
	ON pr.ReviewFrequencyId = rf.ReviewFrequencyId
	LEFT OUTER JOIN [PolicyProc].[SignatoryOwner] so
	ON pr.PolicyId = so.PolicyId
	LEFT OUTER JOIN [Core].[Roles] r
	ON so.RoleId = r.RoleId
	LEFT OUTER JOIN [Core].[Persons] p
	ON so.PersonId = p.PersonId	
	LEFT OUTER JOIN [Core].[Departments] d
	ON p.DepartmentId = d.DepartmentId
	LEFT OUTER JOIN [PolicyProc].[DocumentCategories] dc
	ON pr.DocumentCategoryId = dc.CategoryId
	WHERE ISNULL(so.IsOwner,1) = 1
	AND pr.IsActive = 1
	AND (pr.NextReviewDate IS NULL OR pr.NextReviewDate < GetDate())
	UNION
	SELECT 'ProcDocument' as Type
	     , pd.ProcDocumentId as Id
		 , pd.DocumentName
		 , pd.Version
		 , pd.Status
		 , rf.ReviewFrequencyName
		 , pd.LastReviewDate
		 , pd.NextReviewDate
		 , r.RoleName as OwnerRole
         , so.PersonId as OwnerPersonId
		 , p.PersonsName as OwnerPerson
		 , d.DepartmentName as OwnerDepartment
		  , dc.CategoryDescription
	FROM [PolicyProc].[ProceduresDocument] pd
	INNER JOIN [PolicyProc].[ReviewFrequency] rf
	ON pd.ReviewFrequencyId = rf.ReviewFrequencyId
	LEFT OUTER JOIN [PolicyProc].[SignatoryOwner] so
	ON pd.ProcDocumentId = so.ProcDocumentId
	LEFT OUTER JOIN [Core].[Roles] r
	ON so.RoleId = r.RoleId
	LEFT OUTER JOIN [Core].[Persons] p
	ON so.PersonId = p.PersonId	
	LEFT OUTER JOIN [Core].[Departments] d
	ON p.DepartmentId = d.DepartmentId
	LEFT OUTER JOIN [PolicyProc].[DocumentCategories] dc
	ON pd.DocumentCategoryId = dc.CategoryId
	WHERE ISNULL(so.IsOwner,1) = 1
	AND pd.IsActive = 1
	AND (pd.NextReviewDate IS NULL OR pd.NextReviewDate < GetDate());

