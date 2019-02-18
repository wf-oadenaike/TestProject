
---------------------------------------


-------------------------------------------------------------------------------------- 
-- Name: Account Exception overrid view [Sales.BP].[ExceptionsAccountOverrideVw]
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi, 10/06/2017 
-- Reads Exported Exception to update EDM and SF
-- 
--------------------------------------------------------------------------------------

CREATE VIEW  [Sales.BP].[ExceptionsAccountOverrideVw]
AS
SELECT 
WA.AccAuthStatus, 
BillingCity, 
BillingCountry, 
BillingPostcode, 
'' AS BillingState, 
BillingStreet, 
WA.AccCalculatedPriority, 
'' AS AccEmail, 
WA.AccIsExistingRel,
WA.AccFax, 
FcaId, 
WA.AccFirmSegment, 
WA.AccIsKeyAccount,
Phone,
OutletId, 
AccountName, 
WA.AccOutletType, 
WA.Accownerid,
WA.AccOwnerName, 
WA.AccParentSivId, 
WA.AccPlatformsUsed, 
WA.AccIsPriorityClient, 
WA.RegionId, 
WA.AccSalesforceId, 
WA.AccSivId, 
WA.AccVerifiedBy, 
WA.AccWebsite 
FROM  [Staging.Salesforce.BP].[SalesteamAccountOverrides] AO
JOIN [Sales.BP].WoodfordAccount WA
ON	  WA.AccSalesforceId = AO.SfAccountID
AND	  WA.AccMatrixOutletId = AO.OutletId
AND   WA.AccFcaId = AO.FcaId
AND   WA.IsActive = 1

