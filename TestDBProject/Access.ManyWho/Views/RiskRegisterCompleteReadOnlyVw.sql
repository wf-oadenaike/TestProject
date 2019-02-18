

CREATE VIEW [Access.ManyWho].[RiskRegisterCompleteReadOnlyVw]
	AS 
WITH Events_CTE AS (
	SELECT 
      [RiskRegisterId]
      ,MAX([RiskRegisterEventCreationDate]) AS LatestDate
  FROM [Risk].[RiskRegisterEvents]
  GROUP BY [RiskRegisterId]
  )
SELECT rr.[RiskRegisterId]
      ,c.[CategoryId]
	  ,c.Category
      ,rr.[SubCategoryId]
	  ,sc.SubCategory AS SubCategory
      ,rr.[IdentifiedByPersonId]
	  ,rp.[PersonsName] as IdentifiedBy
      ,rr.[RiskEvent]
      ,rr.[RiskCause]
      ,rr.[MitigationAndControls]
	  ,pav.PersonsName as RiskOwner
	  ,pav.AssignedRoleName as RiskRole 
      ,rr.[RiskRegisterCreationDate]
	  ,rr.[RiskOccurrenceDate]
	  ,CASE WHEN rr.[RiskOccurrenceDate] IS NULL THEN CAST(1 as bit) ELSE CAST(0 as bit) END as IsRiskOccurrenceDateNull
	  ,0 as RiskStatusId
	  ,rr.RiskStatus
	  ,rre.RiskRegisterEventComment AS LatestComment
	  ,p.PersonsName AS RiskStatusChangeBy
	  ,rr.GrossImpactId
	  ,gi.ImpactName as GrossImpact
      ,rr.GrossProbabilityId
	  ,gp.ProbabilityName as GrossProbability
	  ,gipm.RiskExposure as GrossExposure
      ,gipm.RiskScore as GrossScore
      ,rr.NetImpactId
	  ,ni.ImpactName as NetImpact	  
      ,rr.NetProbabilityId
	  ,np.ProbabilityName as NetProbability
	  ,nipm.RiskExposure as NetExposure
      ,nipm.RiskScore as NetScore
      ,sc.RiskAppetite
      ,CASE WHEN nipm.RiskScore > (CASE WHEN sc.RiskAppetite = 'Low' THEN 1 WHEN sc.RiskAppetite = 'Medium' THEN 2 WHEN sc.RiskAppetite = 'High' THEN 3 ELSE 1 END) THEN 'Net Score Too High' ELSE 'Acceptable' END as Outcome
      ,CASE WHEN rr.ImpactOnICAAPYesNo = 1 THEN 'Yes' WHEN rr.ImpactOnICAAPYesNo = 0 THEN 'No' ELSE NULL END as ImpactOnICAAP
      ,rr.MonetaryImpact
      ,rr.Liklihoodfactor
	  ,(rr.MonetaryImpact*rr.Liklihoodfactor) as ICAAPImpact
	  ,FrequencyRating
	  ,rrfr.risktitle as 'FrequencyRatingsTitle'
	  ,FinLossWorstCaseRating
	  ,rrflwcr.risktitle as 'FinLossWorstCaseRatingTitle'
	  ,FinLossBaseCaseRating
	  ,rrflbcr.risktitle as 'FinLossBaseCaseRatingTitle'
      ,rr.ActionRequired
      ,rr.ActionRoleId
	  ,rr.ActionPersonId
	  ,apav.PersonsName as ActionOwner
	  ,apav.AssignedRoleName as ActionRole 
      ,rr.ActionDeadlineDate
      ,rr.ICAAPComments
	  ,(CASE WHEN rr.RiskReviewed = 1 THEN 'Yes' ELSE 'No' END) AS RiskReviewed
	  ,rr.SalesForceThirdPartyServiceIssueID
	  ,rr.ReviewStatus
	  ,rr.HORJiraKey
	  ,rr.ROJiraKey
	  ,rre.RiskRegisterEventCreationDate AS RiskStatusChangeDate
  FROM [Risk].[RiskRegister] rr
   INNER JOIN [Risk].[SubCategories] sc ON sc.SubCategoryId = rr.SubCategoryId
   INNER JOIN [Risk].[Categories] c ON sc.CategoryId = c.CategoryId
   INNER JOIN [Risk].[SubCategoryRoleOwners] cro ON cro.SubCategoryId = rr.SubCategoryId
   INNER JOIN [Access.ManyWho].[PersonsActiveVw] pav ON pav.AssignedRoleId =cro.RoleId
   LEFT JOIN Events_CTE cte ON cte.RiskRegisterId = rr.RiskRegisterId
   LEFT JOIN [Risk].[RiskRegisterEvents] rre ON rre.RiskRegisterId = cte.RiskRegisterId AND cte.LatestDate = rre.[RiskRegisterEventCreationDate]
   LEFT JOIN [Risk].[RiskRegisterEventTypes] rret ON rret.RiskEventTypeId = rre.RiskEventTypeId
   LEFT JOIN [Core].[Persons] p ON p.PersonId = rre.RiskRegisterEventPersonId
   LEFT OUTER JOIN [Core].[Persons] rp ON rp.PersonId =rr. IdentifiedByPersonId
   LEFT OUTER JOIN [Access.ManyWho].[PersonsActiveVw] apav ON apav.PersonId =rr.ActionPersonId
   LEFT OUTER JOIN [Risk].[RiskImpact] gi ON gi.RiskImpactId = rr.GrossImpactId
   LEFT OUTER JOIN [Risk].[RiskProbability] gp ON gp.RiskProbabilityId = rr.GrossProbabilityId
   LEFT OUTER JOIN [Risk].[RiskImpact] ni ON ni.RiskImpactId = rr.NetImpactId
   LEFT OUTER JOIN [Risk].[RiskProbability] np ON np.RiskProbabilityId = rr.NetProbabilityId
   LEFT OUTER JOIN [Risk].[RiskImpactProbabilityMatrix] gipm ON gipm.RiskImpactId = rr.GrossImpactId AND gipm.RiskProbabilityId = rr.GrossProbabilityId  
   LEFT OUTER JOIN [Risk].[RiskImpactProbabilityMatrix] nipm ON nipm.RiskImpactId = rr.NetImpactId AND nipm.RiskProbabilityId = rr.NetProbabilityId
   LEFT OUTER JOIN [dbo].[Risk_Ratings] rrfr ON rrfr.[RatingsScore] = rr.FrequencyRating AND rrfr.RatingsType = 'Frequency Rating'
   LEFT OUTER JOIN [dbo].[Risk_Ratings] rrflwcr ON rrflwcr.[RatingsScore] = rr.FinLossWorstCaseRating AND rrflwcr.RatingsType = 'Financial Loss'
   LEFT OUTER JOIN [dbo].[Risk_Ratings] rrflbcr ON rrflbcr.[RatingsScore] = rr.FinLossBaseCaseRating AND rrflbcr.RatingsType = 'Financial Loss'
   ;