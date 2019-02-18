
CREATE VIEW [Reporting].[vw_Investment_UnquotedFundings]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_Investment_UnquotedFundings]
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
  IssuerID,
  TypeID,
  SubtypeID,
  StatusID,
  TradeDate,
  SettlementDate,
  IsLegalCommitment,
  IsReputationalCommitment,
  FlexBackUnit,
  FlexBackMagnitude,
  FlexForwardUnit,
  FlexForwardMagnitude,
  JiraIssueKey,
  CADIS_SYSTEM_INSERTED,
  CADIS_SYSTEM_UPDATED,
  CADIS_SYSTEM_CHANGEDBY,
  FullAllocationsProvided
FROM Investment.T_UnquotedFundings

