CREATE VIEW [Access.ManyWho].[UnquotedSecuritiesReadOnlyVw]
AS
SELECT  cs.[SecurityBloombergId]
	  , cs.[CompanyId]
	  , uc.[CompanyName]
      , ms.[SECURITY_NAME] as SecurityName 
	  , ms.[SECURITY_DESCRIPTION]
      , ms.[SECURITY_SHORTNAME]
      , ms.[ASSET_TYPE]
	  , ms.[ISIN]
      , ms.[SECURITY_TYPE]
      , ms.[SEDOL]
      , ms.[TICKER]
      , ms.[SECURITY_ISO_CCY]
      , ms.[QUOTE_TYPE]
      , ms.[DAYS_TO_SETTLE]
      , ms.[UNIQUE_BLOOMBERG_ID]
      , ms.[SECURITY_IDENTIFIER]
      , ms.[ISSUER]
      , ms.[PRIMARY_EXCHANGE_NAME]
  FROM [Investment].[CompanySecurities] cs
  INNER JOIN [Investment].[Companies] uc
  ON cs.CompanyId = uc.CompanyId
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON cs.SecurityBloombergId = ms.UNIQUE_BLOOMBERG_ID
  WHERE uc.IsQuotedCompany=0
