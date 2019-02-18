
CREATE PROCEDURE [Sales.BP].[usp_MergeSfAccounts]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Sales.BP.usp_MergeSfAccounts
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			05/09/2016
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Sales.BP].[usp_MergeSfAccounts]';

	Declare @CurrDate datetime = GETDATE();
	Declare @EndDate datetime = '2099-12-31T00:00:00.000';
	Declare @ModifiedBy varchar(50) = 'Boomi Salesforce data load';

	INSERT INTO [Sales.BP].[SfAccount]
	( [SfAccountId],
		[AccountName],
		[FcaId],
		[MatrixOutletId],
		[OutletType],
		[AccountSivId],
		[ParentAccountSivId],	
		[AccountOwnerId],
		[Phone],
		[Fax],	
		[Website],
		[EmailAddress],
		[RegionId],
		[CalculatedPriority],
		[IsKeyAccount],
		[IsPriorityClient],
		[IsLocked], -- IanMc 10/2/17
		[FirmSegment],
		[PlatformsUsed],
		[AuthStatus],
		[BillingStreet],
		[BillingCity],
		[BillingState],
		[BillingPostcode],
		[BillingCountry],
		[ModifiedBy],
		[IsActive],
		[StartDatetime],
		[EndDatetime]
	)
	SELECT
		SfAccountId
		,AccountName
		,FcaId
		,MatrixOutletId
		,OutletType
		,AccountSivId
		,ParentAccountSivId	
		,AccountOwnerId
		,Phone
		,Fax
		,Website
		,EmailAddress
		,RegionId
		,CalculatedPriority
		,IsKeyAccount
		,IsPriorityClient
		,IsLocked -- IanMc 10/2/17
		,FirmSegment
		,PlatformsUsed
		,AuthStatus
		,BillingStreet
		,BillingCity
		,BillingState
		,BillingPostcode
		,BillingCountry
		,@ModifiedBy
		,1            --IsActive
		,@CurrDate    --ValidFrom
		,@EndDate     --ValidTo
	FROM (
		MERGE INTO [Sales.BP].[SfAccount] Tar
		USING (SELECT [AccFcaId] as FcaId
				 ,[AccSalesforceId] as SfAccountId
				 ,[AccMatrixOutletId] as MatrixOutletId
				 ,[AccSivId] as AccountSivId
				 ,[AccParentSivId] as ParentAccountSivId
				 ,[AccOwnerId] as AccountOwnerId
				 ,[AccName] as AccountName
				 ,[AccOutletType] as OutletType
				 ,[AccBillingStreet] as BillingStreet
				 ,[AccBillingCity] as BillingCity
				 ,[AccBillingState] as BillingState
				 ,[AccBillingPostcode] as BillingPostcode
				 ,[AccBillingCountry] as BillingCountry
	             ,[AccLandline] as Phone
	             ,[AccFax] as Fax
	             ,[AccWebsite] as Website
				 ,[AccEmail] as EmailAddress
	             ,[AccFirmSegment] as FirmSegment
	             ,[AccAuthStatus] as AuthStatus
	             ,[AccPlatformsUsed] as PlatformsUsed
	             ,CASE [AccPriorityClient] WHEN 'true' then 1 ELSE 0 END as IsPriorityClient
	             ,CASE [AccIsLocked] WHEN 'true' then 1 ELSE 0 END as IsLocked -- IanMc 10/2/17
	             ,CAST([AccCalculatedPriority] as decimal(19,2)) as CalculatedPriority
	             ,CASE [AccKeyAccount] WHEN 'true' then 1 ELSE 0 END IsKeyAccount
				 ,CASE WHEN a.[AccRegionCode] IS NOT NULL AND a.[AccRegionCode] != 'Unallocated' THEN CAST(SUBSTRING(a.[AccRegionCode], 1, CHARINDEX(' ', a.[AccRegionCode]) - 1) as integer) ELSE NULL END as RegionId
				 ,1 as IsActive
				FROM [Staging.Salesforce.BP].[SfAccountRaw] a

			) as Src
		ON ( Tar.SfAccountId = Src.SfAccountId
		AND Tar.IsActive = Src.IsActive ) -- merge on active accounts
		WHEN NOT MATCHED BY TARGET
			THEN INSERT ( [SfAccountId],
                      [AccountName],
	                  [FcaId],
	                  [MatrixOutletId],
                      [OutletType],
	                  [AccountSivId],
	                  [ParentAccountSivId],	
	                  [AccountOwnerId],
                      [Phone],
                      [Fax],	
                      [Website],
                      [EmailAddress],
                      [RegionId],
                      [CalculatedPriority],
                      [IsKeyAccount],
	                  [IsPriorityClient],
	                  [IsLocked], -- IanMc 10/2/17
                      [FirmSegment],
                      [PlatformsUsed],
                      [AuthStatus],
	                  [BillingStreet],
	                  [BillingCity],
	                  [BillingState],
	                  [BillingPostcode],
	                  [BillingCountry],
	                  [ModifiedBy],
	                  [IsActive],
	                  [StartDatetime],
	                  [EndDatetime]
                    )
              VALUES (
                      SfAccountId
                     ,AccountName
	                 ,FcaId
	                 ,MatrixOutletId
                     ,OutletType
	                 ,AccountSivId
	                 ,ParentAccountSivId	
	                 ,AccountOwnerId
                     ,Phone
                     ,Fax
                     ,Website
                     ,EmailAddress
                     ,RegionId
                     ,CalculatedPriority
                     ,IsKeyAccount
	                 ,IsPriorityClient
	                 ,IsLocked -- IanMc 10/2/17
                     ,FirmSegment
                     ,PlatformsUsed
                     ,AuthStatus
	                 ,BillingStreet
	                 ,BillingCity
	                 ,BillingState
	                 ,BillingPostcode
	                 ,BillingCountry
                     ,@ModifiedBy
                     ,1            --IsActive
                     ,@CurrDate    --ValidFrom
                     ,@EndDate     --ValidTo
					 )
		WHEN MATCHED
			AND ( Tar.AccountName <> Src.AccountName
			OR (Tar.AccountName IS NULL AND Src.AccountName IS NOT NULL)
			OR (Tar.AccountName IS NOT NULL AND Src.AccountName IS NULL)
			OR Tar.FcaId <> Src.FcaId
			OR (Tar.FcaId IS NULL AND Src.FcaId IS NOT NULL)
			OR (Tar.FcaId IS NOT NULL AND Src.FcaId IS NULL)
			OR Tar.MatrixOutletId <> Src.MatrixOutletId
			OR (Tar.MatrixOutletId IS NULL AND Src.MatrixOutletId IS NOT NULL)
			OR (Tar.MatrixOutletId IS NOT NULL AND Src.MatrixOutletId IS NULL)
			OR Tar.OutletType <> Src.OutletType
			OR (Tar.OutletType IS NULL AND Src.OutletType IS NOT NULL)
			OR (Tar.OutletType IS NOT NULL AND Src.OutletType IS NULL)
			OR Tar.AccountSivId <> Src.AccountSivId
			OR (Tar.AccountSivId IS NULL AND Src.AccountSivId IS NOT NULL)
			OR (Tar.AccountSivId IS NOT NULL AND Src.AccountSivId IS NULL)
			OR Tar.ParentAccountSivId <> Src.ParentAccountSivId
			OR (Tar.ParentAccountSivId IS NULL AND Src.ParentAccountSivId IS NOT NULL)
			OR (Tar.ParentAccountSivId IS NOT NULL AND Src.ParentAccountSivId IS NULL)
			OR Tar.Phone <> Src.Phone
			OR (Tar.Phone IS NULL AND Src.Phone IS NOT NULL)
			OR (Tar.Phone IS NOT NULL AND Src.Phone IS NULL)
			OR Tar.Fax <> Src.Fax
			OR (Tar.Fax IS NULL AND Src.Fax IS NOT NULL)
			OR (Tar.Fax IS NOT NULL AND Src.Fax IS NULL)
			OR Tar.Website <> Src.Website
			OR (Tar.Website IS NULL AND Src.Website IS NOT NULL)
			OR (Tar.Website IS NOT NULL AND Src.Website IS NULL)
			OR Tar.EmailAddress <> Src.EmailAddress
			OR (Tar.EmailAddress IS NULL AND Src.EmailAddress IS NOT NULL)
			OR (Tar.EmailAddress IS NOT NULL AND Src.EmailAddress IS NULL)
			OR Tar.RegionId <> Src.RegionId
			OR (Tar.RegionId IS NULL AND Src.RegionId IS NOT NULL)
			OR (Tar.RegionId IS NOT NULL AND Src.RegionId IS NULL)
			OR Tar.CalculatedPriority <> Src.CalculatedPriority
			OR (Tar.CalculatedPriority IS NULL AND Src.CalculatedPriority IS NOT NULL)
			OR (Tar.CalculatedPriority IS NOT NULL AND Src.CalculatedPriority IS NULL)
			OR Tar.IsKeyAccount <> Src.IsKeyAccount
			OR (Tar.IsKeyAccount IS NULL AND Src.IsKeyAccount IS NOT NULL)
			OR (Tar.IsKeyAccount IS NOT NULL AND Src.IsKeyAccount IS NULL)
			--
			OR Tar.IsPriorityClient <> Src.IsPriorityClient
			OR (Tar.IsPriorityClient IS NULL AND Src.IsPriorityClient IS NOT NULL)
			OR (Tar.IsPriorityClient IS NOT NULL AND Src.IsPriorityClient IS NULL)
			-- IanMc 10/2/17
			OR Tar.IsLocked <> Src.IsLocked
			OR (Tar.IsLocked IS NULL AND Src.IsLocked IS NOT NULL)
			OR (Tar.IsLocked IS NOT NULL AND Src.IsLocked IS NULL)
			--
			OR Tar.FirmSegment <> Src.FirmSegment
			OR (Tar.FirmSegment IS NULL AND Src.FirmSegment IS NOT NULL)
			OR (Tar.FirmSegment IS NOT NULL AND Src.FirmSegment IS NULL)
			OR Tar.PlatformsUsed <> Src.PlatformsUsed
			OR (Tar.PlatformsUsed IS NULL AND Src.PlatformsUsed IS NOT NULL)
			OR (Tar.PlatformsUsed IS NOT NULL AND Src.PlatformsUsed IS NULL)
			OR Tar.AuthStatus <> Src.AuthStatus
			OR (Tar.AuthStatus IS NULL AND Src.AuthStatus IS NOT NULL)
			OR (Tar.AuthStatus IS NOT NULL AND Src.AuthStatus IS NULL)
			OR Tar.BillingStreet <> Src.BillingStreet
			OR (Tar.BillingStreet IS NULL AND Src.BillingStreet IS NOT NULL)
			OR (Tar.BillingStreet IS NOT NULL AND Src.BillingStreet IS NULL)
			OR Tar.BillingCity <> Src.BillingCity
			OR (Tar.BillingCity IS NULL AND Src.BillingCity IS NOT NULL)
			OR (Tar.BillingCity IS NOT NULL AND Src.BillingCity IS NULL)
			OR Tar.BillingState <> Src.BillingState
			OR (Tar.BillingState IS NULL AND Src.BillingState IS NOT NULL)
			OR (Tar.BillingState IS NOT NULL AND Src.BillingState IS NULL)
			OR Tar.BillingPostcode <> Src.BillingPostcode
			OR (Tar.BillingPostcode IS NULL AND Src.BillingPostcode IS NOT NULL)
			OR (Tar.BillingPostcode IS NOT NULL AND Src.BillingPostcode IS NULL)
			OR Tar.BillingCountry <> Src.BillingCountry
			OR (Tar.BillingCountry IS NULL AND Src.BillingCountry IS NOT NULL)
			OR (Tar.BillingCountry IS NOT NULL AND Src.BillingCountry IS NULL) )
		THEN UPDATE SET
				IsActive = 0
			  , [EndDatetime] = @CurrDate
			  , [LastModifiedDatetime] = GetDate()
		WHEN NOT MATCHED BY SOURCE AND Tar.IsActive = 1
		THEN UPDATE SET
			  IsActive = 0
			, [EndDatetime] = @CurrDate
			, [LastModifiedDatetime] = GetDate()			
		OUTPUT $action AS Action
			,[Src].*
		) AS MergeOutput
	WHERE MergeOutput.Action = 'UPDATE' 
	AND MergeOutput.SfAccountId IS NOT NULL
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
