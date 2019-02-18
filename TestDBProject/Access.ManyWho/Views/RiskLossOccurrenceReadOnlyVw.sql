CREATE  VIEW [Access.ManyWho].[RiskLossOccurrenceReadOnlyVw]
AS
SELECT rlo.[LossOccurrenceId]
      ,rlo.[Status]
      ,c.[CategoryId]
	  ,c.Category
      ,rr.[SubCategoryId]
	  ,sc.SubCategory AS SubCategory
      ,rlo.[RiskLossCause]
      ,rlo.[DateOccurred]
      ,rlo.[DateIdentified]
      ,rlo.[ImpactType]
      ,rlo.[OccurrenceLocation]
	  ,rlo.[IsActive]
	  ,rlo.SubmittedByPersonId
      ,sp.PersonsName as SubmittedBy
	  ,rlo.ReviewedByPersonId
      ,rp.PersonsName as ReviewedBy
      ,rlo.[MonetaryGainLossAmount]
      ,rlo.[ImpactRecoveries]
	  ,rlo.[ImpactDetails] 
      ,rlo.[FollowUpAction]
	  ,rr.[RiskRegisterId]
	  ,rr.[RiskEvent]
	  ,p.PersonsName as RiskOwner
	  ,rlo.[BusinessAreasAffected]
      ,rlo.[EventDetails]
      ,rlo.[ImmediateRemedialAction]
	  ,rlo.[JiraTaskKey]
	  ,rlo.[JiraTaskKey2]
	  ,rlo.[IsNearMiss]
      ,rlo.[DocumentationFolderLink]
      ,rlo.[JoinGUID]
	  ,rlo.[LossOccurrenceCreationDatetime]
	  ,rlo.[LossOccurrenceLastModifiedDatetime]
      ,rlo.[CADIS_SYSTEM_INSERTED]
      ,rlo.[CADIS_SYSTEM_UPDATED]
      ,rlo.[CADIS_SYSTEM_CHANGEDBY]
      ,rlo.[CADIS_SYSTEM_PRIORITY]
      ,rlo.[CADIS_SYSTEM_TIMESTAMP]
      ,rlo.[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Risk].[RiskLossOccurrence] rlo
  INNER JOIN [Core].[Persons] sp
  ON rlo.SubmittedByPersonId = sp.PersonId
  LEFT OUTER JOIN [Core].[Persons] rp
  ON rlo.ReviewedByPersonId = rp.PersonId
  INNER JOIN [Risk].[RiskRegister] rr
  ON rr.RiskRegisterId = rlo.RiskRegisterId
  INNER JOIN [Risk].[SubCategories] sc 
  ON sc.SubCategoryId = rr.SubCategoryId
  INNER JOIN [Risk].[Categories] c 
  ON sc.CategoryId = c.CategoryId
  INNER JOIN [Risk].[SubCategoryRoleOwners] cro 
  ON cro.SubCategoryId = sc.SubCategoryId
  INNER JOIN [Core].[RolePersonRelationship] rpr 
  ON rpr.RoleId = cro.RoleId
  INNER JOIN [Core].[Persons] p
  ON rpr.PersonId = p.[PersonId]
  WHERE rpr.[ActiveFlag] = 1
  AND GetDate() BETWEEN rpr.ActiveFromDatetime AND rpr.ActiveToDatetime
  UNION 
 SELECT rlo.[LossOccurrenceId]
      ,rlo.[Status]
      ,NULL as CategoryId
	  ,NULL as Category
      ,NULL as SubCategoryId
	  ,NULL as SubCategory
      ,rlo.[RiskLossCause]
      ,rlo.[DateOccurred]
      ,rlo.[DateIdentified]
      ,rlo.[ImpactType]
      ,rlo.[OccurrenceLocation]
	  ,rlo.[IsActive]
	  ,rlo.SubmittedByPersonId
      ,sp.PersonsName as SubmittedBy
	  ,rlo.ReviewedByPersonId
      ,rp.PersonsName as ReviewedBy
      ,rlo.[MonetaryGainLossAmount]
      ,rlo.[ImpactRecoveries]
	  ,rlo.[ImpactDetails] 
      ,rlo.[FollowUpAction]
	  ,NULL as RiskRegisterId
	  ,NULL as RiskEvent
	  ,NULL as RiskOwner
	  ,rlo.[BusinessAreasAffected]
      ,rlo.[EventDetails]
      ,rlo.[ImmediateRemedialAction]
	  ,rlo.[JiraTaskKey]
	  ,rlo.[JiraTaskKey2]
	  ,rlo.[IsNearMiss]
      ,rlo.[DocumentationFolderLink]
      ,rlo.[JoinGUID]
	  ,rlo.[LossOccurrenceCreationDatetime]
	  ,rlo.[LossOccurrenceLastModifiedDatetime]
      ,rlo.[CADIS_SYSTEM_INSERTED]
      ,rlo.[CADIS_SYSTEM_UPDATED]
      ,rlo.[CADIS_SYSTEM_CHANGEDBY]
      ,rlo.[CADIS_SYSTEM_PRIORITY]
      ,rlo.[CADIS_SYSTEM_TIMESTAMP]
      ,rlo.[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Risk].[RiskLossOccurrence] rlo
  INNER JOIN [Core].[Persons] sp
  ON rlo.SubmittedByPersonId = sp.PersonId
  LEFT OUTER JOIN [Core].[Persons] rp
  ON rlo.ReviewedByPersonId = rp.PersonId
  WHERE rlo.RiskRegisterId IS NULL 
  ;
