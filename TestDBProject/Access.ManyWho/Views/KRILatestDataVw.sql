




CREATE VIEW [Access.Manywho].[KRILatestDataVw]
	AS SELECT * FROM [Access.WebDev].[ufn_KPIGroups](NULL) WHERE RiskCategory IS NOT NULL AND KPIGroupName = 'Risk'

