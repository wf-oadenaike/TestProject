CREATE VIEW [Access.ManyWho].[RiskImpactVw]
	AS 
SELECT
	  RiskImpactId
	, ImpactName
	, ImpactScore
	, CreatedDate
  FROM [Risk].[RiskImpact]
