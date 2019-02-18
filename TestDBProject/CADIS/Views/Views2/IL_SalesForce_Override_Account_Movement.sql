﻿CREATE VIEW "CADIS"."IL_SalesForce_Override_Account_Movement" AS 
SELECT V."SfAccountId" AS "SF Account ID",V."Sector" AS "Sector",V."AccountName" AS "Account Name",V."SalesforceHyperlink" AS "SF", J4.DF AS "Account Owner",V."PostCode" AS "Billing Postcode",V."IsPriorityClient" AS "Priority Client",V."CurrOutletOwnSales" AS "Current Outlet Own Sales",V."PrevOutletOwnSales" AS "Previous Outlet Own Sales",V."SalesMoveValue" AS "Sales Move",V."CurrOutletMarketSales" AS "Current Outlet Market Sales",V."PrevOutletMarketSales" AS "Previous Outlet Market Sales",V."CurrMktShare" AS "Current Market Share",V."PrevMktShare" AS "Previous Market Share",V."MktShareMoveValue" AS "Market Share Move",V."SalesFromDate" AS "Sales From",V."SalesToDate" AS "Sales To",V."MakeContact" AS "Make Contact",V."OverrideStatus" AS "Override Status",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY" FROM "Sales.BP"."FCAccountMovementOverride" V LEFT OUTER JOIN (SELECT DISTINCT "FullEmployeeBK" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J4 ON  J4.JF=V."AccountOwnerId"
