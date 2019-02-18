CREATE PROCEDURE [Sales.BP].[usp_UpdateSfAccountDumpRegion]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Sales.BP.usp_UpdateSfAccountDumpRegion
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			12/10/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Sales.BP].[usp_UpdateSfAccountDumpRegion]';


	UPDATE ad
	SET ad.[AccRegionCode] = CAST(r.[RegionId] as varchar) + ' ' + r.[RegionName]
	FROM [Staging.Salesforce.BP].[SfAccountDump] ad
	INNER JOIN [Sales.BP].[Region] r
	ON ad.[AccOwnerId] = r.[AccountOwnerId]
	WHERE ad.[AccRegionCode] IS NULL
	;


END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		Return @ErrorNumber;
END CATCH
