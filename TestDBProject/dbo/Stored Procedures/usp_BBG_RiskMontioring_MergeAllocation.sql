
CREATE PROCEDURE [dbo].[usp_BBG_RiskMontioring_MergeAllocation] AS
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[usp_BBG_RiskMontioring_MergeAllocation]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu : 25/06/2018 
--
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @strProcedureName VARCHAR(100) = '[dbo].[usp_BBG_RiskMontioring_MergeAllocation]';

BEGIN TRANSACTION


-- Merge new Stocks to Allocation from Staging 
Merge [dbo].[T_BBG_RISK_MONITORING_IN_ALLOCATION] as target 
USING (SELECT FileName, Fund, Sector, Port, Bench, PlusMinus, [File Date]
			FROM  [dbo].[T_BBG_RISK_MONITORING_IN_ALLOCATION_STAGING]
			WHERE SECTOR = 'STOCKS') AS SOURCE 
	ON (TARGET.FILENAME = SOURCE.FILENAME)
WHEN NOT MATCHED 
THEN INSERT (FileName, Fund, Sector, Port, Bench, PlusMinus, [File Date])
VALUES(FileName, Fund, Sector, Port, Bench, PlusMinus, [File Date]);




 

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

DECLARE
@ERROR_SEVERITY INT,
@ERROR_STATE INT,
@ERROR_NUMBER INT,
@ERROR_LINE INT,
@ERROR_MESSAGE NVARCHAR(4000);

SELECT
@ERROR_SEVERITY = ERROR_SEVERITY(),
@ERROR_STATE = ERROR_STATE(),
@ERROR_NUMBER = ERROR_NUMBER(),
@ERROR_LINE = ERROR_LINE(),
@ERROR_MESSAGE = ERROR_MESSAGE();

RAISERROR('Msg %d, Line %d, :%s',
@ERROR_SEVERITY,
@ERROR_STATE,
@ERROR_NUMBER,
@ERROR_LINE,
@ERROR_MESSAGE);
END CATCH

-- DO NOT REMOVE
IF (XACT_STATE()) IN (1, -1) 
BEGIN 
PRINT 
N'The transaction has not been committed.' + 
'Rolling back transaction.' 
ROLLBACK TRANSACTION; 
END;



