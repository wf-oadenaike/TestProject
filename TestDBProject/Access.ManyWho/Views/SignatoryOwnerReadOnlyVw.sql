CREATE VIEW [Access.ManyWho].[SignatoryOwnerReadOnlyVw]
	AS 
	SELECT so.SignatoryOwnerId
		 , so.ProcDocumentId
		 , so.PolicyId
		 , so.RoleId
   		 , r.RoleName as OwnerRole
		 , so.PersonId
   		 , p.PersonsName as OwnerPerson
		 , so.IsOwner
		 , so.IsSignatory
		 , so.IsActive
		 , so.JoinGUID
		 , so.SignatoryOwnerCreationDatetime
		 , so.SignatoryOwnerLastModifiedDatetime
	FROM [PolicyProc].[SignatoryOwner] so
	LEFT OUTER JOIN [Core].[Roles] r
	ON so.RoleId = r.RoleId
	LEFT OUTER JOIN [Core].[Persons] p
	ON so.PersonId = p.PersonId	
;
