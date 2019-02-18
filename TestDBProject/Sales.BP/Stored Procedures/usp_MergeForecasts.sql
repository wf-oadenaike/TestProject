CREATE PROCEDURE [Sales.BP].[usp_MergeForecasts]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Sales.BP.usp_MergeForecast
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			24/05/2016
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Sales.BP].[usp_MergeForecasts]';

	MERGE INTO [Sales.BP].[Forecast] Tar
	USING (SELECT [Id] as	ForecastId	
                , [Subject] as Subject
                , CAST(SUBSTRING(t.[ActivityDate], 1, CHARINDEX(' ', t.[ActivityDate]) - 1) as date) as ActivityDate
                , [Description] as Description
				, [Priority] as Priority
                , [AccountId] as AccountId
                , [OwnerId] as OwnerId
                , [Type] as Type
                , [Plan_Activity_Type__c] as PlanActivityType
                , [Status] as Status
			    , CASE WHEN [IsDeleted]='false' THEN 1 ELSE 0 END as IsActive
			FROM [Staging.Salesforce.BP].[TaskSrc] t

			) as Src
	ON ( Tar.ForecastId = Src.ForecastId )
	WHEN NOT MATCHED
		THEN INSERT (	 ForecastId
						,Subject
						,Description
						,ActivityDate
						,AccountId
						,OwnerId
						,Type
						,Status
						,PlanActivityType
						,IsActive
						,ForecastCreationDatetime
						,ForecastLastModifiedDatetime)
				VALUES ( Src.ForecastId
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
			  , ForecastLastModifiedDatetime = GetDate()
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
