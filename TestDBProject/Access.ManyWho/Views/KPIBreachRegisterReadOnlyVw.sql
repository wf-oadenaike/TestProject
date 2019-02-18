CREATE VIEW [Access.ManyWho].[KPIBreachRegisterReadOnlyVw]
	AS 
 SELECT
        kbr.KPIBreachId
      , kbr.KPIId
	  , kpi.KPIName
	  , kpi.KPIDescription
	  , kpi.RefreshFrequencyId
	  , rf.FrequencyName
      , kbr.KPIValue
      , kbr.ThresholdValue
      , kbr.RAGName
      , kbr.BreachDate
      , kbr.FollowUpAction
      , kbr.JoinGUID
	  , cro.RoleId as RiskOwnerRoleId
	  , r.RoleName as RiskOwnerRole
	  , p.PersonId as RiskOwnerPersonId
	  , p.PersonsName as RiskOwner
      , kbr.KPIBreachCreationDatetime
      , kbr.KPIBreachLastModifiedDatetime
  FROM [KPI].[KPIBreachRegister] kbr
  INNER JOIN [KPI].[MeasuredKPIs] kpi
  ON kbr.KPIId = kpi.KPIId
  INNER JOIN [KPI].[RefreshFrequency] rf
  ON rf.RefreshFrequencyId = kpi.RefreshFrequencyId
  INNER JOIN [KPI].[KPIRiskCategoryRelationship] rcr
  ON kbr.KPIId = rcr.KPIId
  INNER JOIN [Risk].[SubCategoryRoleOwners] cro
  ON rcr.[RiskSubCategoryId] = cro.[SubCategoryId]
  LEFT OUTER JOIN [Core].[Roles] r
  ON  cro.RoleId = r.RoleId
  LEFT OUTER JOIN [Core].[RolePersonRelationship] rpr
  ON r.RoleId = rpr.RoleId
  AND rpr.ActiveFlag = 1
  LEFT OUTER JOIN [Core].[Persons] p
  ON rpr.PersonId = p.PersonId
  WHERE rpr.ActiveFlag = 1
  AND GetDate() BETWEEN rpr.[ActiveFromDatetime] AND rpr.[ActiveToDatetime]
  
;
