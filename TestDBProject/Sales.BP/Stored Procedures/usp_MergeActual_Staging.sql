CREATE PROCEDURE [Sales.BP].[usp_MergeActual_Staging]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Sales.BP.usp_MergeActuals
-- 
-- Note:			
-- 
-- Author:			J Tapper
-- Date:			22/08/2016
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Staging.Salesforce.BP].[usp_MergeActuals_Staging]';


    DELETE s FROM [Staging.Salesforce.BP].[Actual_Staging] s  INNER JOIN [Staging.Salesforce.BP].[EventSrc] e   ON s.ActualId=e.id  COLLATE SQL_Latin1_General_CP1_CS_AS;


	MERGE INTO [Sales.BP].[Actual] Tar
	USING (SELECT ActualId	
                , [Subject] as Subject
                , ActivityDate
                , [Description] as Description
                , [AccountId] as AccountId
                , [OwnerId] as OwnerId
                , [Type] as Type
                , PlanActivityType
                , Status
			    , IsActive
			FROM [staging.salesforce.BP].[Actual_Staging] e
			--WHERE e.AccountId IS NOT NULL

			) as Src
	ON ( Tar.ActualId = Src.ActualId  COLLATE SQL_Latin1_General_CP1_CS_AS )
	WHEN NOT MATCHED
		THEN INSERT (	 ActualId
						,Subject
						,Description
						,ActivityDate
						,AccountId
						,OwnerId
						,Type
						,Status
						,PlanActivityType
						,IsActive
						,ActualCreationDatetime
						,ActualLastModifiedDatetime)
				VALUES ( Src.ActualId
					   , Src.Subject
					   , Src.Description
					   , Src.ActivityDate
					   , Src.AccountId
					   , Src.OwnerId
					   , Src.Type
					   , Src.Status
					   , Src.PlanActivityType
					   , Src.IsActive
					   , GetDate()
					   , GetDate())
	WHEN MATCHED
		AND (Tar.IsActive <> Src.IsActive
		OR Tar.Subject <> Src.Subject
		OR (Tar.Description IS NULL AND Src.Description IS NOT NULL )
		OR Tar.Description <> Src.Description
		OR Tar.ActivityDate <> Src.ActivityDate
		OR Tar.AccountId <> Src.AccountId		
		OR Tar.OwnerId <> Src.OwnerId
		OR Tar.Type <> Src.Type
		OR Tar.Status <> Src.Status
		OR Tar.PlanActivityType <> Src.PlanActivityType)		
		THEN UPDATE SET
				IsActive = Src.IsActive
			  , Subject = Src.Subject
			  , Description = Src.Description
			  , ActivityDate = Src.ActivityDate
			  , AccountId = Src.AccountId
			  , OwnerId = Src.OwnerId
			  , Type = Src.Type			  
			  , Status = Src.Status
			  , PlanActivityType = Src.PlanActivityType			  
			  , ActualLastModifiedDatetime = GetDate()
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
