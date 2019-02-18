CREATE VIEW [Access.ManyWho].[NewPolicyThemeProcedureRoleRelationshipVw]
	AS 
SELECT 
		  PolicyThemeProcedureId
		, PolicyThemeRegisterId
		, RoleId
		, PolicyThemeProcedureOwner
		, PolicyThemeProcedureReviewer
		, PolicyThemeProcedureSignatory
		, ActiveFlag
		, ActiveFromDatetime
		, ActiveToDatetime
		, PolicyThemeProcedureLastModifiedDatetime
	FROM [Organisation].[PolicyThemeProcedureRoleRelationship]
;
