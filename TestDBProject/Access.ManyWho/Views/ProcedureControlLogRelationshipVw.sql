
CREATE  VIEW [Access.ManyWho].[ProcedureControlLogRelationshipVw]
AS SELECT pcrr.[PolicyThemeProcedureId]
	   , pcrr.[ControlLogRegisterId]
	   , pcrr.[IsActive]
  FROM [Audit].[ProcedureControlLogRegisterRelationship] pcrr
