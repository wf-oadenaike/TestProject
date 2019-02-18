CREATE PROCEDURE [Fact].[usp_ConflictKPIFact]
		@ControlId BIGINT=-1
AS
/*------------------------------------------------------------------------------------ 
 Name:			[Fact].[usp_ConflictKPIFact]
 Author:		Faheem
 Date:			23/10/2015
-------------------------------------------------------------------------------------- 
 Date			ChangedBy	Detail 
24/11/2015		FI			Record LastModified date in Fact		
09/09/2016		RC          Now to called by Boomi process so only look at last 7 days 
                            because Boomi should run daily.
------------------------------------------------------------------------------------*/ 

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
	Declare	@strProcedureName		VARCHAR(100)	= '[Fact].[usp_ConflictKPIFact]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END

	SET DateFormat dmy;

	SELECT @SourceSystemId = ISNULL(ss.SourceSystemId,-1)
	FROM [Audit].[SourceSystems] ss
	WHERE ss.SourceSystemCode = 'WFMI';

	WITH DailyConflicts AS 
	(
	    -- Populate KPIFact table with zeros for any dates that don't have any complaints - IanMc 6.7.16 (DAP-472)
		select      x.ConflictEntryDate,
					sum ( x.IsConflict ) Conflicts
		from
		(
			select      convert ( date, c.CalendarDate, 103 ) ConflictEntryDate,
						case
							when crp.ConflictId is not null 
							then 1
							else 0
						end IsConflict
			from        Core.Calendar                                   c
			left join   [Compliance].[ConflictsRegisterPotential]       crp  on  convert ( date, crp.ConflictEntryDate ) = convert ( date, c.CalendarDate )
			left join   [Compliance].[ConflictsRegisterIdentification]  cri  on  crp.ConflictId = cri.ConflictId
			where       c.CalendarDate 
			between     dateadd ( day, -7, getdate() ) and getdate()
		) x
		group by x.ConflictEntryDate
	)

	MERGE INTO [Fact].[KPIFact] Tar
	USING (
			SELECT 
				c.CalendarId as [MeasureDateId]
				, MK.[KPIId]
				, Conf.Conflicts as [MeasureValue]
				, @ControlId as ControlId
				, GETDATE() AS LastUpdatedDatetime
			FROM DailyConflicts Conf 
			INNER JOIN Core.Calendar c
			ON Conf.ConflictEntryDate = c.CalendarDate
			CROSS JOIN [KPI].[MeasuredKPIs] MK
			WHERE MK.KPIDBBK='ConflictInterest'
		 ) Src
	ON (Tar.MeasureDateId = Src.MeasureDateId
	AND Tar.KPIId = Src.KPIId
	AND Tar.MeasureValue = Src.MeasureValue
	AND Tar.LastUpdatedDatetime = (SELECT ISNULL(MAX(kpif.LastUpdatedDatetime),Src.LastUpdatedDatetime) FROM [Fact].[KPIFact] kpif WHERE kpif.KPIId = Src.KPIId AND kpif.MeasureDateId = Src.MeasureDateId)
	
	)
	WHEN NOT MATCHED
		THEN INSERT ([MeasureDateId], [KPIId], [MeasureValue], [ControlId], [SourceSystemId],[LastUpdatedDatetime]
		            )
				VALUES (Src.[MeasureDateId], Src.[KPIId], Src.[MeasureValue], Src.[ControlId], @SourceSystemId,Src.LastUpdatedDatetime
				)
		;

	SET @InsertRowCount = @@ROWCOUNT;

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
