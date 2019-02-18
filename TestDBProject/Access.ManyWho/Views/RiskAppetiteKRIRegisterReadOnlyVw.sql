

CREATE VIEW [Access.ManyWho].[RiskAppetiteKRIRegisterReadOnlyVw]
	AS 
SELECT
	R.RiskAppetiteKRIRegisterId,
    R.RiskOwnerId,  
	R.KPIID,
	MK.KPINameAlias as KPIName,
	CP1.PersonsName RiskOwner,
	R.SubCategoryId,
	SC.SubCategory,
	R.CurrentGreenThresholdValue,
	R.CurrentAmberThresholdValue,
	R.CurrentRedThresholdValue,
	R.CurrentTargetValue,
	R.ProposedGreenThresholdValue,
	R.ProposedAmberThresholdValue,
	R.ProposedRedThresholdValue,
	R.ProposedTargetValue,
    R.StatusID,
	R.IsActive,
	R.IndividualReview,  
    R.SubmittedByPersonId,
	CP2.PersonsName SubmittedBy,  
    R.CreatedDate,
    R.LastModifiedDate,
    R.JiraIssueKey,
    R.JoinGUID
FROM [Risk].[RiskAppetiteKRIRegister]  R

INNER JOIN [Core].[Persons] CP1 
ON R.RiskOwnerId = CP1.PersonId

INNER JOIN [Core].[Persons] CP2 
ON R.SubmittedByPersonId = CP2.PersonId

INNER JOIN [KPI].[MeasuredKPIs] MK 
ON R.KPIID = MK.KPIId

INNER JOIN [Risk].[SubCategories] SC 
ON R.SubCategoryId = SC.SubCategoryId

