CREATE PROCEDURE [Sales.BP].[usp_MergeActuals]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Sales.BP.usp_MergeActuals
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Sales.BP].[usp_MergeActuals]';


	MERGE INTO [Sales.BP].[Actual] Tar
	USING (SELECT [Id] as	ActualId	
                , [Subject] as Subject
                , CAST(SUBSTRING(e.[ActivityDate], 1, CHARINDEX(' ', e.[ActivityDate]) - 1) as date) as ActivityDate
                , [Description] as Description
                , [AccountId] as AccountId
                , [OwnerId] as OwnerId
                , [Type] as Type
                , [Plan_Activity_Type__c] as PlanActivityType
                , [Call_Summary__c] as Status
			    , CASE WHEN [IsDeleted]='false' THEN 1 ELSE 0 END as IsActive
			FROM [Staging.Salesforce.BP].[EventSrc] e
			--WHERE e.AccountId IS NOT NULL

			) as Src
	ON ( Tar.ActualId = Src.ActualId )
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

--JT added to use Acct Char(15) for tuning
--Update [Sales.BP].[Account] set AccountID_15= left(AccountID,15) where  AccountID_15 = -1
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
