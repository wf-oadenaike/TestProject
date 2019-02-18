CREATE VIEW [Access.ManyWho].[RiskProbabilityVw]
	AS 
SELECT
	  RiskProbabilityId
	, ProbabilityName
	, ProbabilityScore
	, CreatedDate
  FROM [Risk].[RiskProbability]
