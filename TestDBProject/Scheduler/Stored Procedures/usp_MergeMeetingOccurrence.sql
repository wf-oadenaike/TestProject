CREATE PROCEDURE [Scheduler].[usp_MergeMeetingOccurrence]
AS
BEGIN TRY
	SET NOCOUNT ON

	DECLARE @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	DECLARE	@strProcedureName		VARCHAR(100)	= '[Scheduler].[usp_MergeMeetingOccurrence]';

	WITH Src AS
		(SELECT 
			  '67625192-3B8D-46BF-A469-3E258FBCC376' AS FlowId
			  ,CONVERT(DATE, DATEADD(d, - mr.LagDays, mo.MeetingDateTime)) AS LaunchDate
			  ,'MeetingOccurrenceId:' + RTRIM(CONVERT(VARCHAR(8), mo.MeetingOccurrenceId)) AS LaunchRef
			  , (CASE WHEN mr.ActiveFlag = 1 AND 
			  mo.ActiveFlag = 1 THEN 1 ELSE 0 END) AS IsActive
			  FROM
			  [Organisation].[MeetingOccurrence] mo INNER JOIN [Organisation].[MeetingsRegister] mr ON mo.MeetingRegisterId = mr.MeetingRegisterId
		)
	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING Src
	ON ( Tar.[FlowId] = Src.[FlowId] AND Tar.LaunchRef = Src.LaunchRef)
	WHEN NOT MATCHED BY SOURCE AND Tar.[FlowId] = '67625192-3B8D-46BF-A469-3E258FBCC376'
		THEN UPDATE SET Tar.IsActive = 0
	WHEN NOT MATCHED BY TARGET
		THEN INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
			 VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
	WHEN MATCHED AND ( Tar.IsActive <> Src.IsActive OR Tar.LaunchDate <> Src.LaunchDate )
		THEN UPDATE SET IsActive = Src.IsActive
		              , LaunchDate = Src.LaunchDate 

	--OUTPUT $action, inserted.*
	;
	--SET @InsertRowCount = @@ROWCOUNT;

/*
	SELECT @ProcessRowCount AS ProcessRowCount
		, @InsertRowCount AS InsertRowCount
		, @UpdateRowCount AS UpdateRowCount
		, @DeleteRowCount AS DeleteRowCount
		;
*/

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
		Return @ErrorNumber;
END CATCH
