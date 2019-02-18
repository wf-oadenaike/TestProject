
CREATE VIEW [Access.ManyWho].[NewPolicyThemeMappingVw]
	AS 
SELECT
	   ThemeProcedureId
	,  ThemeRegisterId
	,  PolicyProcedureId
	,  PolicyRegisterId
    FROM [Organisation].[PolicyThemeMapping]
;
