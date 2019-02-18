--Drop procedure  [Fact].[usp_MergeKPIFact]
CREATE PROCEDURE [BrandWatch].[usp_MergeKPIFact_BRAN]
		@KPIDBBK varchar(50),
		@ControlId BIGINT=-1,
		@SourceSystemCode VARCHAR(50) = '-1'
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Fact].[usp_MergeKPIFact]
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

BEGIN TRY

		SET NOCOUNT ON;
	SET DATEFORMAT dmy;

	BEGIN TRANSACTION

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		, @SourceSystemId int = -1
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[BrandWatch].[usp_MergeKPIFact]';
	DECLARE @FACT_KPIID int;
    DECLARE @KPIBK int; 
		Select @FACT_KPIID=KPIID, @KPIBK=KPIBK from KPI.MeasuredKPIs where KPIDBBK=@KPIDBBK

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END

	SET DateFormat dmy;

	SELECT @SourceSystemId = ISNULL(ss.SourceSystemId,-1)
	FROM [Audit].[SourceSystems] ss
	WHERE ss.SourceSystemCode = 'BRAN';

	MERGE INTO [Fact].[KPIFact] Tar
	USING ( SELECT d.KPIDataDate as [MeasureDateId], @FACT_KPIID as KPIID , d.[ActualValue]  as [MeasureValue]
					, @ControlId as ControlId
					--,COALESCE(CONVERT(DATETIME, CONVERT(DATETIME,d.UpdatedAt),121), GETDATE()) AS LastUpdatedDatetime
					,GETDATE() AS LastUpdatedDatetime
			FROM [Staging.KPI].KPIData_BRANDWATCH d
			--INNER JOIN Core.Calendar c
			--	ON CONVERT( Date, d.KPIDate,103) = c.CalendarDate
			INNER JOIN [KPI].[MeasuredKPIs] k
				ON d.[KPIIDBK] = k.[KPIBK]
			WHERE D.KPIIDBK=@KPIBK  
			AND IsDate( d.KPIDataDate) = 1
			AND COALESCE(d.CreatedAt, GETDATE()) = (SELECT MAX(CreatedAt) 
							   FROM  [Staging.KPI].KPIData_BRANDWATCH d1
							   WHERE d1.KPIIDBK = d.KPIIDBK
							   AND d1.KPIDataDate = d.KPIDataDate
							   )	
			) Src
	ON (Tar.MeasureDateId = Src.MeasureDateId
	AND Tar.KPIId = Src.KPIId
	AND Tar.LastUpdatedDatetime = Src.LastUpdatedDatetime)
	WHEN NOT MATCHED
		THEN INSERT ([MeasureDateId], [KPIId], [MeasureValue], [ControlId], [SourceSystemId],[LastUpdatedDatetime])
				VALUES (Src.[MeasureDateId], Src.[KPIId], Src.[MeasureValue], Src.[ControlId], @SourceSystemId,LastUpdatedDatetime)
    WHEN MATCHED AND Tar.MeasureValue <> Src.MeasureValue
		THEN UPDATE SET 
					 Tar.MeasureValue = Src.MeasureValue
					,Tar.ControlId = Src.[ControlId]
		;

	SET @InsertRowCount = @@ROWCOUNT;

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
