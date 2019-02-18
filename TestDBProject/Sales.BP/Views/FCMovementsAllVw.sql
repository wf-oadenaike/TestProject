CREATE view [Sales.BP].[FCMovementsAllVw] as
-------------------------------------------------------------------------------------- 
-- Name: Financial Clarity All View [Sales.BP].[FCMovementsAllVw] 
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi, 10/06/2017 
-- Reads Financial Clarity Movements data from the Matrix FC refresh file
-- 
--------------------------------------------------------------------------------------


SELECT * FROM [Sales.BP].[FCMovementUKIncomeVw]
UNION ALL 
SELECT * FROM [Sales.BP].[FCMovementSpecSectVw]