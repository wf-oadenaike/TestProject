

CREATE VIEW [Access.ManyWho].[ControlLogRegisterReadOnlyVw]
	AS SELECT clr.ControlLogRegisterId,
	clr.ControlDescription,
	clr.ControlLogCategoryId,
	clc.CategoryName,
	clr.ControlLogFrequencyId,
	clr.AdhocFrequencyYesNo,
	clf.FrequencyName,
	clr.EvidenceDescription,
	clr.OwnerRoleId,
	r.RoleName as OwnerRoleName,
	clr.OwnerThirdPartyId,
    t.ThirdPartyName as ThirdPartyName,
	clr.JoinGUID,
	ControlLogRegisterCreationDatetime,
	ControlLogRegisterLastModifiedDatetime
	 FROM [Audit].[ControlLogRegister] clr
		LEFT OUTER JOIN Core.Roles r
			ON clr.OwnerRoleId = r.RoleId
		LEFT OUTER JOIN Core.ThirdParties t
			ON clr.OwnerThirdPartyId = t.ThirdPartyId		
		INNER JOIN [Audit].[ControlLogCategories] clc
			ON clr.ControlLogCategoryId = clc.ControlLogCategoryId
		INNER JOIN [Audit].[ControlLogFrequency] clf
			ON clr.ControlLogFrequencyId = clf.ControlLogFrequencyId		
	 ;
