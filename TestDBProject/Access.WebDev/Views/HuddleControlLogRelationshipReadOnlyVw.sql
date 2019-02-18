


CREATE  VIEW [Access.WebDev].[HuddleControlLogRelationshipReadOnlyVw]
AS SELECT hcr.[HuddleControlLogRelationshipId]
       , hcr.[HuddleEventId]
	   , he.[EventName]
	   , pd.[DocumentName]
	   , pr.[ProcedureId]
	   , pr.[ProcedureName]
	   , het.CategoryId
	   , rc.Category
	   , he.SubCategoryId
	   , het.SubCategory
       , hcr.[ControlLogRegisterId]
	   , clr.[ControlDescription]
	   , clc.[CategoryName] as ControlType
	   , clf.[FrequencyName] as ControlFrequency
  FROM [Organisation].[HuddleControlLogRelationship] hcr
  INNER JOIN [Audit].[ControlLogRegister] clr
  ON hcr.[ControlLogRegisterId] = clr.[ControlLogRegisterId]
  INNER JOIN [Audit].[ControlLogCategories] clc
  ON clr.[ControlLogCategoryId] = clc.[ControlLogCategoryId]
  INNER JOIN [Audit].[ControlLogFrequency] clf
  ON clr.[ControlLogFrequencyId] = clf.[ControlLogFrequencyId]
   INNER JOIN [Organisation].[HuddleEvents] he
  ON hcr.[HuddleEventId] = he.[EventId]
   INNER JOIN [PolicyProc].[ProcedureControlLogRelationship] pcr
  ON hcr.[ControlLogRegisterId] = pcr.[ControlLogRegisterId]
  INNER JOIN [PolicyProc].[ProcedureRegister] pr
  ON pcr.[ProcedureId] = pr.[ProcedureId]
   INNER JOIN [PolicyProc].[ProceduresDocument] pd
  ON pr.[ProcDocumentId] = pd.[ProcDocumentId]
  left join Risk.SubCategories het
  on he.SubCategoryId = het.SubCategoryId
  left join [Risk].[Categories] rc
  on het.CategoryId = rc.CategoryId
  where hcr.IsActive = 1



