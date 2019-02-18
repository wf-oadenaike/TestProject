﻿CREATE VIEW "CADIS"."DG_FUNCTION108_RESULTS" AS 
SELECT ET."UnquotedSecuritiesId",ET."UnquotedCompanyId",ET."CurrencyCode",ET."AssetType",ET."StockName",ET."ShareClass",ET."Tranche",ET."BrokerSalesforceId",ET."EstimatedPrice",ET."EstimatedPriceDate",ET."InitialPrice",ET."InitialPriceDate",ET."LatestPrice",ET."LatestPriceDate",ET."ClosingDate",ET."CountryOfRisk",ET."CountryOfIncorporation",ET."Bible",ET."BBGSetup",ET."Ticker",ET."BBGID",ET."BBGSecurityId",ET."BBGCompanyId",ET."NTSent",ET."BBGUniqueId/FOID",ET."CustodianId",ET."Notes",ET."WorkflowVersionGUID",ET."JoinGUID",ET."UnquotedSecuritiesCreationDate",ET."UnquotedSecuritiesCreatedByPersonId",ET."UnquotedSecuritiesLastModifiedDate",ET."UnquotedSecuritiesLastModifiedByPersonId",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Organisation"."UnquotedSecurities" ET WITH (NOLOCK)