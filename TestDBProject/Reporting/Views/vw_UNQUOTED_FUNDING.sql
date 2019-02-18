
CREATE VIEW [Reporting].[vw_UNQUOTED_FUNDING]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_UNQUOTED_FUNDING]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu : 12/10/2017 JIRA: DAP-2201 [Create View Over dbo Objects]
--
-- 
-------------------------------------------------------------------------------------- 

SELECT

  FUNDING_ID,
  ISSUER,
  EDM_SEC_ID,
  TRADE_DATE,
  SETTLEMENT_DATE,
  FUNDING_STATUS,
  IS_LEGAL,
  IS_REPUTATIONAL,
  FUNDING_TYPE,
  FUNDING_SUB_TYPE,
  PUSH_BACK_UNIT,
  PUSH_BACK_MAGNITUDE,
  PULL_FORWARD_UNIT,
  PULL_FORWARD_MAGNITUDE,
  TECH_STATUS,
  CADIS_SYSTEM_INSERTED,
  CADIS_SYSTEM_UPDATED,
  CADIS_SYSTEM_CHANGEDBY

FROM dbo.T_UNQUOTED_FUNDING

