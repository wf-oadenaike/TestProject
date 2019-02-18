CREATE PROCEDURE [Compliance].[usp_MergeGiftEntertainmentExpenses]
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Compliance].[usp_MergeGiftEntertainmentExpenses]
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			27/11/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on;
	SET DATEFORMAT dmy;

	BEGIN TRANSACTION

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Compliance].[usp_MergeGiftEntertainmentExpenses]';

	SET DateFormat dmy;

	MERGE INTO [Compliance].[GiftEntertainmentExpenses] tar
	USING (
			SELECT 
			      exp.[Name] as [ExpenseReference]
	            , exp.[CurrencyIsoCode] as [CurrencyCode]
				, exp.[Amount] as [ExpenseAmount]
				, exp.[Category] as [ExpenseCategory]
				, exp.[Date_Incurred] as [ExpenseIncurredDate]
				, exp.[Description] as [Description]
				, exp.[Given_Received] as [GivenOrReceived]
				, exp.[Gift_Entertainment2] as [GiftOrEntertainment]
				, CASE WHEN exp.[Approved] = 'true' THEN 1
			    	ELSE 0
				  END AS [ExpenseApproved]
				, ap.[PersonId] as [ApprovedByPersonId]
				, exp.[Compliance_Comments] as [ComplianceComments]
				, CASE WHEN exp.[Created_by_ETL] = 'true' THEN 1
			    	ELSE 0
				  END AS CreatedByETL
				, CASE WHEN exp.[Current_Year] = 'true' THEN 1
			    	ELSE 0
				  END AS InCurrentYear
				, CASE WHEN exp.[Reportable] = 'true' THEN 1
			    	ELSE 0
				  END AS ExpenseReportable
				, relp.[PersonId] as [RelatesToPersonId]
				, exp.[LastName] as [LastName]
				, exp.[FirstName] as [FirstName]
				, exp.[Title] as [Title]
				, exp.[Salutation] as [Salutation]
				, exp.[Account_Name_Lookthrough] as [AccountName]
				, aop.[PersonId] as [AccountOwnerPersonId]
				, crp.[PersonId] as [CreatedByPersonId]
				, exp.[CreatedDate] as [ExpenseCreationDate]
				, exp.[LastModifiedDate] as [ExpenseModifiedDate]			
		FROM [Staging.Salesforce].[ExpenseSrc] exp
		LEFT OUTER JOIN [Core].[Persons] ap
		ON exp.[Approved_By] = ap.[FullEmployeeBK]
		LEFT OUTER JOIN [Core].[Persons] relp
		ON exp.[Expense_Relates_To] = relp.[FullEmployeeBK]
		LEFT OUTER JOIN [Core].[Persons] aop
		ON exp.[OwnerId] = aop.[FullEmployeeBK]
		LEFT OUTER JOIN [Core].[Persons] crp
		ON exp.[CreatedById] = crp.[FullEmployeeBK]
		) Src
	ON tar.ExpenseReference = Src.ExpenseReference
	WHEN NOT MATCHED
		THEN INSERT ([ExpenseReference],[CurrencyCode],[ExpenseAmount],[ExpenseCategory]
		,[ExpenseIncurredDate]
		,[Description],[GivenOrReceived],[GiftOrEntertainment],[ExpenseApproved],[ApprovedByPersonId],[ComplianceComments],[CreatedByETL],[InCurrentYear],[ExpenseReportable],[RelatesToPersonId],[LastName],[FirstName],[Title],[Salutation],[AccountName],[AccountOwnerPersonId],[CreatedByPersonId],[ExpenseCreationDate],[ExpenseModifiedDate])
             VALUES (Src.[ExpenseReference],Src.[CurrencyCode],Src.[ExpenseAmount],Src.[ExpenseCategory]
			 ,Src.[ExpenseIncurredDate]
			 ,Src.[Description],Src.[GivenOrReceived],Src.[GiftOrEntertainment],Src.[ExpenseApproved],Src.[ApprovedByPersonId],Src.[ComplianceComments],Src.[CreatedByETL],Src.[InCurrentYear],Src.[ExpenseReportable],Src.[RelatesToPersonId],Src.[LastName],Src.[FirstName],Src.[Title],Src.[Salutation],Src.[AccountName],Src.[AccountOwnerPersonId],Src.[CreatedByPersonId],Src.[ExpenseCreationDate],Src.[ExpenseModifiedDate])
			 WHEN MATCHED AND (tar.CurrencyCode <> Src.CurrencyCode
			OR tar.ExpenseAmount <> Src.ExpenseAmount
			OR tar.ExpenseCategory <> Src.ExpenseCategory
			OR tar.ExpenseIncurredDate <> Src.ExpenseIncurredDate
			OR tar.Description <> Src.Description
			OR tar.GivenOrReceived <> Src.GivenOrReceived
			OR tar.GiftOrEntertainment <> Src.GiftOrEntertainment
 			OR tar.ExpenseApproved <> Src.ExpenseApproved
			OR tar.ApprovedByPersonId <> Src.ApprovedByPersonId
			OR tar.ComplianceComments <> Src.ComplianceComments
			OR tar.CreatedByETL <> Src.CreatedByETL
			OR tar.InCurrentYear <> Src.InCurrentYear
			OR tar.ExpenseReportable <> Src.ExpenseReportable
			OR tar.RelatesToPersonId <> Src.RelatesToPersonId
			OR tar.LastName <> Src.LastName
			OR tar.FirstName <> Src.FirstName
			OR tar.Title <> Src.Title
			OR tar.Salutation <> Src.Salutation
			OR tar.AccountName <> Src.AccountName
			OR tar.AccountOwnerPersonId <> Src.AccountOwnerPersonId
			OR tar.CreatedByPersonId <> Src.CreatedByPersonId
			OR tar.ExpenseCreationDate <> Src.ExpenseCreationDate
			OR tar.ExpenseModifiedDate <> Src.ExpenseModifiedDate)
			THEN UPDATE SET tar.CurrencyCode = Src.CurrencyCode
					, tar.ExpenseAmount = Src.ExpenseAmount
		        	, tar.ExpenseCategory = Src.ExpenseCategory
			        , tar.ExpenseIncurredDate = Src.ExpenseIncurredDate
			        , tar.Description = Src.Description
			        , tar.GivenOrReceived = Src.GivenOrReceived
			        , tar.GiftOrEntertainment = Src.GiftOrEntertainment
 			        , tar.ExpenseApproved = Src.ExpenseApproved
			        , tar.ApprovedByPersonId = Src.ApprovedByPersonId
			        , tar.ComplianceComments = Src.ComplianceComments
			        , tar.CreatedByETL = Src.CreatedByETL
			        , tar.InCurrentYear = Src.InCurrentYear
			        , tar.ExpenseReportable = Src.ExpenseReportable
			        , tar.RelatesToPersonId = Src.RelatesToPersonId
			        , tar.LastName = Src.LastName
			        , tar.FirstName = Src.FirstName
			        , tar.Title = Src.Title
					, tar.Salutation = Src.Salutation
			        , tar.AccountName = Src.AccountName
			        , tar.AccountOwnerPersonId = Src.AccountOwnerPersonId
			        , tar.CreatedByPersonId = Src.CreatedByPersonId
			        , tar.ExpenseCreationDate = Src.ExpenseCreationDate
			        , tar.ExpenseModifiedDate = Src.ExpenseModifiedDate
	;

	SET @InsertRowCount = @@ROWCOUNT;

	SELECT @ProcessRowCount AS ProcessRowCount
		, @InsertRowCount AS InsertRowCount
		, @UpdateRowCount AS UpdateRowCount
		, @DeleteRowCount AS DeleteRowCount
		;

	COMMIT;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
		ROLLBACK;
		 
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
