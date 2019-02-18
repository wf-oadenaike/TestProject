CREATE VIEW [Access.ManyWho].[NewPolicyThemeProceduresVw]
	AS 
SELECT PolicyThemeProcedureId
	, PolicyThemeRegisterId
	, PTPCategoryId
	, PolicyThemeProcedureNameBK
	, ActiveFlag
	, ActiveFromDatetime
	, ActiveToDatetime
  FROM [Organisation].[PolicyThemeProcedures]
;
