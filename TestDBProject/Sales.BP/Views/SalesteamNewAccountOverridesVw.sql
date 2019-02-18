---------------------------------------------

-------------------------------------------------------------------------------------- 
-- Name: New Accounts Exported view [Sales.BP].[SalesteamNewAccountOverridesVw] 
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi, 10/06/2017 
-- Reads Exported New Account Exception to update EDM and SF
-- 
--------------------------------------------------------------------------------------
CREATE VIEW [Sales.BP].[SalesteamNewAccountOverridesVw] 
AS 

SELECT 
sfa.AccSalesforceid,
sfa.AccMatrixOutletId,
sfa.AccFcaId,
AO.AccountOwnerID,
1 AS MakeContact
FROM [Staging.Salesforce.BP].[SalesteamNewAccountOverrides] AO
JOIN [Staging.Salesforce.BP].[MxAccountRaw] sfa
ON AO.MatrixOutletID = sfa.AccMatrixOutletId
AND AO.FcaId = sfa.AccFcaId
and sfa.AccSalesforceid IS NOT NULL

-----------------------------




