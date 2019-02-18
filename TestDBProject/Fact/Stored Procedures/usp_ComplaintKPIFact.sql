CREATE PROCEDURE [Fact].[usp_ComplaintKPIFact]
		@ControlId BIGINT=-1
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Fact].[usp_ComplaintKPIFact]
-- 
-- Note:			
-- 
-- Author:			Faheem
-- Date:			25/11/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 09-Sep-2016		RC - now to called by Boomi process so remove RecordNotInSource logic
--                  and only look at last 7 days because Boomi should run daily.
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
	DECLARE	@strProcedureName		VARCHAR(100)	= 'Fact.usp_ComplaintKPIFact';
	DECLARE @NewData TABLE ( KPIId SMALLINT,MeasureDateId INT,MeasureValue DECIMAL(19,5));
	--DECLARE @RecordNotInSource TABLE ( KPIId SMALLINT,MeasureDateId INT);

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END

	SET DATEFORMAT dmy;

	SELECT @SourceSystemId = ISNULL(ss.SourceSystemId,-1)
	FROM [Audit].[SourceSystems] ss
	WHERE ss.SourceSystemCode = 'WFMI';
	

    With DailyComplaints AS 
    (
        -- Create default zero row for days when there is no activity - IanMc 5.7.16
        select      'ComplaintCommunications'               ComplaintType, 
                    convert ( date, x.CalendarDate, 103 )   ComplaintDate,
                    sum ( x.IsComplaint )                   Complaints
        from
        (
            select      c.CalendarDate,
                        case
                            when crc.RootCause = 'Communications' -- id = 1
                            then 1
                            else 0
                        end IsComplaint
            from        [Core].[Calendar]                   c
            --
            left join   [Compliance].[ComplaintsRegister]   cr      
            on          cr.ComplaintDate                    = c.CalendarDate                              
            and         cr.ComplaintClosed                  = 0
            --
            left join   [Compliance].[ComplaintRootCauses]  crc     
            on          crc.RootCauseId                     = cr.ComplaintRootCauseId             
            and         crc.RootCause                       = 'Communications' 
            --
            where       c.CalendarDate                      
            between     dateadd ( day, -7, getdate() ) and getdate()    
         ) x
        group by convert ( date, x.CalendarDate, 103 ) 
        -----
        union
        -----
        select      'ComplaintGeneral'                      ComplaintType, 
                    convert ( date, x.CalendarDate, 103 )   ComplaintDate,
                    sum ( x.IsComplaint )                   Complaints
        from
        (
            select      c.CalendarDate,
                        case
                            when crc.RootCause = 'General' -- id = 2
                            then 1
                            else 0
                        end IsComplaint
            from        [Core].[Calendar]                   c
            --
            left join   [Compliance].[ComplaintsRegister]   cr      
            on          cr.ComplaintDate                    = c.CalendarDate                              
            and         cr.ComplaintClosed                  = 0
            --
            left join   [Compliance].[ComplaintRootCauses]  crc     
            on          crc.RootCauseId                     = cr.ComplaintRootCauseId             
            and         crc.RootCause                       = 'General' 
            --
            where       c.CalendarDate                      
            between     dateadd ( day, -7, getdate() ) and getdate()    
         ) x
        group by convert ( date, x.CalendarDate, 103 ) 
        -----
        union
        -----
        select      'ComplaintTraining'                     ComplaintType, 
                    convert ( date, x.CalendarDate, 103 )   ComplaintDate,
                    sum ( x.IsComplaint )                   Complaints
        from
        (
            select      c.CalendarDate,
                        case
                            when crc.RootCause = 'Training' -- id = 3
                            then 1
                            else 0
                        end IsComplaint
            from        [Core].[Calendar]                   c
            --
            left join   [Compliance].[ComplaintsRegister]   cr      
            on          cr.ComplaintDate                    = c.CalendarDate                              
            and         cr.ComplaintClosed                  = 0
            --
            left join   [Compliance].[ComplaintRootCauses]  crc     
            on          crc.RootCauseId                     = cr.ComplaintRootCauseId             
            and         crc.RootCause                       = 'Training' 
            --
            where       c.CalendarDate                      
            between     dateadd ( day, -7, getdate() ) and getdate()    
         ) x
         group by convert ( date, x.CalendarDate, 103 ) 
    )

					-- Get all then new KPI's data for EBI
					Insert into @NewData 
					SELECT 
						 MK.[KPIId]
						,c.CalendarId as MeasureDateId
						, Comp.Complaints as MeasureValue
					FROM DailyComplaints Comp 
					INNER JOIN Core.Calendar c
					ON Comp.ComplaintDate = c.CalendarDate
					INNER JOIN [KPI].[MeasuredKPIs] MK
					ON MK.KPIDBBK=Comp.ComplaintType
					;

					/*
					-- Get those records not coming anymore in source but exist in Fact
					Insert into @RecordNotInSource
					SELECT F.KPIId,F.MeasureDateId
					FROM [Fact].[KPIFact] F
					INNER JOIN [KPI].[MeasuredKPIs] MK 
					ON F.KPIId= MK.[KPIId]
					WHERE F.MeasureDateId NOT IN (SELECT DISTINCT MeasureDateId FROM @NewData WHERE KPIId = F.KPIId AND MeasureDateId = F.MeasureDateId)
					AND MK.KPIDBBK IN 
					(
					'ComplaintCommunications'
					,'ComplaintGeneral'
					,'ComplaintTraining'
					)
					GROUP BY F.KPIId,F.MeasureDateId;
					*/

		

	-- Insert new records in Fact
	MERGE INTO [Fact].[KPIFact] Tar
	USING (
			SELECT 
				  MeasureDateId
				, KPIId
				, MeasureValue
				, @ControlId as ControlId
				, GETDATE() AS LastUpdatedDatetime

				FROM @NewData 
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
				);
	
	/*
	
	-- OLD RECORDS in Fact setting Measure value =0							
	MERGE INTO [Fact].[KPIFact] Tar
	USING ( 
					
				SELECT  
					 MeasureDateId
					,KPIId
					,0 as MeasureValue
					,@ControlId as ControlId 
					, GETDATE() AS LastUpdatedDatetime
					FROM @RecordNotInSource
			) Src
	ON (Tar.MeasureDateId = Src.MeasureDateId
	AND Tar.KPIId = Src.KPIId
	AND Tar.MeasureValue = Src.MeasureValue
	)
	WHEN NOT MATCHED 
	THEN INSERT ([MeasureDateId], [KPIId], [MeasureValue], [ControlId], [SourceSystemId],[LastUpdatedDatetime]
		        )
			VALUES (Src.[MeasureDateId], Src.[KPIId], Src.[MeasureValue], Src.[ControlId],@SourceSystemId,Src.LastUpdatedDatetime
			);

    */
			
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
