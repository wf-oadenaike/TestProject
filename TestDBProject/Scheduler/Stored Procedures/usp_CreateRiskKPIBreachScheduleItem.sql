
CREATE PROCEDURE [Scheduler].[usp_CreateRiskKPIBreachScheduleItem]
AS
-------------------------------------------------------------------------------------- 
-- Name: [Scheduler].[usp_CreateRiskKPIBreachScheduleItem]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 19/03/2018 JIRA: DAP-1817 amended to handle KPI's where we're only concerned with latest value, i.e. AggrFunction = 'LAT'
-- B.Katsadoros: 04/02/2019 Added new AggrFunction "ALL"
-------------------------------------------------------------------------------------- 

BEGIN TRY

	SET NOCOUNT ON
	
	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_CreateRiskKPIBreachScheduleItem',
			@RetrievalDate DATE,
			@FlowId UNIQUEIDENTIFIER,
			@LaunchDate DATE,
			@LaunchRef VARCHAR(100);
		
	SET @RetrievalDate = GETDATE()
	
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Risk Threshold / KPI Breach Alert Process'
					);
					
-- Table to store KPI filtered/aggregated KPI data
	DECLARE @KPIData AS TABLE (KPIID int, 
	                           KPIValue decimal(19,5),
							   MEASUREDATEID int)

	;WITH CTE_MasterFactList (KPIId, KPIDate, KPILastUpdated)
	AS
	(SELECT	KPIId, MeasureDateId, MAX(LastUpdatedDatetime)
	FROM	[Fact].[KPIFact]
	WHERE	LastUpdatedDatetime <= @RetrievalDate
	GROUP	BY KPIId, MeasureDateId
	)
	INSERT	INTO @KPIData ( KPIID, 
	                       KPIValue,
						   MEASUREDATEID) 
	SELECT	kf.KPIID, 
			ISNULL(
			(CASE	WHEN mk.AggrFunction in ('SUM','ALL') THEN SUM(kf.MeasureValue) 
					WHEN mk.AggrFunction = 'AVG' THEN AVG(kf.MeasureValue) 
					WHEN mk.AggrFunction = 'LAT' THEN MAX(kl.MeasureValue) 
			END),0) as KPIValue,
			MAX(cte.KPIDate ) as KPIDate
	FROM	[KPI].[MeasuredKPIs] mk
	INNER	JOIN [KPI].[RefreshFrequency] rf 
	ON		mk.RefreshFrequencyId = rf.RefreshFrequencyId
	INNER	JOIN [Fact].[KPIFact] kf
	ON		kf.KPIId = mk.KPIId
	LEFT	JOIN 
			(
			SELECT * 
			FROM	(
					SELECT	fac.KPIId, fac.MeasureDateId, fac.LastUpdatedDatetime, fac.MeasureValue, ROW_NUMBER() OVER (PARTITION BY fac.KPIId ORDER BY fac.MeasureDateId  desc, fac.LastUpdatedDatetime desc) AS ROWNUM
					FROM	[Fact].[KPIFact] fac
					INNER	JOIN [Core].[Calendar] cal
					ON		fac.MeasureDateId = cal.CalendarId
					INNER	JOIN [KPI].[MeasuredKPIs] mkpi
					ON		fac.KPIId = mkpi.KPIId
					LEFT	JOIN [KPI].[RefreshFrequency] rf 
					ON		mkpi.RefreshFrequencyId = rf.RefreshFrequencyId
					WHERE	LastUpdatedDatetime < DATEADD(d, 1, @RetrievalDate)
					AND		convert(date,cal.CalendarDate) >= convert(date,DATEADD(Day, -1 * rf.DaysRange, @RetrievalDate))
					and		mkpi.AggrFunction = 'LAT'
					) y
			WHERE	y.ROWNUM =1
			) kl
	ON		kl.KPIId = mk.KPIId
	INNER	JOIN CTE_MasterFactList cte 
	ON		cte.KPIId = kf.KPIId 
	AND		cte.KPIDate = kf.MeasureDateId 
	AND		cte.KPILastUpdated = kf.LastUpdatedDatetime
	LEFT	JOIN [Core].[Calendar] cal
	ON		kf.MeasureDateId = cal.CalendarId
	INNER	JOIN [KPI].[KPIRiskCategoryRelationship] rcr
	ON		mk.KPIId = rcr.KPIId
	WHERE	cal.CalendarDate > DATEADD(Day, -1 * rf.DaysRange, @RetrievalDate)
	AND		mk.IsActive = 1
	AND		mk.RedThresholdValue IS NOT NULL
	AND		mk.AmberThresholdValue IS NOT NULL 
	GROUP	BY
			kf.KPIID,
			mk.AggrFunction
	;

	-- Table to store breached KPIs
	-- Only include new breaches which were not previously reported in rolling window as red
	-- or were reported as amber and the new breach is red
	DECLARE	@KPIBreach AS TABLE (KPIID int, 
	                             KPIValue decimal(19,5),
							     RAGName varchar(10),
								 ThresholdValue decimal(19,5),
								 MEASUREDATEID int
								 );		
	INSERT	INTO @KPIBreach 
			(KPIID, 
			KPIValue,
			RAGName,
							 ThresholdValue,
							 MEASUREDATEID
							 )
	SELECT	mk.KPIID 
			, ISNULL(d.KPIValue, 0) AS KPIValue
			, CASE WHEN (mk.operator = '>' AND d.KPIValue >= mk.RedThresholdValue) OR (mk.operator = '<' AND d.KPIValue <= mk.RedThresholdValue) THEN 'Red' 
					WHEN (mk.operator = '>' AND d.KPIValue >= mk.AmberThresholdValue AND d.KPIValue < mk.RedThresholdValue) OR (mk.operator = '<' AND
					d.KPIValue <= mk.AmberThresholdValue AND d.KPIValue > mk.RedThresholdValue) THEN 'Amber'		 
					ELSE 'Green' 
			END as RAGName
			, CASE WHEN (mk.operator = '>' AND d.KPIValue >= mk.RedThresholdValue) OR (mk.operator = '<' AND d.KPIValue <= mk.RedThresholdValue) THEN mk.RedThresholdValue
					WHEN (mk.operator = '>' AND d.KPIValue >= mk.AmberThresholdValue AND d.KPIValue < mk.RedThresholdValue) 
					OR (mk.operator = '<' AND d.KPIValue <= mk.AmberThresholdValue AND d.KPIValue > mk.RedThresholdValue) THEN mk.AmberThresholdValue
					ELSE mk.GreenThresholdValue 
			END as ThresholdValue,d.MEASUREDATEID
	FROM	[KPI].[MeasuredKPIs] mk
	INNER	JOIN [KPI].[RefreshFrequency] rf 
	ON		mk.RefreshFrequencyId = rf.RefreshFrequencyId
	INNER	JOIN @KPIData d 
	ON		d.KPIID = mk.KPIId
	LEFT	JOIN
			(
			SELECT	* 
			FROM	[KPI].[KPIBreachRegister] k
			WHERE	BREACHDATE =
					(SELECT	MAX(BREACHDATE) 
					FROM	[KPI].[KPIBreachRegister] br
					JOIN	[KPI].[MeasuredKPIs] mk 
					ON		br.kpiid=mk.kpiid 
					INNER	JOIN [KPI].[RefreshFrequency] rf 
					ON		mk.RefreshFrequencyId = rf.RefreshFrequencyId
					WHERE	br.KPIID=k.kpiid
					AND		BREACHDATE>=DATEADD(Day, -1 * rf.DaysRange, @RetrievalDate)
					)
			) kbr
	ON		kbr.KPIId = d.KPIId

	WHERE
			CASE 
			WHEN CASE WHEN (mk.operator = '>' AND d.KPIValue >= mk.RedThresholdValue) OR (mk.operator = '<' AND d.KPIValue <= mk.RedThresholdValue) THEN 'Red' 
				WHEN (mk.operator = '>' AND d.KPIValue >= mk.AmberThresholdValue AND d.KPIValue < mk.RedThresholdValue) OR (mk.operator = '<' AND
				d.KPIValue <= mk.AmberThresholdValue AND d.KPIValue > mk.RedThresholdValue) THEN 'Amber'		 
				ELSE 'Green' 
			END ='Red' then 3 
			WHEN CASE WHEN (mk.operator = '>' AND d.KPIValue >= mk.RedThresholdValue) OR (mk.operator = '<' AND d.KPIValue <= mk.RedThresholdValue) THEN 'Red' 
				WHEN (mk.operator = '>' AND d.KPIValue >= mk.AmberThresholdValue AND d.KPIValue < mk.RedThresholdValue) OR (mk.operator = '<' AND
				d.KPIValue <= mk.AmberThresholdValue AND d.KPIValue > mk.RedThresholdValue) THEN 'Amber'		 
				ELSE 'Green' 
			END='Amber' then 2
			ELSE 1
			END >
			CASE WHEN kbr.RAGNAME='Red' THEN 3 
				WHEN kbr.RAGNAME='Amber' THEN 2
			ELSE 1
			END ;

	SET @LaunchDate = @RetrievalDate;


	INSERT	INTO [KPI].[KPIBreachRegister]
			(KPIID,KPIValue,ThresholdValue,RAGName,BreachDate)
	SELECT	b.KPIId
			, b.KPIValue
			, b.ThresholdValue
			, b.RAGName
			, @RetrievalDate
	FROM	@KPIBreach B 

	MERGE	INTO Scheduler.WorkflowLaunchList Tar
	USING	(
			SELECT @FlowId AS FlowId,
				   @LaunchDate AS LaunchDate,
					'KPIId:' + CAST(kb.KPIID AS VARCHAR) AS LaunchRef,
					1 AS IsActive,
					GETDATE() AS CreatedDate
			FROM	@KPIBreach kb
			) Src
	ON		(Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND Tar.LaunchDate = Src.LaunchDate)
	WHEN	NOT MATCHED THEN 
	INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
	VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
	;
							
	MERGE	INTO [Scheduler].[WorkflowParameters] WFP
	USING	( 
			SELECT	LaunchList.[WorkflowLaunchId]
					, 'Number filled by scheduler' as KeyName
					, CAST(kbr.KPIBreachId as Varchar) AS Value
					, 'ContentNumber' as ContentType
			FROM	[Scheduler].[WorkflowLaunchList] LaunchList
			INNER	JOIN @KPIBreach kb
			ON		kb.[KPIId] = CAST(SUBSTRING(LaunchList.LaunchRef,7,10) AS INT)
			INNER	JOIN [KPI].[KPIBreachRegister] kbr
			ON		kb.[KPIId] = kbr.[KPIId]
			AND		kb.[KPIValue] = kbr.[KPIValue]
			AND		kbr.BreachDate = @RetrievalDate
			WHERE	LaunchList.FlowId = @FlowId
			AND		LaunchList.LaunchDate = @LaunchDate
			) Src
	ON		wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
			AND wfp.[Value] = Src.[Value]
	WHEN	NOT MATCHED THEN 
	INSERT ([WorkflowLaunchId],[Key],[Value],[ContentType])
	VALUES (Src.[WorkflowLaunchId], Src.[KeyName], Src.[Value], Src.[ContentType] )
	;
	
			
END TRY
BEGIN CATCH
		DECLARE   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
				
		--IF @@TRANCOUNT > 0 ROLLBACK;

		SELECT	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
END CATCH
;


