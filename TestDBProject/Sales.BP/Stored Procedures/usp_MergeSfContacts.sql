
CREATE PROCEDURE [Sales.BP].[usp_MergeSfContacts]
as
--------------------------------------------------------------------------------------
-- Name:            Sales.BP.usp_MergeSfContacts
--
-- Note:
--
-- Author:          R Carter
-- Date:            05/09/2016
--------------------------------------------------------------------------------------
-- History:         Initial Write
--
--2017-09-15 Josef Tapper
-- Added Top 1 over partition to handle re-registraction for FCA
-- added fix for Rubbish phone data 
--------------------------------------------------------------------------------------

Begin Try

    Set NoCount on

    Declare @ProcessRowCount Bigint = 0
        , @InsertRowCount bigint = 0
        , @UpdateRowCount bigint = 0
        , @DeleteRowCount bigint = 0
        ;
    Declare @strProcedureName       VARCHAR(100)    = '[Sales.BP].[usp_MergeSfContacts]';

    Declare @CurrDate datetime = GETDATE();
    Declare @EndDate datetime = '2099-12-31T00:00:00.000';
    Declare @ModifiedBy varchar(50) = 'Boomi Salesforce data load';

    INSERT INTO [Sales.BP].[SfContact]
    (   [SfContactId],
        [SfAccountId],
        [LastName],
        [FirstName],
        [Salutation],
        [JobTitle],
        [FcaId],
        [AccountFcaId],
        [ContactOwnerId],
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
        ,@ModifiedBy
        ,1            --IsActive
        ,@CurrDate    --ValidFrom
        ,@EndDate     --ValidTo
    FROM (
        MERGE INTO [Sales.BP].[SfContact] Tar
        USING (SELECT TOP 1 with ties  [CntSalesforceId] as SfContactId
                     ,[CntAccountSalesforceId] as SfAccountId
                     ,[CntFcaId] as FcaId
                     ,[CntAccountFcaId] as AccountFcaId
                     ,[CntOwnerId] as ContactOwnerId
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
                     , case when 
					 isnumeric(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(
					 coalesce([CntLandline],'1') 
					 ,CHAR(43),'') ,CHAR(41),'') ,CHAR(40),'') ,CHAR(32),''),CHAR(0),''),CHAR(9),''),CHAR(10),''),CHAR(11),''),CHAR(12),''),CHAR(13),''),CHAR(14),''),CHAR(160),''))
					 =0 then NULL else [CntLandline] end  as Phone
					 , case when 
					 isnumeric(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(
					 coalesce([CntMobile],'1') 
					 ,CHAR(43),'') ,CHAR(41),'') ,CHAR(40),'') ,CHAR(32),''),CHAR(0),''),CHAR(9),''),CHAR(10),''),CHAR(11),''),CHAR(12),''),CHAR(13),''),CHAR(14),''),CHAR(160),''))
					 =0 then NULL else [CntMobile] end  as Mobile
					 , case when 
					 isnumeric(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(
					 coalesce([CntFax],'1') 
					 ,CHAR(43),'') ,CHAR(41),'') ,CHAR(40),'') ,CHAR(32),''),CHAR(0),''),CHAR(9),''),CHAR(10),''),CHAR(11),''),CHAR(12),''),CHAR(13),''),CHAR(14),''),CHAR(160),''))
					 =0 then NULL else [CntFax] end  as Fax
					 ,[CntEmail] as EmailAddress
                     ,CASE [CntIsCf1] WHEN 'Y' THEN 1 ELSE 0 END as IsCf1
                     ,CASE [CntIsCf2] WHEN 'Y' THEN 1 ELSE 0 END as IsCf2
                     ,CASE [CntIsCf3] WHEN 'Y' THEN 1 ELSE 0 END as IsCf3
                     ,CASE [CntIsCf4] WHEN 'Y' THEN 1 ELSE 0 END as IsCf4
                     ,CASE [CntIsCf10] WHEN 'Y' THEN 1 ELSE 0 END as IsCf10
                     ,CASE [CntIsCf11] WHEN 'Y' THEN 1 ELSE 0 END as IsCf11
                     ,CASE [CntIsCf30] WHEN 'Y' THEN 1 ELSE 0 END as IsCf30
                     ,1 as IsActive
                FROM [Staging.Salesforce.BP].[SfContactRaw] a
				ORDER BY
    ROW_NUMBER() OVER(PARTITION BY [CntFcaId] ORDER BY [CntSalesforceId] DESC)
            ) as Src
        ON ( Tar.SfContactId = Src.SfContactId
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
                    ,@ModifiedBy
                    ,1            --IsActive
                    ,@CurrDate    --ValidFrom
                    ,@EndDate     --ValidTo
                     )
        WHEN MATCHED
            AND ( coalesce(Tar.SfAccountId,'') <> coalesce(Src.SfAccountId,'') 
           -- OR (Tar.SfAccountId IS NULL AND Src.SfAccountId IS NOT NULL)
           -- OR (Tar.SfAccountId IS NOT NULL AND Src.SfAccountId IS NULL)
            OR coalesce(Tar.LastName,'') <> coalesce(Src.LastName,'')
           -- OR (Tar.LastName IS NULL AND Src.LastName IS NOT NULL)
           -- OR (Tar.LastName IS NOT NULL AND Src.LastName IS NULL)
            OR coalesce(Tar.FirstName,'') <> coalesce(Src.FirstName,'')
           -- OR (Tar.FirstName IS NULL AND Src.FirstName IS NOT NULL)
           -- OR (Tar.FirstName IS NOT NULL AND Src.FirstName IS NULL)
            OR coalesce(Tar.Salutation,'') <> coalesce(Src.Salutation,'')
           -- OR (Tar.Salutation IS NULL AND Src.Salutation IS NOT NULL)
           -- OR (Tar.Salutation IS NOT NULL AND Src.Salutation IS NULL)
            OR coalesce(Tar.JobTitle,'') <> coalesce(Src.JobTitle,'')
           -- OR (Tar.JobTitle IS NULL AND Src.JobTitle IS NOT NULL)
           -- OR (Tar.JobTitle IS NOT NULL AND Src.JobTitle IS NULL)
            OR coalesce(Tar.FcaId,'') <> coalesce(Src.FcaId,'')
           -- OR (Tar.FcaId IS NULL AND Src.FcaId IS NOT NULL)
           -- OR (Tar.FcaId IS NOT NULL AND Src.FcaId IS NULL)
            OR coalesce(Tar.AccountFcaId,'') <> coalesce(Src.AccountFcaId,'')
           -- OR (Tar.AccountFcaId IS NULL AND Src.AccountFcaId IS NOT NULL)
           -- OR (Tar.AccountFcaId IS NOT NULL AND Src.AccountFcaId IS NULL)
            OR coalesce(Tar.ContactOwnerId,'') <> coalesce(Src.ContactOwnerId,'')
           -- OR (Tar.ContactOwnerId IS NULL AND Src.ContactOwnerId IS NOT NULL)
           -- OR (Tar.ContactOwnerId IS NOT NULL AND Src.ContactOwnerId IS NULL)
            OR coalesce(Tar.AccountSivId,'') <> coalesce(Src.AccountSivId,'')
           -- OR (Tar.AccountSivId IS NULL AND Src.AccountSivId IS NOT NULL)
           -- OR (Tar.AccountSivId IS NOT NULL AND Src.AccountSivId IS NULL)
            OR coalesce(Tar.ContactSivId,'') <> coalesce(Src.ContactSivId,'')
           -- OR (Tar.ContactSivId IS NULL AND Src.ContactSivId IS NOT NULL)
           -- OR (Tar.ContactSivId IS NOT NULL AND Src.ContactSivId IS NULL)
            OR coalesce(Tar.ContactMatrixId,'') <> coalesce(Src.ContactMatrixId,'')
           -- OR (Tar.ContactMatrixId IS NULL AND Src.ContactMatrixId IS NOT NULL)
           --OR (Tar.ContactMatrixId IS NOT NULL AND Src.ContactMatrixId IS NULL)
            OR coalesce(Tar.MailingStreet,'') <> coalesce(Src.MailingStreet,'')
           -- OR (Tar.MailingStreet IS NULL AND Src.MailingStreet IS NOT NULL)
           -- OR (Tar.MailingStreet IS NOT NULL AND Src.MailingStreet IS NULL)
            OR coalesce(Tar.MailingCity,'') <> coalesce(Src.MailingCity,'')
           -- OR (Tar.MailingCity IS NULL AND Src.MailingCity IS NOT NULL)
           -- OR (Tar.MailingCity IS NOT NULL AND Src.MailingCity IS NULL)
            OR coalesce(Tar.MailingState,'') <> coalesce(Src.MailingState,'')
           -- OR (Tar.MailingState IS NULL AND Src.MailingState IS NOT NULL)
           -- OR (Tar.MailingState IS NOT NULL AND Src.MailingState IS NULL)
            OR coalesce(Tar.MailingPostcode,'') <> coalesce(Src.MailingPostcode,'')
           -- OR (Tar.MailingPostcode IS NULL AND Src.MailingPostcode IS NOT NULL)
           -- OR (Tar.MailingPostcode IS NOT NULL AND Src.MailingPostcode IS NULL)
            OR coalesce(Tar.MailingCountry,'') <> coalesce(Src.MailingCountry,'')
           -- OR (Tar.MailingCountry IS NULL AND Src.MailingCountry IS NOT NULL)
           -- OR (Tar.MailingCountry IS NOT NULL AND Src.MailingCountry IS NULL)
            OR coalesce(Tar.Phone,'') <> coalesce(Src.Phone,'')
           -- OR (Tar.Phone IS NULL AND Src.Phone IS NOT NULL)
           -- OR (Tar.Phone IS NOT NULL AND Src.Phone IS NULL)
            OR coalesce(Tar.Mobile,'') <> coalesce(Src.Mobile,'')
           -- OR (Tar.Mobile IS NULL AND Src.Mobile IS NOT NULL)
           -- OR (Tar.Mobile IS NOT NULL AND Src.Mobile IS NULL)
            OR coalesce(Tar.Fax,'') <> coalesce(Src.Fax,'')
           -- OR (Tar.Fax IS NULL AND Src.Fax IS NOT NULL)
           -- OR (Tar.Fax IS NOT NULL AND Src.Fax IS NULL)
            OR coalesce(Tar.EmailAddress,'') <> coalesce(Src.EmailAddress,'')
           --  OR (Tar.EmailAddress IS NULL AND Src.EmailAddress IS NOT NULL)
           -- OR (Tar.EmailAddress IS NOT NULL AND Src.EmailAddress IS NULL)
            OR coalesce(Tar.IsCf1,'') <> coalesce(Src.IsCf1,'')
           -- OR (Tar.IsCf1 IS NULL AND Src.IsCf1 IS NOT NULL)
           -- OR (Tar.IsCf1 IS NOT NULL AND Src.IsCf1 IS NULL)
            OR coalesce(Tar.IsCf2,'') <> coalesce(Src.IsCf2,'')
           -- OR (Tar.IsCf2 IS NULL AND Src.IsCf2 IS NOT NULL)
           -- OR (Tar.IsCf2 IS NOT NULL AND Src.IsCf2 IS NULL)
            OR coalesce(Tar.IsCf3,'') <> coalesce(Src.IsCf3,'')
           -- OR (Tar.IsCf3 IS NULL AND Src.IsCf3 IS NOT NULL)
           -- OR (Tar.IsCf3 IS NOT NULL AND Src.IsCf3 IS NULL)
            OR coalesce(Tar.IsCf4,'') <> coalesce(Src.IsCf4,'')
           -- OR (Tar.IsCf4 IS NULL AND Src.IsCf4 IS NOT NULL)
           -- OR (Tar.IsCf4 IS NOT NULL AND Src.IsCf4 IS NULL)
            OR coalesce(Tar.IsCf10,'') <> coalesce(Src.IsCf10,'')
           -- OR (Tar.IsCf10 IS NULL AND Src.IsCf10 IS NOT NULL)
           -- OR (Tar.IsCf10 IS NOT NULL AND Src.IsCf10 IS NULL)
            OR coalesce(Tar.IsCf11,'') <> coalesce(Src.IsCf11,'')
           -- OR (Tar.IsCf11 IS NULL AND Src.IsCf11 IS NOT NULL)
           -- OR (Tar.IsCf11 IS NOT NULL AND Src.IsCf11 IS NULL)
            OR coalesce(Tar.IsCf30,'') <> coalesce(Src.IsCf30,'')
           -- OR (Tar.IsCf30 IS NULL AND Src.IsCf30 IS NOT NULL)
           -- OR (Tar.IsCf30 IS NOT NULL AND Src.IsCf30 IS NULL)
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
    AND MergeOutput.SfContactId IS NOT NULL
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
        Declare   @ErrorMessage     NVARCHAR(4000)
                , @ErrorSeverity    INT
                , @ErrorState       INT
                , @ErrorNumber      INT
                ;

        Select    @ErrorNumber      = ERROR_NUMBER()
                , @ErrorMessage     = @strProcedureName + ' - ' + ERROR_MESSAGE()
                , @ErrorSeverity    = ERROR_SEVERITY()
                , @ErrorState       = ERROR_STATE();

        RaisError (
                  @ErrorMessage     -- Message text.
                , @ErrorSeverity    -- Severity.
                , @ErrorState       -- State.
              );
        Return @ErrorNumber;
END CATCH

