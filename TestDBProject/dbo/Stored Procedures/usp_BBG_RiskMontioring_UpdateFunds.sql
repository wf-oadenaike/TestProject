

CREATE PROCEDURE [dbo].[usp_BBG_RiskMontioring_UpdateFunds] AS
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[usp_UpdateFunds]
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

DECLARE @strProcedureName VARCHAR(100) = '[dbo].[usp_BBG_RiskMontioring_UpdateFunds]';

BEGIN TRANSACTION


--ADD FundName from FileName
UPDATE T_BBG_RISK_MONITORING_IN_ALLOCATION_STAGING
SET Fund = CASE WHEN left(right(left(FILENAME,23),8),7)  like  '%WIMIFF%' then 'WIMIFF '
				  WHEN left(right(left(filename,23),8),7)  LIKE  '%WIMPCT%' then 'WIMPCT'
				  WHEN left(right(left(filename,23),8),7)  LIKE  '%OMNIS1%' then 'OMNIS'
				  WHEN left(right(left(filename,23),8),7)  LIKE  '%OMWEIF%' then 'OMWEIF'
				  WHEN left(right(left(FILENAME,23),8),7)  LIKE  '%SJPHIY%' then 'SJPHIY'
				  WHEN left(right(left(filename,23),8),7)  LIKE  '%SJPDST%' then 'SJPDST'
				  WHEN left(right(left(filename,23),8),7)  LIKE  '%SJPNUK%' then 'SJPNUK'
				  WHEN left(right(left(filename,23),8),7)  LIKE  '%SJPXUK%' then 'SJPXUK'
				  WHEN left(right(left(filename,23),8),7) LIKE   '%WEST01%' THEN 'WEST01'
				  WHEN left(right(left(filename,23),8),7) LIKE   '%WIMEIF%' THEN 'WIMEIF'
				    WHEN left(right(left(filename,23),8),7) LIKE   '%BDSEIF%' THEN 'BDSEIF'
			 	  else  left(right(left(FILENAME,23),8),7)
		END   




 

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



