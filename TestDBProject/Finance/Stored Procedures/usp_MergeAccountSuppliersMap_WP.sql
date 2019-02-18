


CREATE PROCEDURE [Finance].[usp_MergeAccountSuppliersMap_WP]
		@ControlId BIGINT=-1
AS
-------------------------------------------------------------------------------------- 
-- Name:			Finance.usp_MergeAccountCategories_WP
-- 
-- Note:			
-- 
-- Author:			Josef Tapper
-- Date:			31/05/2017
-------------------------------------------------------------------------------------- 
-- History:			Replacement of Finance.usp_MergeAccountCategories o
-- use JournalLineID from WP instead of Transaction Number and Nominal Code
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Finance].[usp_MergeAccountSuppliers]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;

	WITH Src AS
		(SELECT Distinct Coalesce(ThrogID,cast(AccountSupplierMapID as varchar(max))) as AccountRef, Coalesce(WPSupplier,ThrogSupplier) as Supplier
					,@ControlId as ControlId
			FROM Finance.AccountSuppliers_Map
		)
	MERGE INTO Finance.AccountSuppliers Tar
	USING Src
	ON ( Tar.AccountRef = Src.AccountRef)
	WHEN NOT MATCHED
		THEN INSERT (AccountRef, Supplier, ControlId)
			 VALUES (Src.AccountRef, Src.Supplier, Src.ControlId)
	WHEN MATCHED AND ( Tar.Supplier <> Src.Supplier)
		THEN UPDATE SET Supplier = Src.Supplier
						, ControlId = Src.ControlId
	OUTPUT $action, inserted.*
	;
	SET @InsertRowCount = @@ROWCOUNT;

	SELECT @ProcessRowCount AS ProcessRowCount
		, @InsertRowCount AS InsertRowCount
		, @UpdateRowCount AS UpdateRowCount
		, @DeleteRowCount AS DeleteRowCount
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

--BEGIN
	
--	DECLARE @CID BIGINT;
--	SELECT @CID = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
--	EXEC [Finance].[usp_MergeAccountCategories] @ControlId =20000401000000

--END

