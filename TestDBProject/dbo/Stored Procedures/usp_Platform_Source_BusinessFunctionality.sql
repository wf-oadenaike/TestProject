-- =============================================
-- Author:     xxxxxxxxxx
-- Create date: 
-- Description: 
--
-- Parameters:

-- Returns:   
--
-- Change History:
--   
--   
--   
-- =============================================
--Upper casing T-SQL keywords and built-in functions
--Start Stored Procedure with usp

CREATE PROCEDURE dbo.usp_Platform_Source_BusinessFunctionality
   
AS
BEGIN TRY

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @strProcedureName VARCHAR(100) = 'dbo.usp_Platform_Source_BusinessFunctionality';

BEGIN TRANSACTION

    ------------- Declarations -----------------
	
		--Using the schema prefix
		
		--Using SET NOCOUNT ON
		
		-- Magic Goes Here...

		-- Place Brief Comment on each set of functional code to improve readability, declare intentions and increase understanding. ...
  
  SELECT 1/0

COMMIT TRANSACTION
END TRY

BEGIN CATCH

IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;


-- Write errors to table: dbo.LogProcErrors

EXECUTE dbo.usp_LogProcErrors

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
@ERROR_MESSAGE = @strProcedureName + ' - ' + ERROR_MESSAGE() ;

    --SELECT ERROR_NUMBER() AS ErrorNumber
    -- ,ERROR_SEVERITY() AS ErrorSeverity
    -- ,ERROR_STATE() AS ErrorState
    -- ,ERROR_PROCEDURE() AS ErrorProcedure
    -- ,ERROR_LINE() AS ErrorLine
    -- ,ERROR_MESSAGE() AS ErrorMessage;

END CATCH

