
CREATE VIEW [Reporting].[vw_UNQUOTED_REVALUATION]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_UNQUOTED_REVALUATION]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu : 12/10/2017 JIRA: DAP-2201 [Create View Over dbo Objects]
--
-- 
-------------------------------------------------------------------------------------- 

SELECT

  REVALUATION_ID,
  FUNDING_ID,
  ISSUER,
  EDM_SEC_ID,
  REVALUATION_TYPE,
  REVALUATION_SUB_TYPE,
  EXPECTED_ENACTMENT_DATE,
  ACTUAL_ENACTMENT_DATE,
  FM_LOW,
  FM_HIGH,
  DP_LOW,
  DP_HIGH,
  ACD,
  STATUS_INTERNAL,
  STATUS_EXTERNAL,
  TECH_STATUS,
  CADIS_SYSTEM_INSERTED,
  CADIS_SYSTEM_UPDATED,
  CADIS_SYSTEM_CHANGEDBY

FROM dbo.T_UNQUOTED_REVALUATION
