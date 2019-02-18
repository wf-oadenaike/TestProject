CREATE PROCEDURE [Organisation].[usp_MergeCompanyKeyBusinessDates]

AS
-------------------------------------------------------------------------------------- 
-- Name:			Organisation.usp_MergeCompanyKeyBusinessDates
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			09/06/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

BEGIN TRY

	SET NOCOUNT ON
	
	BEGIN TRANSACTION

	DECLARE	@strProcedureName		VARCHAR(100)	= '[Organisation].[usp_MergeCompanyKeyBusinessDates]';
	
	DECLARE @NewData TABLE ( Action VARCHAR(20), CompanyKeyBusinessDateId INT, CompanyKeyBusinessDateEventId INT, DueDate Date );

	MERGE INTO [Organisation].[CompanyKeyBusinessDateRegister] Tar
	USING ( SELECT DISTINCT ckbd.[KeyBusinessActivity]
                          , ckbd.[Reference] as FinancialYearReference
						  , cbat.[BusinessActivityTypeId]
			FROM [Staging].[CompanyKeyBusinessDates] ckbd
			INNER JOIN [Organisation].[CompanyBusinessActivityTypes] cbat
			ON cbat.[BusinessActivityType] = ckbd.[Type]
			WHERE ckbd.[ActivityDeadline] IS NOT NULL
			) as Src
	ON Tar.[BusinessActivity] = Src.[KeyBusinessActivity]
	WHEN NOT MATCHED BY TARGET
	THEN INSERT ([BusinessActivity]
               , [BusinessActivityTypeId]
               , [FinancialYearReference]
               , [JoinGUID])
		 VALUES ( Src.[KeyBusinessActivity]
		        , Src.[BusinessActivityTypeId]
				, Src.[FinancialYearReference]
				, NewId())
	WHEN MATCHED AND (Tar.FinancialYearReference IS NULL AND Src.FinancialYearReference IS NOT NULL
	             OR Tar.FinancialYearReference != Src.FinancialYearReference
				 OR Tar.BusinessActivityTypeId != Src.BusinessActivityTypeId) THEN
	     UPDATE SET FinancialYearReference = Src.FinancialYearReference
		          , BusinessActivityTypeId = Src.BusinessActivityTypeId
	OUTPUT $action, inserted.*
	;

	MERGE INTO [Organisation].[CompanyKeyBusinessDateEvents] Tar
	USING ( SELECT cbdr.[CompanyKeyBusinessDateId]
                 , dateadd(d,cast(ckbd.[ActivityDeadline] as float)-2,'01-jan-1900')  as DueDate				 
				 , CASE WHEN ckbd.FinancialYear IS NOT NULL THEN ckbd.FinancialYear
						ELSE (SELECT FiscalYearName FROM [Core].[Calendar] c WHERE c.CalendarDate = dateadd(d,cast(ckbd.[ForDate] as float)-2,'01-jan-1900')) END as FinancialYear
				 , dateadd(d,cast(ckbd.[ForDate] as float)-2,'01-jan-1900') as EventDate
			FROM [Staging].[CompanyKeyBusinessDates] ckbd
			INNER JOIN [Organisation].[CompanyKeyBusinessDateRegister] cbdr
			ON cbdr.[BusinessActivity] = ckbd.[KeyBusinessActivity]
			WHERE ckbd.[ActivityDeadline] IS NOT NULL
			) as Src
	ON ( Tar.[CompanyKeyBusinessDateId] = Src.[CompanyKeyBusinessDateId]
	  AND Tar.[DueDate] = Src.[DueDate] )
	WHEN NOT MATCHED BY TARGET
	THEN INSERT ([CompanyKeyBusinessDateId]
               , [FinancialYear]
               , [EventDate]
               , [DueDate]
               , [JoinGUID])
		 VALUES ( Src.[CompanyKeyBusinessDateId]
		        , Src.[FinancialYear]
				, Src.[EventDate]
				, Src.[DueDate]
				, NewId())
	WHEN MATCHED AND (Tar.EventDate IS NULL AND Src.EventDate IS NOT NULL
	             OR Tar.EventDate != Src.EventDate
				 OR Tar.FinancialYear IS NULL AND Src.FinancialYear IS NOT NULL
	             OR Tar.FinancialYear != Src.FinancialYear) THEN
	     UPDATE SET FinancialYear = Src.FinancialYear
		          , EventDate = Src.EventDate
	OUTPUT $action, inserted.CompanyKeyBusinessDateId, inserted.CompanyKeyBusinessDateEventId, inserted.DueDate
	INTO @NewData (Action, CompanyKeyBusinessDateId, CompanyKeyBusinessDateEventId, DueDate)
	;
	
	-- create scheduler entries 90 days before due date
	-- changed from 10 days before RFC 2016-10-18
	
	DECLARE @FlowId uniqueidentifier;
		
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Company Key Business Dates Flow'
					);
				
	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING (
			SELECT @FlowId as FlowId,
				   DATEADD(D,-90,nd.DueDate) as LaunchDate,
				   'CompanyKeyBusinessDateEventId:' + CAST(nd.CompanyKeyBusinessDateEventId as varchar) as LaunchRef,
				   1 as IsActive
			FROM @NewData nd
			WHERE nd.action='INSERT'
			AND nd.DueDate IS NOT NULL
		 ) Src
		ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND Tar.LaunchDate = Src.LaunchDate )
		WHEN NOT MATCHED THEN 
			INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
			VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
		;
							
	MERGE INTO [Scheduler].[WorkflowParameters] WFP
	USING ( 
			SELECT LaunchList.[WorkflowLaunchId]
				, 'Number filled by scheduler' as KeyName
				,  CAST(nd.CompanyKeyBusinessDateEventId as Varchar) AS Value
				, 'ContentNumber' as ContentType
			FROM [Scheduler].[WorkflowLaunchList] LaunchList
			INNER JOIN @NewData nd
			ON LaunchList.LaunchRef = 'CompanyKeyBusinessDateEventId:' + CAST(nd.CompanyKeyBusinessDateEventId as varchar)
			AND LaunchList.FlowId = @FlowId
			WHERE nd.action='INSERT'
			AND nd.DueDate IS NOT NULL
				) Src
			ON wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
			AND wfp.[Value] = Src.[Value]
			WHEN NOT MATCHED THEN 
				INSERT ([WorkflowLaunchId],[Key],[Value],[ContentType])
				VALUES (Src.[WorkflowLaunchId], Src.[KeyName], Src.[Value], Src.[ContentType] );
	
	COMMIT TRANSACTION;

END TRY
BEGIN CATCH
		DECLARE   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		SELECT	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();
				
		ROLLBACK;

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		RETURN @ErrorNumber;
END CATCH
