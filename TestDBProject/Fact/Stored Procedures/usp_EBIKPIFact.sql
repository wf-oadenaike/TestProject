CREATE PROCEDURE [Fact].[usp_EBIKPIFact]
		@ControlId BIGINT=-1
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Fact].[usp_EBIKPIFact]
-- 
-- Note:			
-- 
-- Author:			Faheem
-- Date:			13/11/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 11-Aug-2016      R Carter correct Mandate breach to correct type 2
--                           add check on unresolved status for all KPI's to trigger
-- 11-Aug-2016		SM - Added the bit for EBIStatutoryDataPrivacy which was missing
-- 09-Sep-2016		RC - now to called by Boomi process so remove RecordNotInSource logic
--                  and only look at last 7 days because Boomi should run daily.
-- 29-Sep-2016      RC - use new flags ReportableYesNo and RegulatoryRelatedYesNo
--                  and correct logic so doesnt care if resolved or has closure date
-- 12-Oct-2016      RC - use EBIStartDate rather than DateIdentified in breach logic
-- 12-Feb-2018		BK - Added "ActiveInvestmentBreachYesNo	= 1" to capture active investment breaches
-- 07-Feb-2019		BK - Added "ActiveInvestmentBreachYesNo	= 1" to capture active mandate breaches
-------------------------------------------------------------------------------------- 

BEGIN TRY

	SET NOCOUNT ON;
	SET DATEFORMAT dmy;

	BEGIN TRANSACTION

	DECLARE @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		, @SourceSystemId int = -1
		;
	DECLARE	@strProcedureName		VARCHAR(100)	= '[Fact].[usp_EBIKPIFact]';
	DECLARE @NewData table ( KPIId SMALLINT,MeasureDateId INT,MeasureValue DECIMAL(19,5));
	--DECLARE @RecordNotInSource table ( KPIId SMALLINT,MeasureDateId INT);
	
	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END

	SET DateFormat dmy;

	SELECT @SourceSystemId = ISNULL(ss.SourceSystemId,-1)
	FROM [Audit].[SourceSystems] ss
	WHERE ss.SourceSystemCode = 'WFMI';

    With DailyEBIs AS 
    (
        -- Modified this DailyEBIs query to return zero for days when no EBIs present (IanMc 4.7.16)
        select      'EBIPolicy'         EBIType,
                    x.CalendarDate      EBIStartDate,
                    sum ( x.IsEbi )     EBICounts
        from
        (
            select      c.CalendarDate,                     
                        case    
                            when er.EBITypeCode = 'Breach'
                            then 1 
                            else 0 
                        end IsEbi
            from        Core.Calendar                       c
            left join   Compliance.EBIRegister              er
            on          c.CalendarDate                      =   er.EBIStartDate
            and         er.EBITypeCode                      =   'Breach'
            and         er.EBIBreachTypeId                  =   1
            --and         er.EBIResolvedYesNo                 =   0
            --and         er.EBIClosureDate                   is  null
			and         er.Status                           IN ('Unresolved','Resolved')
            where       c.CalendarDate                      between dateadd ( day, -7, getdate() ) and getdate()
        ) x
        group by    x.CalendarDate 
        -----
        union
        -----
        select      'EBIFCARegulations' EBIType,
                    x.CalendarDate      EBIStartDate,
                    sum ( x.IsEbi )     EBICounts
        from
        (
            select      c.CalendarDate,                     
                        case    
                            when er.EBITypeCode = 'Breach'
                            then 1 
                            else 0 
                        end IsEbi
            from        Core.Calendar                       c
            left join   Compliance.EBIRegister              er
            on          c.CalendarDate                      =   er.EBIStartDate
            --and         er.EBIClosureDate                   is  null
            --and         er.EBIResolvedYesNo                 =   0
            and         er.EBITypeCode                      =   'Breach'
            and         er.EBIBreachTypeId                  =   4
			and         er.Status                           IN ('Unresolved','Resolved')
			and			er.ReportableYesNo 					=   1
            where       c.CalendarDate                      between dateadd ( day, -7, getdate() ) and getdate()
        ) x
        group by    x.CalendarDate 
        -----
        union
        -----
        select      'EBIMandate'        EBIType,
                    x.CalendarDate      EBIStartDate,
                    sum ( x.IsEbi )     EBICounts
        from
        (
            select      c.CalendarDate,                     
                        case    
                            when er.EBITypeCode = 'Breach'
                            then 1 
                            else 0 
                        end IsEbi
            from        Core.Calendar                       c
            left join   Compliance.EBIRegister              er
            on          c.CalendarDate                      =   er.EBIStartDate
            --and         er.EBIClosureDate                   is  null
            --and         er.EBIResolvedYesNo                 =   0
            and         er.EBITypeCode                      =   'Breach'
            and         er.EBIBreachTypeId                  =   2
			and         ER.InvestmentRelatedYesNo           =   1
			and			ER.ActiveInvestmentBreachYesNo		=	1
			and         er.Status                           IN ('Unresolved','Resolved')
            where       c.CalendarDate                      between dateadd ( day, -7, getdate() ) and getdate()
        ) x
        group by    x.CalendarDate 
        -----
        union
        -----
        select      'EBIRegulatoryInvestment'       EBIType,
                    x.CalendarDate                  EBIStartDate,
                    sum ( x.IsEbi )                 EBICounts
        from
        (
            select      c.CalendarDate,                     
                        case    
                            when er.EBITypeCode = 'Breach'
                            then 1 
                            else 0 
                        end IsEbi
            from        Core.Calendar                       c
            left join   Compliance.EBIRegister              er
            on          c.CalendarDate                      =   er.EBIStartDate
            --and         er.EBIClosureDate                   is  null
            --and         er.EBIResolvedYesNo                 =   0
            and         er.EBITypeCode                      =   'Breach'
            and         ER.InvestmentRelatedYesNo           =   1
			and			ER.ActiveInvestmentBreachYesNo		=	1
            and         ER.RegulatoryRelatedYesNo           =   1
			and         er.Status                           IN ('Unresolved','Resolved')
            where       c.CalendarDate                      between dateadd ( day, -7, getdate() ) and getdate()
        ) x
        group by    x.CalendarDate 
        -----
        union
        -----
        select      'EBIDisputPendLitigation'       EBIType,
                    x.CalendarDate                  EBIStartDate,
                    sum ( x.IsEbi )                 EBICounts
        from
        (
            select      c.CalendarDate,                     
                        case    
                            when er.DisputedPendingLitigationYesNo = 1
                            then 1 
                            else 0 
                        end IsEbi
            from        Core.Calendar                       c
            left join   Compliance.EBIRegister              er
            on          c.CalendarDate                      =   er.EBIStartDate
            --and         er.EBIClosureDate                   is  null
            --and         er.EBIResolvedYesNo                 =   0
            and         er.DisputedPendingLitigationYesNo   =   1
			and         er.Status                           IN ('Unresolved','Resolved')
            where       c.CalendarDate                      between dateadd ( day, -7, getdate() ) and getdate()
        ) x
        group by    x.CalendarDate 
        -----
        union
        -----
        select      'EBIStatutoryDataPrivacy'       EBIType,
                    x.CalendarDate                  EBIStartDate,
                    sum ( x.IsEbi )                 EBICounts
        from
        (
            select      c.CalendarDate,
                        case    
                            when er.DataProtectionRelatedYesNo = 1
                            then 1 
                            else 0 
                        end IsEbi
            from        Core.Calendar                       c
            left join   Compliance.EBIRegister              er
            on          c.CalendarDate                      =   er.EBIStartDate
            --and         er.EBIClosureDate                   is  null
            --and         er.EBIResolvedYesNo                 =   0				-- this is set prior to going to compliance for review
			and			er.Status							IN ('Unresolved','Resolved')	-- this status comes back from compliance after they have reviewed it
            and         er.DataProtectionRelatedYesNo		=   1				-- for data privacy
			and			er.EBIBreachTypeId					=	3				-- Statutory breach
            and         er.EBITypeCode                      =   'Breach'
            where       c.CalendarDate                      between dateadd ( day, -7, getdate() ) and getdate()
        ) x
        group by    x.CalendarDate
        -----
        union
        -----
        select      'EBIIncident'                   EBIType,
                    x.CalendarDate                  EBIStartDate,
                    sum ( x.IsEbi )                 EBICounts
        from
        (
            select      c.CalendarDate,                     
                        case    
                            when er.EBITypeCode = 'Incident'
                            then 1 
                            else 0 
                        end IsEbi
            from        Core.Calendar                       c
            left join   Compliance.EBIRegister              er
            on          c.CalendarDate                      =   er.EBIStartDate
            --and         er.EBIClosureDate                   is  null
            --and         er.EBIResolvedYesNo                 =   0
			and         er.Status                           IN ('Unresolved','Resolved')
            where       c.CalendarDate                      between dateadd ( day, -7, getdate() ) and getdate()
        ) x
        group by    x.CalendarDate 
    )

					-- Get all then new KPI's data for EBI
					Insert into @NewData
					Select 
					 MK.KPIId
					,c.CalendarId AS MeasureDateId
					,EBI.EBICounts AS MeasureValue
					FROM DailyEBIs EBI 
					INNER JOIN Core.Calendar c 
					ON EBI.EBIStartDate = c.CalendarDate 
					INNER JOIN [KPI].[MeasuredKPIs] MK 
					ON MK.KPIDBBK=EBI.EBIType;
						
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
						'EBIDisputPendLitigation'
						,'EBIFCARegulations'
						,'EBIIncident'
						,'EBIMandate'
						,'EBIPolicy'
						,'EBIRegulatoryInvestment'
						,'EBIStatutoryDataPrivacy'
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
	AND Tar.LastUpdatedDatetime = (SELECT ISNULL(MAX(kpif.LastUpdatedDatetime),Src.LastUpdatedDatetime) FROM [Fact].[KPIFact] kpif  WHERE kpif.KPIId = Src.KPIId AND kpif.MeasureDateId = Src.MeasureDateId)
	)
	WHEN NOT MATCHED 
		THEN INSERT ([MeasureDateId], [KPIId], [MeasureValue], [ControlId], [SourceSystemId],[LastUpdatedDatetime]
		            )
				VALUES (Src.[MeasureDateId], Src.[KPIId], Src.[MeasureValue], Src.[ControlId], @SourceSystemId,Src.LastUpdatedDatetime
				)
	;

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
