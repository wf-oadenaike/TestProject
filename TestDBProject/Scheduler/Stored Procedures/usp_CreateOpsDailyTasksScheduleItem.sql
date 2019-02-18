CREATE PROCEDURE [Scheduler].[usp_CreateOpsDailyTasksScheduleItem]

/*

	D.Bacchus	09-05-2017	DAP-1030 added ISACTIVE to where clause
	
*/

AS
BEGIN TRY

	SET NOCOUNT ON

	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_CreateOpsDailyTasksScheduleItem',
			@RetrievalDate DATE,
			@FlowId UNIQUEIDENTIFIER

	SET @RetrievalDate = GETDATE()

	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Investment Ops Daily Tasks'
					);

	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING (
			SELECT @FlowId as FlowId,
					case [Frequency]
						when 'Daily' then
							CASE DATENAME(dw,DATEADD(Day,1,@RetrievalDate))
								WHEN 'Saturday' THEN DATEADD(Day,2,DATEADD(Day,1,@RetrievalDate))
								WHEN 'Sunday' THEN DATEADD(Day,1,DATEADD(Day,1,@RetrievalDate))
								ELSE DATEADD(Day,1,@RetrievalDate)
							END
						when 'Weekly' then
							DATEADD(d, (7+2-DATEPART(weekday, @RetrievalDate)) % 7, @RetrievalDate)
						when 'Monthly' then
							DATEADD(mm, DATEDIFF(m,0,@RetrievalDate)+1,0)
					end as LaunchDate,
					[InvestmentOpsDailyTasksRegisterId] as LaunchRef,
					1 as IsActive,
					GETDATE() AS CreatedDate
			FROM [Operation].[InvestmentOpsDailyTasksRegister]
			WHERE ISACTIVE = 1
		 ) Src
		ON ( Tar.FlowId = Src.FlowId 
		AND Tar.LaunchRef = Src.LaunchRef
		AND Tar.LaunchDate = Src.LaunchDate)
	WHEN NOT MATCHED THEN
	INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
	VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
	;

	MERGE INTO [Scheduler].[WorkflowParameters] WFP
	USING (
			SELECT LaunchList.[WorkflowLaunchId]
				, 'Number filled by scheduler' as KeyName
				,  CAST(LaunchRef as Varchar) AS Value
				, 'ContentNumber' as ContentType
			FROM [Scheduler].[WorkflowLaunchList] LaunchList
			WHERE LaunchList.FlowId = @FlowId
			AND LaunchList.LaunchDate >= @RetrievalDate
				) Src
			ON wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
			AND wfp.[Value] = Src.[Value]
	WHEN NOT MATCHED THEN
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
