
CREATE VIEW [Reporting].[vw_Investment_UnquotedSecurities]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_Investment_UnquotedSecurities]
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
  Name,
  Ticker,
  IssuerID,
  CurrencyID,
  CADIS_SYSTEM_INSERTED,
  CADIS_SYSTEM_UPDATED,
  CADIS_SYSTEM_CHANGEDBY,
  ACDClientID

FROM Investment.T_UnquotedSecurities

