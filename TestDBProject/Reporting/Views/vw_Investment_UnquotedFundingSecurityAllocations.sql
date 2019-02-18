
CREATE VIEW [Reporting].[vw_Investment_UnquotedFundingSecurityAllocations]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_Investment_UnquotedFundingSecurityAllocations]
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
  SecurityID,
  AllocationAmount,
  RevaluationID,
  CADIS_SYSTEM_INSERTED,
  CADIS_SYSTEM_UPDATED,
  CADIS_SYSTEM_CHANGEDBY

FROM Investment.T_UnquotedFundingSecurityAllocations

