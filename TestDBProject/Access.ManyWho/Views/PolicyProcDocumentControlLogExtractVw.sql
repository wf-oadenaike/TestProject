
CREATE VIEW [Access.ManyWho].[PolicyProcDocumentControlLogExtractVw]
	AS  
	SELECT pclr.PolicyId
		, por.PolicyName
		, polr.[RoleName] as PolicyRoleName
		, polp.[PersonsName] as PolicyOwner
		, pd.DocumentName as ProcDocumentName
		, pdr.[RoleName] as ProcDocumentRoleName
		, pdp.[PersonsName] as ProcDocumentOwner
		, pr.ProcedureId
		, pr.ProcedureName
		, clr.[ControlLogRegisterId]
		, clr.[ControlDescription]
		, clc.[CategoryName]
		, clf.[FrequencyName] as ControlFrequency
		, CASE WHEN [AdhocFrequencyYesNo] = 1 THEN 'Yes' ELSE 'No' END as AdhocFrequency
		, clr.[EvidenceDescription]
		, r.RoleName as OwnerRoleName
		, tp.ThirdPartyName as ThirdPartyName
		, CASE WHEN pclr.[IsActive] = 1 THEN 'Yes' ELSE 'No' END as IsActive
	FROM [PolicyProc].[ProcedureRegister] pr
	INNER JOIN [PolicyProc].[ProceduresDocument] pd
	ON pr.ProcDocumentId = pd.ProcDocumentId
	INNER JOIN [PolicyProc].[SignatoryOwner] pdso
	ON pdso.ProcDocumentId = pd.ProcDocumentId
	INNER JOIN [Core].[Roles] pdr
	ON pdr.RoleId = pdso.[RoleId]
	LEFT OUTER JOIN [Core].[Persons] pdp
	ON pdp.PersonId = pdso.PersonId
	INNER JOIN [PolicyProc].[ProcedureControlLogRelationship] pclr
	ON pr.ProcedureId = pclr.ProcedureId
	INNER JOIN [PolicyProc].[PolicyRegister] por
	ON pclr.PolicyId = por.PolicyId
	INNER JOIN [PolicyProc].[SignatoryOwner] poso
	ON poso.[PolicyId] = por.[PolicyId]
	INNER JOIN [Core].[Roles] polr
	ON polr.RoleId = poso.[RoleId]
	LEFT OUTER JOIN [Core].[Persons] polp
	ON polp.PersonId = poso.PersonId
	INNER JOIN [Audit].[ControlLogRegister] clr
	ON pclr.ControlLogRegisterId = clr.ControlLogRegisterId
	LEFT OUTER JOIN [Core].[Roles] r
	ON clr.OwnerRoleId = r.RoleId
	LEFT OUTER JOIN [Core].[ThirdParties] tp
	ON clr.OwnerThirdPartyId = tp.ThirdPartyId		
	INNER JOIN [Audit].[ControlLogCategories] clc
	ON clr.ControlLogCategoryId = clc.ControlLogCategoryId
	INNER JOIN [Audit].[ControlLogFrequency] clf
	ON clr.ControlLogFrequencyId = clf.ControlLogFrequencyId
	WHERE poso.[IsOwner] = 1
	AND pdso.[IsOwner] = 1
 ;
