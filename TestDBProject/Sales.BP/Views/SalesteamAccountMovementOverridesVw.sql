

--------------------------------------------
-------------------------------------------------------------------------------------- 
-- Name: Account Movement Exported view [Sales.BP].[SalesteamAccountMovementOverridesVw] 
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi, 10/06/2017 
-- Reads Exported Account Movement Exception to update EDM and SF
-- 
--------------------------------------------------------------------------------------
CREATE VIEW [Sales.BP].[SalesteamAccountMovementOverridesVw] 
As
SELECT
Sfaccountid,
1 As "MakeContact",
Description = 'The Account had ' +
CASE WHEN Sector = 'SPECSECT' THEN 'Specialist Sector' ELSE 'UK Income' END +' '+ 
ISNULL(Metrics,'Market Sales') + ' Move of '+ ' '+ CASE WHEN Metrics IS NULL THEN '£' ELSE '%' END + 
Convert(varchar, CAST(Movevalue AS Money),1)
FROM [Staging.Salesforce.BP].[SalesteamAccountMovementOverrides]

