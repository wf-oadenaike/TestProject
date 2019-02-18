﻿CREATE VIEW "CADIS"."IL_Organisation_Unquoted_Securities" AS 
SELECT V."UnquotedSecuritiesId" AS "Unquoted Securities ID",V."UnquotedCompanyId" AS "Unquoted Company ID", J2.DF AS "Currency Code", J3.DF AS "Asset Type",V."StockName" AS "Stock Name",V."ShareClass" AS "Share Class",V."Tranche" AS "Tranche",V."BrokerSalesforceId" AS "Broker Salesforce ID",V."EstimatedPrice" AS "Estimated Price",V."EstimatedPriceDate" AS "Estimated Price Date",V."InitialPrice" AS "Initial Price",V."InitialPriceDate" AS "Initial Price Date",V."LatestPrice" AS "Latest Price",V."LatestPriceDate" AS "Latest Price Date",V."ClosingDate" AS "Closing Date", J15.DF AS "Country of Risk", J16.DF AS "Country of Incorporation",V."Bible" AS "Bible",V."BBGSetup" AS "BBG Setup",V."Ticker" AS "Ticker",V."BBGID" AS "BBG ID",V."BBGSecurityId" AS "BBG Security ID",V."BBGCompanyId" AS "BBG Company ID",V."NTSent" AS "NT Sent",V."BBGUniqueId/FOID" AS "BBG Unique ID\FOID",V."CustodianId" AS "Custodian ID",V."Notes" AS "Notes",V."UnquotedSecuritiesCreationDate" AS "Unquoted Securities Creation Date", J30.DF AS "Unquoted Securities Created By Person ID",V."UnquotedSecuritiesLastModifiedDate" AS "Unquoted Securites Last Modified Date", J32.DF AS "Unquoted Securities Last Modified By Person ID",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_TIMESTAMP",V."CADIS_SYSTEM_LASTMODIFIED" FROM "Organisation"."UnquotedSecurities" V LEFT OUTER JOIN (SELECT DISTINCT "ISO_CCY_CD" AS JF,"ISO_CCY_CD" AS DF FROM "dbo"."T_REF_CURRENCY")  J2 ON  J2.JF=V."CurrencyCode" LEFT OUTER JOIN (SELECT DISTINCT "ASSET_TYPE" AS JF,"ASSET_TYPE" AS DF FROM "dbo"."T_REF_ASSET_TYPE")  J3 ON  J3.JF=V."AssetType" LEFT OUTER JOIN (SELECT DISTINCT "ISO_CTY_CD" AS JF,"ISO_CTY_CD" AS DF FROM "dbo"."T_REF_COUNTRY")  J15 ON  J15.JF=V."CountryOfRisk" LEFT OUTER JOIN (SELECT DISTINCT "CTY_NAME" AS JF,"CTY_NAME" AS DF FROM "dbo"."T_REF_COUNTRY")  J16 ON  J16.JF=V."CountryOfIncorporation" LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J30 ON  J30.JF=V."UnquotedSecuritiesCreatedByPersonId" LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J32 ON  J32.JF=V."UnquotedSecuritiesLastModifiedByPersonId"
