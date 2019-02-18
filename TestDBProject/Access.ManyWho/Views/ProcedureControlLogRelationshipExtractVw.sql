
CREATE VIEW [Access.ManyWho].[ProcedureControlLogRelationshipExtractVw]
AS  
 SELECT  ptm.[PolicyProcedureId] as PolicyId
       , pol_p.[PolicyThemeProcedureNameBK] as PolicyName
	   , pol_r.[PersonsName] as PolicyOwner
	   , pol_r.AssignedRoleName as PolicyRoleName
	   , theme_p.PolicyThemeProcedureNameBK as ThemeName
       , proc_p.[PolicyThemeProcedureId] as ProcedureId
       , proc_p.[PolicyThemeProcedureNameBK] as ProcedureName
	   , theme_r.[PersonsName] as ProcedureOwner
	   , theme_r.AssignedRoleName as ProcedureRoleName
       , proc_c.[PTPCategoryBK]
	   , clr.[ControlLogRegisterId]
	   , clr.[ControlDescription]
	   , clc.[CategoryName]
	   , clf.[FrequencyName] as ControlFrequency
	   , CASE WHEN [AdhocFrequencyYesNo] = 1 THEN 'Yes' ELSE 'No' END as AdhocFrequency
	   , clr.[EvidenceDescription]
	   , r.RoleName as OwnerRoleName
       , tp.ThirdPartyName as ThirdPartyName
	   , CASE WHEN pcrr.[IsActive] = 1 THEN 'Yes' ELSE 'No' END as IsActive
  FROM [Audit].[ProcedureControlLogRegisterRelationship] pcrr -- control linked to proc
  INNER JOIN [Organisation].[PolicyThemeProcedures] proc_p
  ON pcrr.[PolicyThemeProcedureId] = proc_p.PolicyThemeProcedureId
  INNER JOIN [Organisation].[PolicyThemeProcedureCategories] proc_c
  ON proc_p.[PTPCategoryId] = proc_c.[PTPCategoryId]
  AND proc_c.[PTPCategoryBK] = 'Procedure'
  INNER JOIN [Organisation].[PolicyThemeProcedures] theme_p
  ON proc_p.[PolicyThemeRegisterId] = theme_p.PolicyThemeRegisterId
  INNER JOIN [Organisation].[PolicyThemeProcedureCategories] theme_c
  ON theme_p.[PTPCategoryId] = theme_c.[PTPCategoryId]
  AND theme_c.[PTPCategoryBK] = 'Theme'
  INNER JOIN [Organisation].[PolicyThemeMapping] ptm -- map theme to policy
  ON proc_p.PolicyThemeRegisterId = ptm.[ThemeRegisterId]
  INNER JOIN [Organisation].[PolicyThemeProcedures] pol_p
  ON ptm.PolicyProcedureId = pol_p.PolicyThemeProcedureId
  
  LEFT OUTER JOIN [Organisation].[PolicyThemeProcedureRoleRelationship] pol_rr -- role for policy
  ON pol_p.[PolicyThemeProcedureId] = pol_rr.[PolicyThemeProcedureId]
  AND pol_rr.[PolicyThemeProcedureOwner] = 1
  LEFT OUTER JOIN [Access.ManyWho].[PersonsActiveVw] pol_r
  ON pol_rr.[RoleId] = pol_r.[AssignedRoleId]
  
  --INNER JOIN [Audit].[ProcedureControlLogRegisterRelationship] pol_clrr -- control linked to policy
  --ON pol_clrr.[PolicyThemeProcedureId] = pol_p.PolicyThemeProcedureId
  --AND pol_clrr.[ControlLogRegisterId] = pcrr.ControlLogRegisterId
  
  INNER JOIN [Audit].[ControlLogRegister] clr
  ON pcrr.[ControlLogRegisterId] = clr.[ControlLogRegisterId]
  INNER JOIN [Audit].[ControlLogCategories] clc
  ON clr.[ControlLogCategoryId] = clc.[ControlLogCategoryId]
  INNER JOIN [Audit].[ControlLogFrequency] clf
  ON clr.[ControlLogFrequencyId] = clf.[ControlLogFrequencyId]
  
  INNER JOIN [Organisation].[PolicyThemeProcedureRoleRelationship] ptprr -- role for theme
  ON theme_p.[PolicyThemeProcedureId] = ptprr.[PolicyThemeProcedureId]
  AND ptprr.[PolicyThemeProcedureOwner] = 1
  
  LEFT OUTER JOIN [Access.ManyWho].[PersonsActiveVw]  theme_r
  ON ptprr.[RoleId] = theme_r.[AssignedRoleId]
  LEFT OUTER JOIN [Core].[Roles] r
  ON clr.[OwnerRoleId] = r.[RoleId]
  LEFT OUTER JOIN [Core].[ThirdParties] tp
  ON clr.[OwnerThirdPartyId] = tp.[ThirdPartyId]

;
