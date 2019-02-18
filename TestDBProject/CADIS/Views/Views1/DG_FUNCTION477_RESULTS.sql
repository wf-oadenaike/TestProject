﻿CREATE VIEW "CADIS"."DG_FUNCTION477_RESULTS" AS 
SELECT ET."MakeContact",ET."SalesforceHyperlink",ET."SfAccountId",ET."Sector",ET."AccountName",ET."AccountOwnerId",ET."PostCode",ET."IsPriorityClient",ET."CurrOutletOwnSales",ET."PrevOutletOwnSales",ET."SalesMoveValue",ET."CurrOutletMarketSales",ET."PrevOutletMarketSales",ET."CurrMktShare",ET."PrevMktShare",ET."MktShareMoveValue",ET."SalesFromDate",ET."SalesToDate",ET."OverrideStatus",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Sales.BP"."FCAccountMovementOverride" ET WITH (NOLOCK)