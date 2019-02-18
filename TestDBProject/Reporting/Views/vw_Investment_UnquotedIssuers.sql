
CREATE VIEW [Reporting].[vw_Investment_UnquotedIssuers]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_UnquotedIssuers]
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
  LegalName,
  CountryID,
  CurrencyID,
  SubsectorID,
  SFAccountID,
  BoxFolderID,
  JiraEpicKey,
  CADIS_SYSTEM_INSERTED,
  CADIS_SYSTEM_UPDATED,
  CADIS_SYSTEM_CHANGEDBY,
  IsActive,
  FundManagerPersonID,
  InvestmentAnalystPersonID,
  CompanyNumber,
  CompanyType,
  KnownName
FROM Investment.T_UnquotedIssuers

