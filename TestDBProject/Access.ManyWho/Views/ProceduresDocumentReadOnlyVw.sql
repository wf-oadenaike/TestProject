
CREATE VIEW  [Access.ManyWho].[ProceduresDocumentReadOnlyVw]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Access.ManyWho].[ProceduresDocumentReadOnlyVw]
-------------------------------------------------------------------------------------- 
-- B.Katsadoros: 15/01/2019
-------------------------------------------------------------------------------------- 

SELECT pd.ProcDocumentId
		 , pd.DocumentName
		 , pd.Version
		 , pd.Status
		 , pd.SummaryDescription
		 , pd.ReviewFrequencyId
		 , rf.ReviewFrequencyName
		 , pd.LastReviewDate
		 , pd.NextReviewDate
		 , pd.IsActive
		 , so.RoleId as OwnerRoleId
		 , r.RoleName as OwnerRole
         , so.PersonId as OwnerPersonId
		 , p.PersonsName as OwnerPerson
		 , pd.ModifiedByPersonId
		 , mp.PersonsName as ModifiedByPerson
		 , CAST(ISNULL((SELECT TOP 1 1 FROM [PolicyProc].[SignatoryOwner] so1 
		    WHERE so1.ProcDocumentId = pd.ProcDocumentId AND so1.IsSignatory = 1 AND so1.IsActive = 1
			AND so1.RoleId = (SELECT RoleId FROM [Core].[Roles] WHERE RoleName = 'Chief Executive Officer')),0) as bit)  as IsCEOSignatory
		 , pd.DocumentCategoryId
		 , dc.CategoryDescription
		 , pd.DocumentationFolderLink
		 , pd.JoinGUID
		 , pd.ProceduresDocumentCreationDatetime
		 , pd.ProceduresDocumentLastModifiedDatetime
	FROM [PolicyProc].[ProceduresDocument] pd
	INNER JOIN [PolicyProc].[ReviewFrequency] rf
	ON pd.ReviewFrequencyId = rf.ReviewFrequencyId
	LEFT OUTER JOIN [PolicyProc].[SignatoryOwner] so
	ON pd.ProcDocumentId = so.ProcDocumentId
	LEFT OUTER JOIN [Core].[Roles] r
	ON so.RoleId = r.RoleId
	LEFT OUTER JOIN [Core].[Persons] p
	ON so.PersonId = p.PersonId	
	LEFT OUTER JOIN [Core].[Persons] mp
	ON pd.ModifiedByPersonId = mp.PersonId
	LEFT OUTER JOIN [PolicyProc].[DocumentCategories] dc
	ON pd.DocumentCategoryId = dc.CategoryId
	WHERE ISNULL(so.IsOwner,1) = 1
;

