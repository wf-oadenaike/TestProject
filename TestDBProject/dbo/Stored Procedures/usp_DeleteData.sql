
CREATE PROCEDURE [dbo].[usp_DeleteData] 
	@tableName NVARCHAR(255),
	@updatedDateLookbackDays NVARCHAR(11)
AS
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[usp_DeleteData]
-- 
-- Params: @tableName, @lastUpdated
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- SBurns:	21/01/2019	To be used within an EDM 9000 solution to clean-up old table data
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY

SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @strProcedureName VARCHAR(100) = '[dbo].[usp_DeleteData]';

BEGIN TRANSACTION

	DECLARE @SQLString AS NVARCHAR(500);

	IF (@tableName IS NOT NULL AND TRY_CONVERT(INT,@updatedDateLookbackDays) IS NOT NULL)
	BEGIN
		SET @SQLString = N'DELETE FROM [dbo].[' + @tableName + '] WHERE CONVERT(DATETIME,DATEADD(DD,' + @updatedDateLookbackDays + ', [CADIS_SYSTEM_UPDATED]),120) <= GETDATE()';
		EXEC(@SQLString);
	END

COMMIT TRANSACTION

END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;


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

RAISERROR('Msg %d, Line %d, :%s',
@ERROR_SEVERITY,
@ERROR_STATE,
@ERROR_NUMBER,
@ERROR_LINE,
@ERROR_MESSAGE);

END CATCH

