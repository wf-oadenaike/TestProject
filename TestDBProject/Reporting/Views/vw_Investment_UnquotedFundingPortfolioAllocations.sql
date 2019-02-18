
CREATE VIEW [Reporting].[vw_Investment_UnquotedFundingPortfolioAllocations]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_Investment_UnquotedFundingPortfolioAllocations]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu : 12/10/2017 JIRA: DAP-2201 [Create View Over Investment Objects]
--
-- 
-------------------------------------------------------------------------------------- 

SELECT
  ID,
  SecurityAllocationID,
  PortfolioID,
  AllocationAmount,
  CADIS_SYSTEM_INSERTED,
  CADIS_SYSTEM_UPDATED,
  CADIS_SYSTEM_CHANGEDBY

FROM Investment.T_UnquotedFundingPortfolioAllocations

