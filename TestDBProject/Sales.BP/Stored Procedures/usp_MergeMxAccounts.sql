

CREATE PROCEDURE [Sales.BP].[usp_MergeMxAccounts]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Sales.BP.usp_MergeMxAccounts
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			05/09/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 2017-0919 Joe Tapper
-- Added 2 columns for Primary Business
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Sales.BP].[usp_MergeMxAccounts]';

	Declare @CurrDate datetime = GETDATE();
	Declare @EndDate datetime = '2099-12-31T00:00:00.000';
	Declare @ModifiedBy varchar(50) = 'Boomi Matrix data load';

	INSERT INTO [Sales.BP].[MxAccount]
	( [SfAccountId],
		[AccountName],
		[FcaId],
		[MatrixOutletId],
		[OutletType],	
		[AccountOwnerId],
		[AccountOwnerName],
	    [AccountSivId],
        [ParentAccountSivId],
		[Phone],
		[Fax],	
		[Website],
		[EmailAddress],
		[IsPriorityClient],
		[FirmSegment],
		[PlatformsUsed],
		[AuthStatus],
		[BillingStreet],
		[BillingCity],
		[BillingState],
		[BillingPostcode],
		[BillingCountry],
		[VerifiedBy],
	    [IsExistingCompanyRelationship],
		[ModifiedBy],
		[IsActive],
		[StartDatetime],
		[EndDatetime],
		MX_PRIMARY_BUSINESS,
		WF_PRIMARY_BUSINESS
	)
	SELECT
		 SfAccountId
		,AccountName
		,FcaId
		,MatrixOutletId
		,OutletType
		,AccountOwnerId
		,AccountOwnerName
		,AccountSivId
        ,ParentAccountSivId
		,Phone
		,Fax
		,Website
		,EmailAddress
		,IsPriorityClient
		,FirmSegment
		,PlatformsUsed
		,AuthStatus
		,BillingStreet
		,BillingCity
		,BillingState
		,BillingPostcode
		,BillingCountry
		,VerifiedBy
	    ,IsExistingCompanyRelationship
		,@ModifiedBy
		,1            --IsActive
		,@CurrDate    --ValidFrom
		,@EndDate     --ValidTo
		,MX_PRIMARY_BUSINESS
		,WF_PRIMARY_BUSINESS
	FROM (
		MERGE INTO [Sales.BP].[MxAccount] Tar
		USING (SELECT [AccFcaId] as FcaId
				 ,[AccSalesforceId]  as SfAccountId
				 ,[AccMatrixOutletId] as MatrixOutletId
				 ,[AccOwnerId] as AccountOwnerId
				 ,[AccOwnerName] as AccountOwnerName
				 ,[AccName] as AccountName
				 ,[AccSivId] as AccountSivId
                 ,[AccParentSivId] as ParentAccountSivId
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
	             ,CASE [AccPriorityClient] WHEN 'Y' THEN 1 ELSE 0 END as IsPriorityClient
				 ,[AccVerifiedBy] as VerifiedBy
				 ,CASE [AccExistingCompanyRelationship] WHEN 'Y' THEN 1 ELSE 0 END as IsExistingCompanyRelationship
				 ,1 as IsActive
				 ,MX_PRIMARY_BUSINESS
				 ,WF_PRIMARY_BUSINESS
				FROM (SELECT [AccFcaId]
							,[AccSalesforceId]
							,[AccMatrixOutletId]
							,[AccOwnerId]
							,[AccOwnerName]
							,[AccName]
							,[AccSivId]
							,[AccParentSivId]
							,[AccOutletType]
							,[AccBillingStreet]
							,[AccBillingCity]
							,[AccBillingState]
							,[AccBillingPostcode]
							,[AccBillingCountry]
							,[AccLandline]
							,[AccFax]
							,[AccWebsite]
							,[AccEmail]
							,[AccFirmSegment]
							,[AccAuthStatus]
							,[AccPlatformsUsed]
							,[AccPriorityClient]
							,[AccVerifiedBy]
							,[AccExistingCompanyRelationship]
							,MX_PRIMARY_BUSINESS
							,WF_PRIMARY_BUSINESS
					        ,row_number() over
                           (
                             partition by    [AccMatrixOutletId]
                             order by        [AccSalesforceId] DESC
                           ) AccOutletId_rank
                        FROM [Staging.Salesforce.BP].[MxAccountRaw]
                        WHERE [AccFcaId] IS NOT NULL
                        AND [AccMatrixOutletId] IS NOT NULL) a
				    WHERE a.AccOutletId_rank = 1

			) as Src
		ON ( Tar.MatrixOutletId = Src.MatrixOutletId
		AND Tar.IsActive = Src.IsActive )
		WHEN NOT MATCHED BY TARGET
			THEN INSERT ( [SfAccountId],
                      [AccountName],
	                  [FcaId],
	                  [MatrixOutletId],
                      [OutletType],
	                  [AccountOwnerId],
					  [AccountOwnerName],
					  [AccountSivId],
					  [ParentAccountSivId],
                      [Phone],
                      [Fax],	
                      [Website],
                      [EmailAddress],
	                  [IsPriorityClient],
                      [FirmSegment],
                      [PlatformsUsed],
                      [AuthStatus],
	                  [BillingStreet],
	                  [BillingCity],
	                  [BillingState],
	                  [BillingPostcode],
	                  [BillingCountry],
					  [VerifiedBy],
					  [IsExistingCompanyRelationship],
	                  [ModifiedBy],
	                  [IsActive],
	                  [StartDatetime],
	                  [EndDatetime]
					  ,MX_PRIMARY_BUSINESS
					  ,WF_PRIMARY_BUSINESS
		
                    )
              VALUES (
                      SfAccountId
                     ,AccountName
	                 ,FcaId
	                 ,MatrixOutletId
                     ,OutletType	
	                 ,AccountOwnerId
					 ,AccountOwnerName
					 ,AccountSivId
                     ,ParentAccountSivId
                     ,Phone
                     ,Fax
                     ,Website
                     ,EmailAddress
	                 ,IsPriorityClient
                     ,FirmSegment
                     ,PlatformsUsed
                     ,AuthStatus
	                 ,BillingStreet
	                 ,BillingCity
	                 ,BillingState
	                 ,BillingPostcode
	                 ,BillingCountry
					 ,VerifiedBy
					 ,IsExistingCompanyRelationship
                     ,@ModifiedBy
                     ,1            --IsActive
                     ,@CurrDate    --ValidFrom
                     ,@EndDate     --ValidTo
		   		     ,MX_PRIMARY_BUSINESS
				     ,WF_PRIMARY_BUSINESS
		
					 )
		WHEN MATCHED
			AND ( Tar.AccountName <> Src.AccountName
			OR (Tar.AccountName IS NULL AND Src.AccountName IS NOT NULL)
			OR (Tar.AccountName IS NOT NULL AND Src.AccountName IS NULL)
			OR Tar.FcaId <> Src.FcaId
			OR (Tar.FcaId IS NULL AND Src.FcaId IS NOT NULL)
			OR (Tar.FcaId IS NOT NULL AND Src.FcaId IS NULL)
			OR Tar.AccountSivId <> Src.AccountSivId
			OR (Tar.AccountSivId IS NULL AND Src.AccountSivId IS NOT NULL)
			OR (Tar.AccountSivId IS NOT NULL AND Src.AccountSivId IS NULL)			
			OR Tar.ParentAccountSivId <> Src.ParentAccountSivId
			OR (Tar.ParentAccountSivId IS NULL AND Src.ParentAccountSivId IS NOT NULL)
			OR (Tar.ParentAccountSivId IS NOT NULL AND Src.ParentAccountSivId IS NULL)	
			OR Tar.OutletType <> Src.OutletType
			OR (Tar.OutletType IS NULL AND Src.OutletType IS NOT NULL)
			OR (Tar.OutletType IS NOT NULL AND Src.OutletType IS NULL)
			OR Tar.AccountOwnerId <> Src.AccountOwnerId
			OR (Tar.AccountOwnerId IS NULL AND Src.AccountOwnerId IS NOT NULL)
			OR (Tar.AccountOwnerId IS NOT NULL AND Src.AccountOwnerId IS NULL)			
			OR Tar.AccountOwnerName <> Src.AccountOwnerName
			OR (Tar.AccountOwnerName IS NULL AND Src.AccountOwnerName IS NOT NULL)
			OR (Tar.AccountOwnerName IS NOT NULL AND Src.AccountOwnerName IS NULL)			
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
			OR Tar.IsPriorityClient <> Src.IsPriorityClient
			OR (Tar.IsPriorityClient IS NULL AND Src.IsPriorityClient IS NOT NULL)
			OR (Tar.IsPriorityClient IS NOT NULL AND Src.IsPriorityClient IS NULL)
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
			OR (Tar.BillingCountry IS NOT NULL AND Src.BillingCountry IS NULL)
			OR Tar.VerifiedBy <> Src.VerifiedBy
			OR (Tar.VerifiedBy IS NULL AND Src.VerifiedBy IS NOT NULL)
			OR (Tar.VerifiedBy IS NOT NULL AND Src.VerifiedBy IS NULL)
			OR Tar.IsExistingCompanyRelationship <> Src.IsExistingCompanyRelationship
			OR (Tar.IsExistingCompanyRelationship IS NULL AND Src.IsExistingCompanyRelationship IS NOT NULL)
			OR (Tar.IsExistingCompanyRelationship IS NOT NULL AND Src.IsExistingCompanyRelationship IS NULL)

			OR Tar.MX_PRIMARY_BUSINESS <> Src.MX_PRIMARY_BUSINESS
			OR (Tar.MX_PRIMARY_BUSINESS IS NULL AND Src.MX_PRIMARY_BUSINESS IS NOT NULL)
			OR (Tar.MX_PRIMARY_BUSINESS IS NOT NULL AND Src.MX_PRIMARY_BUSINESS IS NULL)

			OR Tar.WF_PRIMARY_BUSINESS <> Src.WF_PRIMARY_BUSINESS
			OR (Tar.WF_PRIMARY_BUSINESS IS NULL AND Src.WF_PRIMARY_BUSINESS IS NOT NULL)
			OR (Tar.WF_PRIMARY_BUSINESS IS NOT NULL AND Src.WF_PRIMARY_BUSINESS IS NULL)

			)
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
	AND MergeOutput.FcaId IS NOT NULL
	AND MergeOutput.MatrixOutletId IS NOT NULL
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
