CREATE PROCEDURE [Sales.BP].[usp_MergeRegions]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Sales.BP.usp_Regions
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Sales.BP].[usp_MergeRegions]';


	MERGE INTO [Sales.BP].[Region] Tar
	USING (SELECT DISTINCT CAST(SUBSTRING(r.Name, 1, CHARINDEX(' ', r.Name) - 1) as integer) AS [RegionId],
                  SUBSTRING(r.Name, CHARINDEX(' ', r.Name) + 1, LEN(r.Name)) AS [RegionName],
				  r.Description__c as Description, 
			      Regional_Sales_Manager__c as RegionalSalesManager,
			      Sales_Account_Manager__c  as SalesAccountManager,
			      SW_GLEQ__c  as SwGleq,
			      SW_REST__c  as SwRest,
			      SW_TSAL__c  as SwTsal,
			      SW_UKAC__c  as SwUkac,
			      SW_UKEB__c  as SwUkeb,
			      SW_UKEI__c as SwUkei,
			      Total_Sector_Weightings__c as TotalSectorWeightings,
			      CASE WHEN [IsDeleted]='false' THEN 1 ELSE 0 END as IsActive
			FROM [Staging.Salesforce.BP].[RegionSrc] r

			) as Src
	ON ( Tar.RegionId = Src.RegionId )
	WHEN NOT MATCHED
		THEN INSERT (RegionId, RegionName, Description, RegionalSalesManager, SalesAccountManager, SwGleq,SwRest,
	                 SwTsal,SwUkac,SwUkeb,SwUkei,TotalSectorWeightings, IsActive
					, RegionCreationDatetime, RegionLastModifiedDatetime)
			 VALUES (Src.RegionId, Src.RegionName, Src.Description, Src.RegionalSalesManager, Src.SalesAccountManager, Src.SwGleq, Src.SwRest,
	                 Src.SwTsal,Src.SwUkac,Src.SwUkeb,Src.SwUkei,Src.TotalSectorWeightings, Src.IsActive
						, GetDate(), GetDate())
	WHEN MATCHED
	    AND (Tar.IsActive <> Src.IsActive
		OR Tar.RegionName <> Src.RegionName
		OR Tar.Description <> Src.Description
		OR Tar.RegionalSalesManager <> Src.RegionalSalesManager	
		OR Tar.SalesAccountManager <> Src.SalesAccountManager
		OR Tar.TotalSectorWeightings <> Src.TotalSectorWeightings)
		THEN UPDATE SET
				IsActive = Src.IsActive
			  , RegionName = Src.RegionName
			  , Description = Src.Description
			  , RegionalSalesManager = Src.RegionalSalesManager
			  , SalesAccountManager = Src.SalesAccountManager
			  , TotalSectorWeightings =  Src.TotalSectorWeightings
			  , RegionLastModifiedDatetime = GetDate()
			  
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
