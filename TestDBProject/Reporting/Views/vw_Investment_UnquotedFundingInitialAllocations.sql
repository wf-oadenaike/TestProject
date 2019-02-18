
CREATE VIEW [Reporting].[vw_Investment_UnquotedFundingInitialAllocations]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_Investment_UnquotedFundingInitialAllocations]
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
  FundingID,
  PortfolioID,
  AllocationAmount
FROM Investment.T_UnquotedFundingInitialAllocations

