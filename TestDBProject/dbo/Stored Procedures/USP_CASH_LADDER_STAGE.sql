CREATE PROCEDURE [dbo].[USP_CASH_LADDER_STAGE] AS
-------------------------------------------------------------------------------------- 
-- Name:			[dbo].[USP_CASH_LADDER_STAGE]
-- 
-- Params:			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
-- D.Bacchus:		22/06/2017			JIRA: DAP-1032
--
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY

	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE	@strProcedureName		VARCHAR(100)	= '[dbo].[USP_CASH_LADDER_STAGE]';

	BEGIN TRANSACTION


		declare @table_id int  

		select @table_id = min( CASH_LADDER_ID ) from dbo.T_CASH_LADDER_STAGE

		while @table_id is not null
		begin
    
			if exists (select 1 from dbo.T_CASH_LADDER_STAGE where CASH_LADDER_ID = @table_id and FUND IS NULL)
			begin	
				update dbo.T_CASH_LADDER_STAGE set fund = (select fund from dbo.T_CASH_LADDER_STAGE where CASH_LADDER_ID = @table_id -1) where CASH_LADDER_ID = @table_id
			end

			select @table_id = min( CASH_LADDER_ID ) from dbo.T_CASH_LADDER_STAGE where CASH_LADDER_ID > @table_id
		end


	

	COMMIT TRANSACTION

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

	EXECUTE dbo.usp_LogProcErrors



/*

-- this secion can be enabled if you want the error to print on the screen

    DECLARE
        @ERROR_SEVERITY INT,
        @ERROR_STATE    INT,
        @ERROR_NUMBER   INT,
        @ERROR_LINE     INT,
        @ERROR_MESSAGE  NVARCHAR(4000);


    SELECT
        @ERROR_SEVERITY = ERROR_SEVERITY(),
        @ERROR_STATE    = ERROR_STATE(),
        @ERROR_NUMBER   = ERROR_NUMBER(),
        @ERROR_LINE     = ERROR_LINE(),
        @ERROR_MESSAGE  = @strProcedureName + ' - ' + ERROR_MESSAGE() ;

    RAISERROR('Msg %d, Line %d, :%s',
        @ERROR_SEVERITY,
        @ERROR_STATE,
        @ERROR_NUMBER,
        @ERROR_LINE,
        @ERROR_MESSAGE);
*/

END CATCH

