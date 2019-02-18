

CREATE  VIEW [Access.ManyWho].[HuddleControlLogRelationshipReadOnlyVw]
AS SELECT hcr.[HuddleControlLogRelationshipId]
       , hcr.[HuddleEventId]
	   , he.[EventName]
	   , pd.[DocumentName]
	   , pr.[ProcedureName]
       , hcr.[ControlLogRegisterId]
	   , hcr.[IsActive]
	   , clr.[ControlDescription]
	   , clc.[CategoryName]
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


