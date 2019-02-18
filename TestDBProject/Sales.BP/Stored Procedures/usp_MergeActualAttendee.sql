CREATE PROCEDURE [Sales.BP].[usp_MergeActualAttendee]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Sales.BP.usp_MergeActualAttendee
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			07/07/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Sales.BP].[ActualAttendee]';


	
	MERGE INTO [Sales.BP].[ActualAttendee] Tar
	USING (SELECT [EventId] as	ActualId	
                , [AttendeeId] as ContactId
			    , CASE WHEN [IsDeleted]='false' THEN 1 ELSE 0 END as IsActive
			FROM [Staging.Salesforce.BP].[EventAttendeeSrc]

			) as Src
	ON ( Tar.ActualId = Src.ActualId
	 AND Tar.ContactId = Src.ContactId )
	WHEN NOT MATCHED
		THEN INSERT (	 ActualId
						,ContactId
						,IsActive
						,ActualAttendeeCreationDatetime
						,ActualAttendeeLastModifiedDatetime)
				VALUES ( Src.ActualId
					   , Src.ContactId
					   , Src.IsActive
					   , GetDate()
					   , GetDate())
	WHEN MATCHED
		AND Tar.IsActive <> Src.IsActive		
		THEN UPDATE SET
				IsActive = Src.IsActive		  
			  , ActualAttendeeLastModifiedDatetime = GetDate()
	;
	
/*
	SET @InsertRowCount = @@ROWCOUNT;

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
