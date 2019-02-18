



CREATE VIEW [Access.WebDev].[KRILatestDataVw]
	AS SELECT * FROM [Access.WebDev].[ufn_KPIGroups](NULL) WHERE RiskCategory IS NOT NULL AND KPIGroupName = 'Risk'
