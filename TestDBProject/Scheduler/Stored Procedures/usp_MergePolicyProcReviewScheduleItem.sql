CREATE PROCEDURE [Scheduler].[usp_MergePolicyProcReviewScheduleItem]
 
AS
BEGIN TRY

	SET NOCOUNT ON
	
	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_MergePolicyProcReviewScheduleItem',
			@FlowId UNIQUEIDENTIFIER;

	DECLARE @WorkFlowLaunchId INT;
	
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Policy & Procedures scheduled review'
					);
					
	DECLARE @NewData TABLE ( LaunchDate DATE,LaunchRef VARCHAR(255));

	-- for already existing future schedule items, update launch date
	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING (
			SELECT @FlowId as FlowId,
				   DATEADD(d,rf.[ReviewWithinDays]*-1,pr.[NextReviewDate]) as LaunchDate,
				   'PolicyId:' + CAST(pr.[PolicyId] as varchar) as LaunchRef,
				   1 as IsActive
			FROM [PolicyProc].[PolicyRegister] pr
			INNER JOIN [PolicyProc].[ReviewFrequency] rf
		    ON rf.ReviewFrequencyId = pr.ReviewFrequencyId
		    WHERE ISNULL(pr.[IsActive],0) = 1 
			AND pr.[NextReviewDate] IS NOT NULL
			AND DATEADD(d,rf.[ReviewWithinDays]*-1,pr.[NextReviewDate])  >= GetDate()
			UNION 
			SELECT @FlowId as FlowId,
				   DATEADD(d,rf.[ReviewWithinDays]*-1,pd.[NextReviewDate]) as LaunchDate,
				   'ProcDocumentId:' + CAST(pd.[ProcDocumentId] as varchar) as LaunchRef,
				   1 as IsActive
			FROM [PolicyProc].[ProceduresDocument] pd
			INNER JOIN [PolicyProc].[ReviewFrequency] rf
		    ON rf.ReviewFrequencyId = pd.ReviewFrequencyId
		    WHERE ISNULL(pd.[IsActive],0) = 1 
			AND pd.[NextReviewDate] IS NOT NULL
			AND DATEADD(d,rf.[ReviewWithinDays]*-1,pd.[NextReviewDate])  >= GetDate()
		 ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND Tar.[LaunchDate] >= GetDate () ) -- future dates
		WHEN NOT MATCHED THEN 
		INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
		VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
		WHEN MATCHED THEN
			UPDATE SET [LaunchDate] = Src.LaunchDate
					 , [IsActive]=1
		OUTPUT inserted.LaunchDate, inserted.LaunchRef
		INTO @NewData(LaunchDate, LaunchRef)
		;
		
	MERGE INTO [Scheduler].[WorkflowParameters] wfp
	USING ( 
			SELECT wfll.[WorkflowLaunchId]
				, 'Number filled by scheduler' as KeyName
				,  CAST(SUBSTRING(wfll.LaunchRef, CHARINDEX(':', wfll.LaunchRef) + 1, LEN(wfll.LaunchRef)) as Varchar) AS Value
				, 'ContentNumber' as ContentType
			FROM [Scheduler].[WorkflowLaunchList] wfll
			INNER JOIN @NewData nd
			ON wfll.LaunchDate = nd.LaunchDate
			AND wfll.LaunchRef = nd.LaunchRef
			AND wfll.FlowId = @FlowId
				) Src
			ON wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
			AND wfp.[Value] = Src.[Value]
			WHEN NOT MATCHED THEN 
				INSERT ([WorkflowLaunchId],[Key],[Value],[ContentType])
				VALUES (Src.[WorkflowLaunchId], Src.[KeyName], Src.[Value], Src.[ContentType] );
					
	MERGE INTO [Scheduler].[WorkflowParameters] wfp
	USING ( 
			SELECT wfll.[WorkflowLaunchId]
				, 'String filled by scheduler' as KeyName
				, CASE WHEN wfll.LaunchRef like 'PolicyId:%' THEN 'Policy' ELSE 'ProcDocument' END AS Value
				, 'ContentString' as ContentType
			FROM [Scheduler].[WorkflowLaunchList] wfll
			INNER JOIN @NewData nd
			ON wfll.LaunchDate = nd.LaunchDate
			AND wfll.LaunchRef = nd.LaunchRef
			AND wfll.FlowId = @FlowId
				) Src
			ON wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
			AND wfp.[Value] = Src.[Value]
			WHEN NOT MATCHED THEN 
				INSERT ([WorkflowLaunchId],[Key],[Value],[ContentType])
				VALUES (Src.[WorkflowLaunchId], Src.[KeyName], Src.[Value], Src.[ContentType] );

				
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
