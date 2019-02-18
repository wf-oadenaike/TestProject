CREATE PROCEDURE [Fact].[usp_MergeActuals]
		@ControlId BIGINT=-1
AS
-------------------------------------------------------------------------------------- 
-- Name:			Fact.usp_MergeActuals
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

	Set NoCount on;
	SET DATEFORMAT dmy;

	BEGIN TRANSACTION

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Fact].[usp_MergeActuals]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END

	DECLARE @UpdRst table( MergeAction Varchar(20), FinancialFactId bigint, DepartmentId smallint
					, PostingDateId int, TransactionDateId int
					, ActualAmount Money, ControlId bigint, VendorId smallint
					, SourceSystemId smallint, AccountHierarchyId int, NominalCode int
					, FinancialLineTypeId smallint, AccountRef varchar(20), TransactionNo int
					, TaxCode char(3), AccountCategoryId smallint, DetailNotes varchar(255)
					, TransactionTypeId smallint
					, ProjectCode VARCHAR(31) , IsDiscretionary BIT
					, CurrentRow bit, CurrentRowSwitchId bigint
					, DeletedRow bit);

	DECLARE @LinkRst table( MergeAction Varchar(20), [FinancialFactId] bigint, [DepartmentId] smallint, [PostingDateId] int, [TransactionDateId] int
					,[AccountHierarchyId] int, NominalCode INT, [FinancialLineTypeId] smallint, [AccountCategoryId] smallint, [TransactionNo] int);

	DECLARE @MINPeriod Bigint, @MAXPeriod Bigint;

	SELECT @MINPeriod = MIN( CalendarId), @MAXPeriod = MAX(CalendarId) FROM [Staging].[GL_LLP] s
											INNER JOIN Core.Calendar c
												on CONVERT(DATETIME, SUBSTRING(s.[DATE], 25,4) + ' ' + SUBSTRING(s.[DATE], 5,3) + ' ' + SUBSTRING(s.[DATE], 9, 2), 103) = c.CalendarDate;
	UPDATE [Staging].[GL_LLP]
		SET IncludeInFact = 0
		WHERE INV_REF = 'REVERSE';

	UPDATE [Staging].[GL_LLP]
		SET TransactionNo = CAST( ROUND(Tran_Number,0) as int)
		, NominalCode = CAST( Nominal_Code as int)
		WHERE ISNUMERIC( ROUND(Tran_Number,0)) = 1

	MERGE INTO Fact.FinancialsFact Tar
					USING ( SELECT 
								d.DepartmentId, 
								IsNull(ct.CalendarId, 20140101) as PostingDateId, 
								IsNull( ct.CalendarId, 20140101) as TransactionDateId,
								s.SourceSystemId, 
								flt.[FinancialLineTypeId],
								gl.NominalCode,
								ROUND(gl.Amount,2) as ActualAmount, 
								SubString( gl.[Account_Ref], 1, 20) as AccountRef, 
								ROUND(gl.Tran_Number,0) as TransactionNo, 
								SubString( gl.Tax_Code, 1, 3) as TaxCode, 
								SubString( gl.Nominal_Code + ' - : ' + ISNULL(gl.Inv_Ref,'') + ' : ' + ISNULL(gl.Details,''), 1, 255) as DetailNotes, 
								IsNull( at.TransactionTypeId, -1) as TransactionTypeId, @ControlId as ControlId
								,NULLIF(gld.Project_ID,'0') AS ProjectCode
								,(CASE WHEN gld.TRAN_NUMBER IS NOT NULL THEN 1 ELSE 0 END) AS IsDiscretionary
							FROM [Staging].[GL_LLP] gl
							INNER JOIN Core.Departments d
								ON (ROUND(gl.Dept_Number,0) = d.DepartmentNumber)
							INNER JOIN Core.Calendar ct
								ON (ct.CalendarDate = CONVERT(DATETIME,SUBSTRING(gl.[DATE], 25,4) + ' ' + SUBSTRING(gl.[DATE], 5,3) + ' ' + SUBSTRING(gl.[DATE], 9, 2), 103))
							LEFT OUTER JOIN Finance.TransactionTypes at
								ON (gl.[TYPE] = at.TransactionTypeBK)
							LEFT OUTER JOIN Staging.GL_LLP_Discretionary gld
								ON gld.[TRAN_NUMBER] = gl.[TRAN_NUMBER] AND gld.[Nominal_Code] = gl.[NOMINAL_CODE] AND gld.[Amount] = gl.[AMOUNT] AND 
								gld.[DEPT_NUMBER] = gl.[DEPT_NUMBER]
							CROSS JOIN Audit.SourceSystems s
							CROSS JOIN Finance.FinancialLineTypes flt
							WHERE s.SourceSystemCode = 'SAGE'
							AND flt.FinancialLineCode = 'A'
						) as Src
					ON ( --Tar.[AccountHierarchyId] = Src.[AccountHierarchyId]
						tar.[NominalCode] = src.[NominalCode]
						AND Tar.[TransactionNo] = Src.[TransactionNo]
						AND Tar.[ActualAmount] = Src.[ActualAmount]
						AND Tar.[TransactionDateId] = Src.[TransactionDateId]
						AND tar.[FinancialLineTypeId] = Src.[FinancialLineTypeId]
						AND Tar.[CurrentRow] = 1
						AND Tar.[DeletedRow] = 0)
					WHEN NOT MATCHED BY TARGET
						THEN INSERT (DepartmentId, PostingDateId, TransactionDateId, ControlId
									, SourceSystemId, FinancialLineTypeId, NominalCode
									, ActualAmount, AccountRef, TransactionNo, TaxCode, DetailNotes, TransactionTypeId, ProjectCode, IsDiscretionary)
								VALUES (Src.DepartmentId, Src.PostingDateId, Src.TransactionDateId,
									Src.ControlId, Src.SourceSystemId,
									Src.FinancialLineTypeId, Src.NominalCode,
									Src.ActualAmount, Src.AccountRef, Src.TransactionNo, Src.TaxCode,
									Src.DetailNotes, Src.TransactionTypeId, Src.ProjectCode, Src.IsDiscretionary)
					WHEN NOT MATCHED BY SOURCE AND Tar.TransactionDateId BETWEEN @MINPeriod AND @MAXPeriod AND Tar.CurrentRow=1 AND Tar.FinancialLineTypeId = 1
						THEN UPDATE SET Tar.DeletedRow = 1
					WHEN MATCHED AND (Tar.DepartmentId <> Src.DepartmentId
										--OR Tar.ActualAmount <> Src.ActualAmount
										OR Tar.FinancialLineTypeId <> Src.FinancialLineTypeId
										OR Tar.AccountRef <> Src.AccountRef
										OR Tar.TaxCode <> Src.TaxCode
										OR Tar.NominalCode <> Src.NominalCode
										OR Tar.DetailNotes <> Src.DetailNotes
										OR Tar.TransactiontypeId <> Src.TransactionTypeId
										OR ISNULL(Tar.ProjectCode, 'ABCDEFG') <> ISNULL(Src.ProjectCode, 'ABCDEFG')
										OR ISNULL(Tar.IsDiscretionary, -1) <> ISNULL(Src.IsDiscretionary, -1)
									)
						THEN UPDATE SET CurrentRow = 0
									, CountOf = 0
					OUTPUT $action as MergeAction, INSERTED.FinancialFactId, IsNull( Src.DepartmentId, INSERTED.DepartmentId)
									, IsNull( Src.PostingDateId, INSERTED.PostingDateId), IsNull( Src.TransactionDateId, INSERTED.TransactionDateId)
									, IsNull( Src.ActualAmount, INSERTED.ActualAmount), IsNull( Src.ControlId, INSERTED.ControlId)
									, IsNull( Src.SourceSystemId, INSERTED.SourceSystemId), IsNull( Src.NominalCode, INSERTED.NominalCode)
									, IsNull( Src.FinancialLineTypeId, INSERTED.FinancialLineTypeId), IsNull( Src.AccountRef, INSERTED.AccountRef), IsNull( Src.TransactionNo, INSERTED.TransactionNo)
									, IsNull( Src.TaxCode, INSERTED.TaxCode), IsNull( Src.DetailNotes, INSERTED.DetailNotes)
									, IsNull( Src.TransactionTypeId, INSERTED.TransactionTypeId) 
									, IsNull( Src.ProjectCode, INSERTED.ProjectCode), IsNull( Src.IsDiscretionary, INSERTED.IsDiscretionary)
									,INSERTED.DeletedRow, INSERTED.CurrentRow
									INTO @UpdRst(MergeAction, FinancialFactId, DepartmentId, PostingDateId, TransactionDateId
												, ActualAmount, ControlId, SourceSystemId, NominalCode
												, FinancialLineTypeId, AccountRef, TransactionNo, TaxCode
												, DetailNotes, TransactionTypeId, ProjectCode, IsDiscretionary, DeletedRow, CurrentRow)
					;

	SET @InsertRowCount = @@ROWCOUNT;
	SELECT * FROM @UpdRst;

	MERGE INTO Fact.FinancialsFact Tar
	USING (SELECT MergeAction, FinancialFactId, DepartmentId, PostingDateId, TransactionDateId, ControlId
				, SourceSystemId, FinancialLineTypeId, NominalCode
				, ActualAmount, AccountRef, TransactionNo, TaxCode, DetailNotes, TransactionTypeId
				, ProjectCode, IsDiscretionary
				, CurrentRow, DeletedRow
				FROM @UpdRst
				WHERE MergeAction = 'UPDATE'
				AND DeletedRow = 0
				) Src
		ON (--Tar.[AccountHierarchyId] = Src.[AccountHierarchyId]
			tar.[NominalCode] = src.[NominalCode]
			AND Tar.[TransactionNo] = Src.[TransactionNo]
			AND Tar.[ActualAmount] = Src.[ActualAmount]
			AND Tar.[TransactionDateId] = Src.[TransactionDateId]
			AND Tar.[CurrentRow] = 1
			)
		WHEN NOT MATCHED
			THEN INSERT (DepartmentId, PostingDateId, TransactionDateId, ControlId
									, SourceSystemId, FinancialLineTypeId, NominalCode
									, ActualAmount, AccountRef, TransactionNo, TaxCode, DetailNotes
									, TransactionTypeId, ProjectCode, IsDiscretionary
						)
					VALUES (Src.DepartmentId, Src.PostingDateId, Src.TransactionDateId, Src.ControlId
								,  Src.SourceSystemId, Src.FinancialLineTypeId, Src.NominalCode
								, Src.ActualAmount, Src.AccountRef, Src.TransactionNo, Src.TaxCode,  Src.DetailNotes, Src.TransactionTypeId
								, Src.ProjectCode, Src.IsDiscretionary
							)
		OUTPUT $ACTION as MergeAction, INSERTED.FinancialFactId, Src.TransactionNo
			INTO @LinkRst(MergeAction, FinancialFactId, TransactionNo)
			;

	SET @InsertRowCount = @InsertRowCount + @@ROWCOUNT;

	SELECT *
	FROM @LinkRst;
	/*
		UPDATE f
				SET f.CurrentRowSwitchId = r.FinancialFactId
			FROM @LinkRst r
				INNER JOIN Fact.FinancialsFact f 
				ON r.NominalCode = f.AccountHierarchyId
				AND r.TransactionNo = f.TransactionNo
			WHERE f.CurrentRow = 0
			AND r.MergeAction = 'INSERT'
				;

	SET @UpdateRowCount = @@ROWCOUNT;
	*/
	SELECT @ProcessRowCount AS ProcessRowCount
		, @InsertRowCount AS InsertRowCount
		, @UpdateRowCount AS UpdateRowCount
		, @DeleteRowCount AS DeleteRowCount
		;

	COMMIT;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
		ROLLBACK;
		 
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
--	EXEC [Fact].[usp_MergeActuals] @ControlId =@CID
--	SELECT @CID

--	EXEC [Fact].[usp_MergeActuals] @ControlId = -1 --20000401000000

--END
