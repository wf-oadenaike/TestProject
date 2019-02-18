CREATE FUNCTION "CADIS"."IL_SalesForce_Account_Contact_Exceptions" (
@ExceptionStatus VARCHAR(30)
, @AccountOwnerId VARCHAR(18)
)
RETURNS TABLE AS RETURN (
SELECT V."SfAccountID" AS "SF Account ID",V."SfAccountName" AS "SF Account Name",V."SfAccountOwnerID" AS "SF Account Owner ID",V."SfAccountOwner" AS "SF Account Owner",V."SalesforceHyperlink" AS "SF",V."AccountExceptionCnt" AS "Account Exceptions",V."ContactExceptionCnt" AS "Contact Exceptions" FROM "Sales.BP"."ufn_AccountContactExceptions"(@ExceptionStatus, @AccountOwnerId) V
)
