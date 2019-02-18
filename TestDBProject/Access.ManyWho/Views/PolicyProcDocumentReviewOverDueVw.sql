
CREATE VIEW  [Access.ManyWho].[PolicyProcDocumentReviewOverDueVw]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Access.ManyWho].[PolicyProcDocumentReviewOverDueVw]
-- 
-------------------------------------------------------------------------------------- 
-- P.Ramachandran: 15/01/2019
-------------------------------------------------------------------------------------- 
SELECT 'Policy' as DocumentType        
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
         , case
             when NextReviewDate <= getdate() + 14 AND NextReviewDate >= getdate()
             then 'Amber'
             when NextReviewDate < getdate()
             then 'Red'
             end as RAGStatus
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
    AND pr.NextReviewDate <= GetDate() + 14
    UNION
    SELECT 'Procedure' as DocumentType
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
           , case
             when NextReviewDate <= getdate() + 14 AND NextReviewDate >= getdate()
             then 'Amber'
             when NextReviewDate < getdate()
             then 'Red'
             end as RAGStatus
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
    AND pd.NextReviewDate <= GetDate() + 14;

