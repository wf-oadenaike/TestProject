CREATE PROCEDURE [Scheduler].[usp_MergeContractorWorkflowItem]
 @EmployeeID VARCHAR(20),
 @Noticeperiod Float, 
 @EffectiveTo Datetime,
 @WeeksMonths Nvarchar(100)

AS
BEGIN TRY
	SET NOCOUNT ON

	DECLARE	@strProcedureName		VARCHAR(100)	= '[Scheduler].[usp_MergeContractorWorkflowItem]';	
	
	DECLARE @NewData TABLE ( FlowId VARCHAR(100),LaunchDate DATE,LaunchRef VARCHAR(255),EmployeeID VARCHAR(20));

			-- Change to one month before notice period begins if monthly #PRP-5028 R. Carter 26/04/2016
	
			INSERT INTO @NewData(FlowId,LaunchDate,LaunchRef,EmployeeID)
			SELECT 
				WF.FlowId,
				CASE WHEN @WeeksMonths='Months' THEN
				CONVERT(DATE,DATEADD(m, -(@Noticeperiod+1), @EffectiveTo),103) 
				ELSE
				CONVERT(DATE,DATEADD(ww,-2*@Noticeperiod, @EffectiveTo),103)
				END AS LaunchDate,
				'SF_Employee_ID:'+ @EmployeeID AS LaunchRef
				,@EmployeeID as EmployeeID
				-- ,Rol.[Effective to] ,emp.*
			FROM [Scheduler].[Workflows] WF 
			WHERE WF.FlowName='Contract Notice Period'
			--AND Emp.[Employment status] IN ('FTC','Contractor') 
			--AND Emp.[HR user status]='Active'
			AND @EffectiveTo IS NOT NULL
			;

	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING (
			SELECT 
				NEW.FlowId,
				NEW.LaunchDate,
				NEW.LaunchRef,
				1 AS IsActive,
				GETDATE() AS CreatedDate-- ,Rol.[Effective to] ,emp.*
				FROM @NewData NEW

		 ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef)
	WHEN NOT MATCHED 
		THEN INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
			 VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
	;

  MERGE INTO [Scheduler].[WorkflowParameters] WFP
  USING ( 
		  SELECT LaunchList.[WorkflowLaunchId]
               , 'SF_Employee_ID' as KeyName
		       ,REPLACE(LaunchList.LaunchRef,'SF_Employee_ID:','') AS Value
			   , 'ContentString' as ContentType
		  FROM [Scheduler].[WorkflowLaunchList] LaunchList
		  INNER JOIN @NewData NEW
		  ON NEW.LaunchRef = LaunchList.LaunchRef
		) Src
  ON wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
  AND wfp.[Value] = Src.[Value]
  WHEN NOT MATCHED THEN 
		INSERT ([WorkflowLaunchId],[Key],[Value],[ContentType])
		VALUES (Src.[WorkflowLaunchId], Src.[KeyName], Src.[Value], Src.[ContentType] )
				;			
	
			
END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		Select	  @ErrorNumber		= ERROR_NUMBER()
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
