CREATE PROCEDURE [Core].[usp_MergeDepartments]
		@ControlId BIGINT=-1
AS
-------------------------------------------------------------------------------------- 
-- Name:			Core.usp_MergeDepartments
-- 
-- Note:			
-- 
-- Author:			I Pearson
-- Date:			06/05/2015
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Core].[usp_MergeDepartments]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;

	MERGE INTO Core.Departments Tar
	USING (SELECT d.[Department Code] as DepartmentNumberBK, d.[Department: Department] as DepartmentName, d.[Department: ID] as DepartmentSrcId, ss.SourceSystemId
				, CASE d.[No longer in use] WHEN 'false' then 1 else 0 end as ActiveFlag
			FROM [Staging.Salesforce].[DepartmentSrc] d
				LEFT OUTER JOIN Audit.SourceSystems ss
					ON ('SFDC' = SourceSystemCode)
			) as Src
	ON ( Tar.DepartmentNumber = Src.DepartmentNumberBK)
	WHEN NOT MATCHED
		THEN INSERT (DepartmentNumber, DepartmentName, ControlId, ActiveFlag, DepartmentSrcId, SourceSystemId
						, DepartmentCreationDatetime, DepartmentLastModifiedDatetime)
			 VALUES (Src.DepartmentNumberBK, Src.DepartmentName, @ControlId, 1, Src.DepartmentSrcId, Src.SourceSystemId
						, GetDate(), GetDate())
	WHEN MATCHED
		AND (Tar.DepartmentName <> Src.DepartmentName
		OR Tar.ActiveFlag <> Src.ActiveFlag
		OR ISNULL(Tar.DepartmentSrcId,-1) <> ISNULL(Src.DepartmentSrcId,-1)
		
		)
		THEN UPDATE SET
				DepartmentName = Src.DepartmentName
				, ControlId = @ControlId
				, ActiveFlag = Src.ActiveFlag
				, DepartmentSrcId = ISNULL(Src.DepartmentSrcId,-1)
				, SourceSystemId = ISNULL(Src.SourceSystemId,2)
				, DepartmentLastModifiedDatetime = GetDate()
				, ActiveFlagDateTime = CASE WHEN Tar.ActiveFlag = 1 AND Src.ActiveFlag = 0 THEN GetDate() ELSE ActiveFlagDateTime END

    WHEN NOT MATCHED BY SOURCE AND Tar.ActiveFlag = 1 
			THEN UPDATE SET   Tar.ActiveFlag = 0
							, Tar.DepartmentLastModifiedDatetime = GetDate()
							, Tar.ControlId = @ControlId
							--CAST( CONVERT( varchar, GetDate(), 112) 
								--+ SUBSTRING( REPLACE( CONVERT( varchar, GetDate(), 114), ':',''), 1, 6) as bigint)
--	OUTPUT $action, inserted.*
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

--	EXEC [Core].[usp_MergeDepartments] @ControlId =-1
