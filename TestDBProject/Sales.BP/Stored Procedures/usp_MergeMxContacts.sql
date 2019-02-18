CREATE PROCEDURE [Sales.BP].[usp_MergeMxContacts]
AS
-------------------------------------------------------------------------------------- 
-- Name:			Sales.BP.usp_MergeSfContacts
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Sales.BP].[usp_MergeMxContacts]';

	Declare @CurrDate datetime = GETDATE();
	Declare @EndDate datetime = '2099-12-31T00:00:00.000';
	Declare @ModifiedBy varchar(50) = 'Boomi Matrix data load';

	INSERT INTO [Sales.BP].[MxContact]
	( 	[SfContactId],
		[SfAccountId],
		[LastName],
		[FirstName],
		[Salutation],
		[JobTitle],
		[FcaId],
		[AccountFcaId],
		[ContactOwnerId],
		[ContactOwnerName],
		[AccountSivId],
		[ContactSivId],
		[ContactMatrixId],
		[MailingStreet],
		[MailingCity],
		[MailingState],
		[MailingPostcode],
		[MailingCountry],
		[Phone],
		[Mobile],
		[Fax],
		[EmailAddress],
		[IsCf1],
		[IsCf2],
		[IsCf3],
		[IsCf4],
		[IsCf10],
		[IsCf11],
		[IsCf30],
		[VerifiedBy],
	    [IsExistingCompanyRelationship],
		[ModifiedBy],
		[IsActive],
		[StartDatetime],
		[EndDatetime]
	)
	SELECT
		 SfContactId
		,SfAccountId
		,LastName
		,FirstName
		,Salutation
		,JobTitle
		,FcaId
		,AccountFcaId
		,ContactOwnerId
		,ContactOwnerName
		,AccountSivId
		,ContactSivId
		,ContactMatrixId
		,MailingStreet
		,MailingCity
		,MailingState
		,MailingPostcode
		,MailingCountry
		,Phone
		,Mobile
		,Fax
		,EmailAddress
		,IsCf1
		,IsCf2
		,IsCf3
		,IsCf4
		,IsCf10
		,IsCf11
		,IsCf30
		,VerifiedBy
	    ,IsExistingCompanyRelationship
		,@ModifiedBy
		,1            --IsActive
		,@CurrDate    --ValidFrom
		,@EndDate     --ValidTo
	FROM (
		MERGE INTO [Sales.BP].[MxContact] Tar
		USING (SELECT [CntSalesforceId] as SfContactId
					 ,[CntAccountSalesforceId] as SfAccountId
					 ,[CntFcaId] as FcaId
					 ,[CntAccountFcaId] as AccountFcaId
					 ,[CntOwnerId] as ContactOwnerId
					 ,[CntOwnerName] as ContactOwnerName
					 ,[CntAccountSivId] as AccountSivId
					 ,[CntSivId] as ContactSivId
					 ,[CntMatrixId] as ContactMatrixId
					 ,[CntSalutation] as Salutation
					 ,[CntFirstName] as FirstName
					 ,[CntLastName] as LastName
					 ,[CntJobTitle] as JobTitle
					 ,[CntMailingStreet] as MailingStreet
					 ,[CntMailingCity] as MailingCity
					 ,[CntMailingState] as MailingState
					 ,[CntMailingPostcode] as MailingPostcode
					 ,[CntMailingCountry] as MailingCountry
					 ,[CntLandline] as Phone
					 ,[CntMobile] as Mobile
					 ,[CntFax] as Fax
					 ,[CntEmail] as EmailAddress
					 ,CASE [CntIsCf1] WHEN 'Y' THEN 1 ELSE 0 END as IsCf1
					 ,CASE [CntIsCf2] WHEN 'Y' THEN 1 ELSE 0 END as IsCf2
					 ,CASE [CntIsCf3] WHEN 'Y' THEN 1 ELSE 0 END as IsCf3
					 ,CASE [CntIsCf4] WHEN 'Y' THEN 1 ELSE 0 END as IsCf4
					 ,CASE [CntIsCf10] WHEN 'Y' THEN 1 ELSE 0 END as IsCf10
					 ,CASE [CntIsCf11] WHEN 'Y' THEN 1 ELSE 0 END as IsCf11
					 ,CASE [CntIsCf30] WHEN 'Y' THEN 1 ELSE 0 END as IsCf30
					,[CntVerifiedBy] as VerifiedBy
					,CASE [CntExistingCompanyRelationship] WHEN 'Y' THEN 1 ELSE 0 END as IsExistingCompanyRelationship
					 ,1 as IsActive
				FROM (SELECT [CntSalesforceId]
				        	,[CntAccountSalesforceId]
					        ,[CntFcaId]
					        ,[CntAccountFcaId]
					        ,[CntOwnerId]
					        ,[CntOwnerName]
					        ,[CntAccountSivId]
					        ,[CntSivId]
					        ,[CntMatrixId]
					        ,[CntSalutation]
					        ,[CntFirstName]
					        ,[CntLastName]
					        ,[CntJobTitle]
					        ,[CntMailingStreet]
					        ,[CntMailingCity]
					        ,[CntMailingState]
					        ,[CntMailingPostcode]
					        ,[CntMailingCountry]
					        ,[CntLandline]
					        ,[CntMobile]
					        ,[CntFax]
					        ,[CntEmail]
					        ,[CntIsCf1]
					        ,[CntIsCf2]
					        ,[CntIsCf3]
					        ,[CntIsCf4]
					        ,[CntIsCf10]
					        ,[CntIsCf11]
					        ,[CntIsCf30]
					        ,[CntVerifiedBy]
					        ,[CntExistingCompanyRelationship]	
					        ,row_number() over
                           (
                             partition by    [CntFcaId]
	                                        ,[CntAccountFcaId]
                             order by        [CntSalesforceId] desc
                           ) CntfcaId_rank
                        FROM    [Staging.Salesforce.BP].[MxContactRaw]
                        WHERE [CntFcaId] IS NOT NULL
                        AND [CntAccountFcaId] IS NOT NULL) c
				    WHERE c.CntfcaId_rank = 1

			) as Src
		ON ( Tar.FcaId = Src.FcaId
		AND Tar.AccountFcaId = Src.AccountFcaId
		AND Tar.IsActive = Src.IsActive ) -- merge on active Contacts
		WHEN NOT MATCHED BY TARGET
			THEN INSERT ([SfContactId],
						[SfAccountId],
						[LastName],
						[FirstName],
						[Salutation],
						[JobTitle],
						[FcaId],
						[AccountFcaId],
						[ContactOwnerId],
						[ContactOwnerName],
						[AccountSivId],
						[ContactSivId],
						[ContactMatrixId],
						[MailingStreet],
						[MailingCity],
						[MailingState],
						[MailingPostcode],
						[MailingCountry],
						[Phone],
						[Mobile],
						[Fax],
						[EmailAddress],
						[IsCf1],
						[IsCf2],
						[IsCf3],
						[IsCf4],
						[IsCf10],
						[IsCf11],
						[IsCf30],
						[VerifiedBy],
						[IsExistingCompanyRelationship],						
						[ModifiedBy],
						[IsActive],
						[StartDatetime],
						[EndDatetime]
						)
              VALUES (
					 SfContactId
					,SfAccountId
					,LastName
					,FirstName
					,Salutation
					,JobTitle
					,FcaId
					,AccountFcaId
					,ContactOwnerId
					,ContactOwnerName					
					,AccountSivId
					,ContactSivId
					,ContactMatrixId
					,MailingStreet
					,MailingCity
					,MailingState
					,MailingPostcode
					,MailingCountry
					,Phone
					,Mobile
					,Fax
					,EmailAddress
					,IsCf1
					,IsCf2
					,IsCf3
					,IsCf4
					,IsCf10
					,IsCf11
					,IsCf30
					,VerifiedBy
					,IsExistingCompanyRelationship
                    ,@ModifiedBy
                    ,1            --IsActive
                    ,@CurrDate    --ValidFrom
                    ,@EndDate     --ValidTo
					 )
		WHEN MATCHED
			AND ( Tar.SfAccountId <> Src.SfAccountId
			OR (Tar.SfAccountId IS NULL AND Src.SfAccountId IS NOT NULL)
			OR (Tar.SfAccountId IS NOT NULL AND Src.SfAccountId IS NULL)
			OR Tar.LastName <> Src.LastName
			OR (Tar.LastName IS NULL AND Src.LastName IS NOT NULL)
			OR (Tar.LastName IS NOT NULL AND Src.LastName IS NULL)
			OR Tar.FirstName <> Src.FirstName
			OR (Tar.FirstName IS NULL AND Src.FirstName IS NOT NULL)
			OR (Tar.FirstName IS NOT NULL AND Src.FirstName IS NULL)
			OR Tar.Salutation <> Src.Salutation
			OR (Tar.Salutation IS NULL AND Src.Salutation IS NOT NULL)
			OR (Tar.Salutation IS NOT NULL AND Src.Salutation IS NULL)
			OR Tar.JobTitle <> Src.JobTitle
			OR (Tar.JobTitle IS NULL AND Src.JobTitle IS NOT NULL)
			OR (Tar.JobTitle IS NOT NULL AND Src.JobTitle IS NULL)			
			OR Tar.ContactOwnerId <> Src.ContactOwnerId
			OR (Tar.ContactOwnerId IS NULL AND Src.ContactOwnerId IS NOT NULL)
			OR (Tar.ContactOwnerId IS NOT NULL AND Src.ContactOwnerId IS NULL)				
			OR Tar.ContactOwnerName <> Src.ContactOwnerName
			OR (Tar.ContactOwnerName IS NULL AND Src.ContactOwnerName IS NOT NULL)
			OR (Tar.ContactOwnerName IS NOT NULL AND Src.ContactOwnerName IS NULL)	
			OR Tar.AccountSivId <> Src.AccountSivId
			OR (Tar.AccountSivId IS NULL AND Src.AccountSivId IS NOT NULL)
			OR (Tar.AccountSivId IS NOT NULL AND Src.AccountSivId IS NULL)
			OR Tar.ContactSivId <> Src.ContactSivId
			OR (Tar.ContactSivId IS NULL AND Src.ContactSivId IS NOT NULL)
			OR (Tar.ContactSivId IS NOT NULL AND Src.ContactSivId IS NULL)
			OR Tar.ContactMatrixId <> Src.ContactMatrixId
			OR (Tar.ContactMatrixId IS NULL AND Src.ContactMatrixId IS NOT NULL)
			OR (Tar.ContactMatrixId IS NOT NULL AND Src.ContactMatrixId IS NULL)
			OR Tar.MailingStreet <> Src.MailingStreet
			OR (Tar.MailingStreet IS NULL AND Src.MailingStreet IS NOT NULL)
			OR (Tar.MailingStreet IS NOT NULL AND Src.MailingStreet IS NULL)
			OR Tar.MailingCity <> Src.MailingCity
			OR (Tar.MailingCity IS NULL AND Src.MailingCity IS NOT NULL)
			OR (Tar.MailingCity IS NOT NULL AND Src.MailingCity IS NULL)
			OR Tar.MailingState <> Src.MailingState
			OR (Tar.MailingState IS NULL AND Src.MailingState IS NOT NULL)
			OR (Tar.MailingState IS NOT NULL AND Src.MailingState IS NULL)
			OR Tar.MailingPostcode <> Src.MailingPostcode
			OR (Tar.MailingPostcode IS NULL AND Src.MailingPostcode IS NOT NULL)
			OR (Tar.MailingPostcode IS NOT NULL AND Src.MailingPostcode IS NULL)
			OR Tar.MailingCountry <> Src.MailingCountry
			OR (Tar.MailingCountry IS NULL AND Src.MailingCountry IS NOT NULL)
			OR (Tar.MailingCountry IS NOT NULL AND Src.MailingCountry IS NULL)			
			OR Tar.Phone <> Src.Phone
			OR (Tar.Phone IS NULL AND Src.Phone IS NOT NULL)
			OR (Tar.Phone IS NOT NULL AND Src.Phone IS NULL)
			OR Tar.Mobile <> Src.Mobile
			OR (Tar.Mobile IS NULL AND Src.Mobile IS NOT NULL)
			OR (Tar.Mobile IS NOT NULL AND Src.Mobile IS NULL)			
			OR Tar.Fax <> Src.Fax
			OR (Tar.Fax IS NULL AND Src.Fax IS NOT NULL)
			OR (Tar.Fax IS NOT NULL AND Src.Fax IS NULL)
			OR Tar.EmailAddress <> Src.EmailAddress
			OR (Tar.EmailAddress IS NULL AND Src.EmailAddress IS NOT NULL)
			OR (Tar.EmailAddress IS NOT NULL AND Src.EmailAddress IS NULL)
			OR Tar.IsCf1 <> Src.IsCf1
			OR (Tar.IsCf1 IS NULL AND Src.IsCf1 IS NOT NULL)
			OR (Tar.IsCf1 IS NOT NULL AND Src.IsCf1 IS NULL)
			OR Tar.IsCf2 <> Src.IsCf2
			OR (Tar.IsCf2 IS NULL AND Src.IsCf2 IS NOT NULL)
			OR (Tar.IsCf2 IS NOT NULL AND Src.IsCf2 IS NULL)
			OR Tar.IsCf3 <> Src.IsCf3
			OR (Tar.IsCf3 IS NULL AND Src.IsCf3 IS NOT NULL)
			OR (Tar.IsCf3 IS NOT NULL AND Src.IsCf3 IS NULL)
			OR Tar.IsCf4 <> Src.IsCf4
			OR (Tar.IsCf4 IS NULL AND Src.IsCf4 IS NOT NULL)
			OR (Tar.IsCf4 IS NOT NULL AND Src.IsCf4 IS NULL)
			OR Tar.IsCf10 <> Src.IsCf10
			OR (Tar.IsCf10 IS NULL AND Src.IsCf10 IS NOT NULL)
			OR (Tar.IsCf10 IS NOT NULL AND Src.IsCf10 IS NULL)
			OR Tar.IsCf11 <> Src.IsCf11
			OR (Tar.IsCf11 IS NULL AND Src.IsCf11 IS NOT NULL)
			OR (Tar.IsCf11 IS NOT NULL AND Src.IsCf11 IS NULL)
			OR Tar.IsCf30 <> Src.IsCf30
			OR (Tar.IsCf30 IS NULL AND Src.IsCf30 IS NOT NULL)
			OR (Tar.IsCf30 IS NOT NULL AND Src.IsCf30 IS NULL)
			OR Tar.VerifiedBy <> Src.VerifiedBy
			OR (Tar.VerifiedBy IS NULL AND Src.VerifiedBy IS NOT NULL)
			OR (Tar.VerifiedBy IS NOT NULL AND Src.VerifiedBy IS NULL)
			OR Tar.IsExistingCompanyRelationship <> Src.IsExistingCompanyRelationship
			OR (Tar.IsExistingCompanyRelationship IS NULL AND Src.IsExistingCompanyRelationship IS NOT NULL)
			OR (Tar.IsExistingCompanyRelationship IS NOT NULL AND Src.IsExistingCompanyRelationship IS NULL)			
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
	AND MergeOutput.AccountFcaId IS NOT NULL
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
