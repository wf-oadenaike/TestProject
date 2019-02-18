
CREATE VIEW [Reporting].[vw_UNQUOTED_ALLOCATION]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_UNQUOTED_ALLOCATION]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu : 12/10/2017 JIRA: DAP-2201 [Create View Over dbo Objects]
--
-- 
-------------------------------------------------------------------------------------- 

SELECT

  ALLOCATION_ID,
  FUND_SHORT_NAME,
  ALLOCATION,
  FUNDING_ID,
  REVALUATION_ID,
  CADIS_SYSTEM_INSERTED,
  CADIS_SYSTEM_UPDATED,
  CADIS_SYSTEM_CHANGEDBY

FROM dbo.T_UNQUOTED_ALLOCATION

