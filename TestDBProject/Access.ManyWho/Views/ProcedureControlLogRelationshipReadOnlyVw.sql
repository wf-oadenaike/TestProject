
CREATE  VIEW [Access.ManyWho].[ProcedureControlLogRelationshipReadOnlyVw]
AS SELECT ptp.[PolicyThemeProcedureId]
       , ptp.[PolicyThemeProcedureNameBK]
	   , pr.RoleName as PolicyThemeProcedureRoleName
       , ptc.[PTPCategoryBK]
	   , clr.[ControlLogRegisterId]
	   , clr.[ControlDescription]
	   , clc.[CategoryName]
	   , clf.[FrequencyName] as ControlFrequency
	   , CASE WHEN [AdhocFrequencyYesNo] = 1 THEN 'Yes' ELSE 'No' END as AdhocFrequency
	   , clr.[EvidenceDescription]
	   , clr.OwnerRoleId
	   , r.RoleName as OwnerRoleName
	   , clr.OwnerThirdPartyId
       , tp.ThirdPartyName as ThirdPartyName
	   , pcrr.[IsActive]
  FROM [Audit].[ProcedureControlLogRegisterRelationship] pcrr
  INNER JOIN [Audit].[ControlLogRegister] clr
  ON pcrr.[ControlLogRegisterId] = clr.[ControlLogRegisterId]
  INNER JOIN [Audit].[ControlLogCategories] clc
  ON clr.[ControlLogCategoryId] = clc.[ControlLogCategoryId]
  INNER JOIN [Audit].[ControlLogFrequency] clf
  ON clr.[ControlLogFrequencyId] = clf.[ControlLogFrequencyId]
  INNER JOIN [Organisation].[PolicyThemeProcedures] ptp
  ON pcrr.[PolicyThemeProcedureId] = ptp.PolicyThemeProcedureId
  INNER JOIN [Organisation].[PolicyThemeProcedureCategories] ptc
  ON ptp.[PTPCategoryId] = ptc.[PTPCategoryId]
  INNER JOIN [Organisation].[PolicyThemeProcedureRoleRelationship] ptprr
  ON ptp.[PolicyThemeProcedureId] = ptprr.[PolicyThemeProcedureId]
  AND ptprr.[PolicyThemeProcedureOwner] = 1
  INNER JOIN [Core].[Roles] pr
  ON ptprr.[RoleId] = pr.[RoleId]
  LEFT OUTER JOIN [Core].[Roles] r
  ON clr.[OwnerRoleId] = r.[RoleId]
  LEFT OUTER JOIN [Core].[ThirdParties] tp
  ON clr.[OwnerThirdPartyId] = tp.[ThirdPartyId];
