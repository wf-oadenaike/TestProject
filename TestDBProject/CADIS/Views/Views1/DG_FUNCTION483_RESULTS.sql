CREATE VIEW "CADIS"."DG_FUNCTION483_RESULTS" AS 
SELECT ET."SfAccountID",ET."SfAccountName",ET."SfAccountOwnerID",ET."SfAccountOwner",ET."SalesforceHyperlink",ET."AccountExceptionCnt",ET."ContactExceptionCnt" FROM "Sales.BP"."ufn_AccountContactExceptions"(NULL, NULL) ET
