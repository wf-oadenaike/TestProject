CREATE VIEW [Access.WebDev].[ProcDocumentControlLogReadOnlyVw]
	AS 
	SELECT pclr.PolicyId
	     , por.PolicyName
	     , pd.ProcDocumentId
		 , pd.DocumentName
		 , pr.ProcedureId
		 , pr.ProcedureName
		 , clr.ControlLogRegisterId
		 , clr.ControlDescription
		 , clr.ControlLogCategoryId
		 , clc.CategoryName
		 , clr.ControlLogFrequencyId
		 , clr.AdhocFrequencyYesNo
		 , clf.FrequencyName
		 , clr.EvidenceDescription
		 , clr.OwnerRoleId
		 , r.RoleName as OwnerRoleName
		 , clr.OwnerThirdPartyId
		 , t.ThirdPartyName as ThirdPartyName
		 , clr.JoinGUID
		 , clr.ControlLogRegisterCreationDatetime
		 , clr.ControlLogRegisterLastModifiedDatetime
	FROM [PolicyProc].[ProcedureRegister] pr
	INNER JOIN [PolicyProc].[ProceduresDocument] pd
	ON pr.ProcDocumentId = pd.ProcDocumentId
	INNER JOIN [PolicyProc].[ProcedureControlLogRelationship] pclr
	ON pr.ProcedureId = pclr.ProcedureId
	LEFT OUTER JOIN [PolicyProc].[PolicyRegister] por
	ON pclr.PolicyId = por.PolicyId
	INNER JOIN [Audit].[ControlLogRegister] clr
	ON pclr.ControlLogRegisterId = clr.ControlLogRegisterId
	LEFT OUTER JOIN Core.Roles r
	ON clr.OwnerRoleId = r.RoleId
	LEFT OUTER JOIN Core.ThirdParties t
	ON clr.OwnerThirdPartyId = t.ThirdPartyId		
	INNER JOIN [Audit].[ControlLogCategories] clc
	ON clr.ControlLogCategoryId = clc.ControlLogCategoryId
	INNER JOIN [Audit].[ControlLogFrequency] clf
	ON clr.ControlLogFrequencyId = clf.ControlLogFrequencyId
	WHERE pclr.[IsActive]=1
;
