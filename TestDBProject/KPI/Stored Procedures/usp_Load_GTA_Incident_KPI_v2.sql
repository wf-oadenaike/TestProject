CREATE PROCEDURE [KPI].[usp_Load_GTA_Incident_KPI_v2]
		
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


@KPIDBBK varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
Declare @FirstDate date;
DECLARE @FACT_KPIID int;
DECLARE @KPIBK int;
Select @FACT_KPIID=KPIID, @KPIBK=KPIBK from KPI.MeasuredKPIs where KPIDBBK=@KPIDBBK
Set @FirstDate='2014-04-01';
	


BEGIN TRY

	BEGIN TRANSACTION

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		, @SourceSystemId int = -1
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[KPI].[usp_Load_GTA_Incident_KPI_v2]';

	Declare  @ControlId Bigint
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	

	SET DateFormat dmy;

	SELECT @SourceSystemId = ISNULL(ss.SourceSystemId,-1)
	FROM [Audit].[SourceSystems] ss
	WHERE ss.SourceSystemCode = 'GTA';


	MERGE INTO [Fact].[KPIFact] Tar
	USING (
	Select distinct D.KPIDATADATE as[MeasureDateId] ,@FACT_KPIID as KPIID ,D.ActualValue as MeasureValue,@ControlId as ControlId
		, GETDATE() AS LastUpdatedDatetime
		  from   [Staging.KPI].[KPIData_GTA] D 
		where D.KPIIDBK=@KPIBK 
		and isnull(D.Notes,'')='Step2'
			and
			IsDate( d.KPIDataDate) = 1
			AND COALESCE(d.CreatedAt, GETDATE()) = (SELECT MAX(COALESCE(CreatedAt, GETDATE())) 
							   FROM [Staging.KPI].[KPIData_GTA] d1
							   WHERE d1.KPIIDBK = d.KPIIDBK
							   AND d1.KPIDataDate = d.KPIDataDate
							   and isnull(D1.Notes,'')='Step2'
							   )
			)src	
	
	
	
	
	--SELECT c.CalendarId as [MeasureDateId], k.[KPIId], d.[ActualValue] as [MeasureValue]
	--				, @ControlId as ControlId
	--				,COALESCE(CONVERT(DATETIME, CONVERT(DATETIME,d.UpdatedAt),121), GETDATE()) AS LastUpdatedDatetime
	--		FROM [Staging.KPI].[KPIData] d
	--		INNER JOIN Core.Calendar c
	--			ON CONVERT( Date, d.KPIDataDate,103) = c.CalendarDate
	--		INNER JOIN [KPI].[MeasuredKPIs] k
	--			ON d.[KPIIDBK] = k.[KPIBK]
	--		WHERE IsDate( d.KPIDataDate) = 1
	--		AND COALESCE(d.CreatedAt, GETDATE()) = (SELECT MAX(CreatedAt) 
	--						   FROM [Staging.KPI].[KPIData] d1
	--						   WHERE d1.KPIIDBK = d.KPIIDBK
	--						   AND d1.KPIDataDate = d.KPIDataDate
	--						   )		
	--		) Src
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
END
