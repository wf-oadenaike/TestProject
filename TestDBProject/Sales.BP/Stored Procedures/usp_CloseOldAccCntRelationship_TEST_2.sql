--set nocount on
--drop procedure [Sales.BP].usp_CloseOldAccCntRelationship_TEST_2
--go

create procedure [Sales.BP].usp_CloseOldAccCntRelationship_TEST_2 as
begin

    -- John Smith has moved from ack fin to ayton
    -- AND
    -- has changed his salutation

    -- CLEARDOWN --

    declare     @n int
    declare     @YYYYMMDD_hhmm varchar(99)
    select      @YYYYMMDD_hhmm = convert ( char(16), getdate(), 121 )

    delete      [Sales.BP].WoodfordAccountContact
    where       ContactId in
                (
                    select      Id
                    from        [Sales.BP].WoodfordContact
                    where       CntFcaId in ( 'JTS00002', 'CXJ00027' )
                )
    delete      [Sales.BP].WoodfordAccountContact
    where       AccountId in
                (
                    select      Id
                    from        [Sales.BP].WoodfordAccount
                    where       AccName in ( 'Acklam Financial Ltd', 'Ayton-Law Ltd' )
                )
    delete      [Sales.BP].WoodfordAccountAddress
    where       AccountId in
                (
                    select      Id
                    from        [Sales.BP].WoodfordAccount
                    where       AccName in ( 'Acklam Financial Ltd', 'Ayton-Law Ltd' )
                )
    delete      [Sales.BP].WoodfordAccount               where       AccName  in ( 'Acklam Financial Ltd', 'Ayton-Law Ltd' )
    delete      [Staging.Salesforce.BP].ContactMerge     where       CntFcaId in ( 'JTS00002' )
    delete      [Sales.BP].WoodfordContact               where       CntFcaId in ( 'JTS00002' )

    -- SETUP WOODFORDACCOUNT --

    INSERT [Sales.BP].WoodfordAccount -- Ack Fin
    (
        [AccSalesforceId],
        [AccName],
        [AccMatrixOutletId],
        [AccSivId],
        [AccParentSivId],
        [AccFcaId],
        [AccPostcode],
        [AccLandline],
        [AccFax],
        [AccWebsite],
        [AccFirmSegment],
        [AccAuthStatus],
        [AccPlatformsUsed],
        [AccOutletType],
        [AccVerifiedBy],
        [AccIsExistingRel],
        [AccIsPriorityClient],
        [AccOwnerId],
        [AccOwnerName],
        [WoodfordLastUpdate],
        [MatrixLastUpdate],
        [StartDateTime],
        [EndDateTime],
        [IsActive],
        [AccCalculatedPriority],
        [AccIsKeyAccount],
        [RegionId]
    )
    VALUES
    (
        N'00120000017Kf2fAAC',                                               --     [AccSalesforceId],
        N'Acklam Financial Ltd',                                             -- *   [AccName],
        N'^RMIM',                                                            --     [AccMatrixOutletId],
        N'acc6581#323031342D30332D3238',                                     --     [AccSivId],
        NULL,                                                                --     [AccParentSivId],
        223707,                                                              -- *   [AccFcaId],
        N'TS5 7BP',                                                          -- *   [AccPostcode],
        NULL,                                                                --     [AccLandline],
        NULL,                                                                --     [AccFax],
        N'www.acklamfinancial.co.uk',                                        --     [AccWebsite],
        N'Small Firm',                                                       --     [AccFirmSegment],
        N'Directly Authorised',                                              --     [AccAuthStatus],
        N'Aviva Wrap;Cofunds;FundsNetwork;Skandia Investment Solutions',     --     [AccPlatformsUsed],
        N'Head Office',                                                      --     [AccOutletType],
        NULL,                                                                --     [AccVerifiedBy],
        0,                                                                   --     [AccIsExistingRel],
        1,                                                                   --     [AccIsPriorityClient],
        N'00520000003S826AAC',                                               --     [AccOwnerId],
        N'Steve Baxter',                                                     --     [AccOwnerName],
        NULL,                                                                --     [WoodfordLastUpdate],
        NULL,                                                                --     [MatrixLastUpdate],
        CAST(N'2016-09-14 16:33:47.037' AS DateTime),                        --     [StartDateTime],
        CAST(N'2099-12-31 00:00:00.000' AS DateTime),                        --     [EndDateTime],
        1,                                                                   --     [IsActive],
        NULL,                                                                --     [AccCalculatedPriority],
        0,                                                                   --     [AccIsKeyAccount],
        NULL                                                                 --     [RegionId]
    );

    INSERT [Sales.BP].WoodfordAccount -- Ayton Law
    (
        [AccSalesforceId],
        [AccName],
        [AccMatrixOutletId],
        [AccSivId],
        [AccParentSivId],
        [AccFcaId],
        [AccPostcode],
        [AccLandline],
        [AccFax],
        [AccWebsite],
        [AccFirmSegment],
        [AccAuthStatus],
        [AccPlatformsUsed],
        [AccOutletType],
        [AccVerifiedBy],
        [AccIsExistingRel],
        [AccIsPriorityClient],
        [AccOwnerId],
        [AccOwnerName],
        [WoodfordLastUpdate],
        [MatrixLastUpdate],
        [StartDateTime],
        [EndDateTime],
        [IsActive],
        [AccCalculatedPriority],
        [AccIsKeyAccount],
        [RegionId]
    )
    VALUES
    (
        N'00120000017Kei6AAC',                             --     [AccSalesforceId],
        N'Ayton-Law Ltd',                                  -- *   [AccName],
        N'^CJGL',                                          --     [AccMatrixOutletId],
        N'acc5557#323031342D30332D3238',                   --     [AccSivId],
        NULL,                                              --     [AccParentSivId],
        191446,                                            -- *   [AccFcaId],
        N'TS5 5HR',                                        -- *   [AccPostcode],
        N'01642 659500',                                   --     [AccLandline],
        N'01642 659600',                                   --     [AccFax],
        NULL,                                              --     [AccWebsite],
        N'Small Firm',                                     --     [AccFirmSegment],
        N'Appointed Representative',                       --     [AccAuthStatus],
        N'FundsNetwork;Skandia Investment Solutions',      --     [AccPlatformsUsed],
        N'Head Office',                                    --     [AccOutletType],
        NULL,                                              --     [AccVerifiedBy],
        0,                                                 --     [AccIsExistingRel],
        0,                                                 --     [AccIsPriorityClient],
        N'00520000003S826AAC',                             --     [AccOwnerId],
        N'Steve Baxter',                                   --     [AccOwnerName],
        NULL,                                              --     [WoodfordLastUpdate],
        NULL,                                              --     [MatrixLastUpdate],
        CAST(N'2016-09-14 16:33:47.037' AS DateTime),      --     [StartDateTime],
        CAST(N'2099-12-31 00:00:00.000' AS DateTime),      --     [EndDateTime],
        1,                                                 --     [IsActive],
        NULL,                                              --     [AccCalculatedPriority],
        0,                                                 --     [AccIsKeyAccount],
        NULL                                               --     [RegionId]
    )

    -- SETUP CONTACTMERGE --

    INSERT [Staging.Salesforce.BP].ContactMerge
    (
        [CntSalesforceId],
        [CntAccountSalesforceId],
        [CntFcaId],
        [CntAccountFcaId],
        [CntOwnerId],
        [CntOwnerName],
        [CntAccountSivId],
        [CntSivId],
        [CntMatrixId],
        [CntSalutation],
        [CntFirstName],
        [CntLastName],
        [CntJobTitle],
        [CntMailingStreet],
        [CntMailingCity],
        [CntMailingState],
        [CntMailingPostcode],
        [CntMailingCountry],
        [CntLandline],
        [CntMobile],
        [CntFax],
        [CntEmail],
        [CntIsCf1],
        [CntIsCf2],
        [CntIsCf3],
        [CntIsCf4],
        [CntIsCf10],
        [CntIsCf11],
        [CntIsCf30],
        [CntVerifiedBy],
        [CntExistingCompanyRelationship]
    )
    VALUES
    (
        N'0032000001BtfuoAAB',                            --     [CntSalesforceId],
        N'00120000017Kf2fAAC',                            --     [CntAccountSalesforceId],
        N'JTS00002',                                      -- *   [CntFcaId],
        N'191446',                                        -- *   [CntAccountFcaId],    -- Ayton Law
        N'00520000003S826AAC',                            --     [CntOwnerId],
        N'Steve Baxter',                                  --     [CntOwnerName],
        N'acc6581#323031342D30332D3238',                  --     [CntAccountSivId],
        N'con16859#323031342D30332D3238',                 --     [CntSivId],
        N'$VPIE',                                         --     [CntMatrixId],
        N'Mr',                                            --     [CntSalutation],
        N'John',                                          --     [CntFirstName],
        N'Smith',                                         --     [CntLastName],
        N'Mr',                                            --     [CntJobTitle],
        N'261a Acklam Road',                              --     [CntMailingStreet],
        N'Middlesbrough',                                 --     [CntMailingCity],
        NULL,                                             --     [CntMailingState],
        N'TS5 5HR',                                       -- *   [CntMailingPostcode], -- Ayton Law
        N'United Kingdom',                                --     [CntMailingCountry],
        N'01642 828222',                                  --     [CntLandline],
        NULL,                                             --     [CntMobile],
        NULL,                                             --     [CntFax],
        N'johnsmith@acklamfinancial.co.uk',               --     [CntEmail],
        N'0',                                             --     [CntIsCf1],
        N'0',                                             --     [CntIsCf2],
        N'0',                                             --     [CntIsCf3],
        N'0',                                             --     [CntIsCf4],
        N'0',                                             --     [CntIsCf10],
        N'0',                                             --     [CntIsCf11],
        N'1',                                             --     [CntIsCf30],
        NULL,                                             --     [CntVerifiedBy],
        NULL                                              --     [CntExistingCompanyRelationship]
    );

    -- SETUP WOODFORDCONTACT --

    INSERT [Sales.BP].WoodfordContact -- Old, salutation = "Mr"
    (
        [CntFcaId],
        [CntSalesforceId],
        [CntMatrixId],
        [CntSivId],
        [CntSalutation],
        [CntFirstName],
        [CntLastName],
        [CntJobTitle],
        [CntLandline],
        [CntMobile],
        [CntFax],
        [CntEmail],
        [CntIsCf1],
        [CntIsCf2],
        [CntIsCf3],
        [CntIsCf4],
        [CntIsCf10],
        [CntIsCf11],
        [CntIsCf30],
        [WoodfordLastUpdate],
        [MatrixLastUpdate],
        [IsConfirmRequired],
        [IsReviewed],
        [StartDateTime],
        [EndDateTime],
        [IsActive],
        [ModifiedByPersonId],
        [JoinGUID],
        [CADIS_SYSTEM_INSERTED],
        [CADIS_SYSTEM_UPDATED],
        [CADIS_SYSTEM_CHANGEDBY],
        [CADIS_SYSTEM_PRIORITY],
        [CADIS_SYSTEM_LASTMODIFIED]
    )
    VALUES
    (
        N'JTS00002',                                  -- *    [CntFcaId],
        N'0032000001BtfuoAAB',                        --      [CntSalesforceId],
        N'$VPIE',                                     --      [CntMatrixId],
        N'con16859#323031342D30332D3238',             --      [CntSivId],
        N'Mr',                                        --      [CntSalutation],
        N'John',                                      --      [CntFirstName],
        N'Smith',                                     --      [CntLastName],
        N'Mr',                                        --      [CntJobTitle],
        N'01642 828222',                              --      [CntLandline],
        NULL,                                         --      [CntMobile],
        NULL,                                         --      [CntFax],
        N'johnsmith@acklamfinancial.co.uk',           --      [CntEmail],
        0,                                            --      [CntIsCf1],
        0,                                            --      [CntIsCf2],
        0,                                            --      [CntIsCf3],
        0,                                            --      [CntIsCf4],
        0,                                            --      [CntIsCf10],
        0,                                            --      [CntIsCf11],
        1,                                            --      [CntIsCf30],
        NULL,                                         --      [WoodfordLastUpdate],
        NULL,                                         --      [MatrixLastUpdate],
        0,                                            --      [IsConfirmRequired],
        0,                                            --      [IsReviewed],
        CAST(N'2016-09-15 15:12:51.660' AS DateTime), --      [StartDateTime],
        CAST(N'2016-09-15 15:13:00.000' AS DateTime), --      [EndDateTime],
        0,                                            --      [IsActive],
        NULL,                                         --      [ModifiedByPersonId],
        NULL,                                         --      [JoinGUID],
        CAST(N'2016-09-15 15:12:57.327' AS DateTime), --      [CADIS_SYSTEM_INSERTED],
        CAST(N'2016-09-15 15:12:57.327' AS DateTime), --      [CADIS_SYSTEM_UPDATED],
        N'UNKNOWN',                                   --      [CADIS_SYSTEM_CHANGEDBY],
        1,                                            --      [CADIS_SYSTEM_PRIORITY],
        CAST(N'2016-09-15 15:12:57.327' AS DateTime)  --      [CADIS_SYSTEM_LASTMODIFIED]
    )

    INSERT [Sales.BP].WoodfordContact -- New salutation = "Sir"
    (
        [CntFcaId],
        [CntSalesforceId],
        [CntMatrixId],
        [CntSivId],
        [CntSalutation],
        [CntFirstName],
        [CntLastName],
        [CntJobTitle],
        [CntLandline],
        [CntMobile],
        [CntFax],
        [CntEmail],
        [CntIsCf1],
        [CntIsCf2],
        [CntIsCf3],
        [CntIsCf4],
        [CntIsCf10],
        [CntIsCf11],
        [CntIsCf30],
        [WoodfordLastUpdate],
        [MatrixLastUpdate],
        [IsConfirmRequired],
        [IsReviewed],
        [StartDateTime],
        [EndDateTime],
        [IsActive],
        [ModifiedByPersonId],
        [JoinGUID],
        [CADIS_SYSTEM_INSERTED],
        [CADIS_SYSTEM_UPDATED],
        [CADIS_SYSTEM_CHANGEDBY],
        [CADIS_SYSTEM_PRIORITY],
        [CADIS_SYSTEM_LASTMODIFIED]
    )
    VALUES
    (
        N'JTS00002',                                  -- *    [CntFcaId],
        N'0032000001BtfuoAAB',                        --      [CntSalesforceId],
        N'$VPIE',                                     --      [CntMatrixId],
        N'con16859#323031342D30332D3238',             --      [CntSivId],
        N'Sir',                                       --      [CntSalutation],
        N'John',                                      --      [CntFirstName],
        N'Smith',                                     --      [CntLastName],
        N'Mr',                                        --      [CntJobTitle],
        N'01642 828222',                              --      [CntLandline],
        NULL,                                         --      [CntMobile],
        NULL,                                         --      [CntFax],
        N'johnsmith@acklamfinancial.co.uk',           --      [CntEmail],
        0,                                            --      [CntIsCf1],
        0,                                            --      [CntIsCf2],
        0,                                            --      [CntIsCf3],
        0,                                            --      [CntIsCf4],
        0,                                            --      [CntIsCf10],
        0,                                            --      [CntIsCf11],
        1,                                            --      [CntIsCf30],
        NULL,                                         --      [WoodfordLastUpdate],
        NULL,                                         --      [MatrixLastUpdate],
        0,                                            --      [IsConfirmRequired],
        0,                                            --      [IsReviewed],
        CAST(N'2016-09-15 15:12:51.660' AS DateTime), --      [StartDateTime],
        CAST(N'2099-12-31 00:00:00.000' AS DateTime), --      [EndDateTime],
        1,                                            --      [IsActive],
        NULL,                                         --      [ModifiedByPersonId],
        NULL,                                         --      [JoinGUID],
        CAST(N'2016-09-15 15:12:57.327' AS DateTime), --      [CADIS_SYSTEM_INSERTED],
        CAST(N'2016-09-15 15:12:57.327' AS DateTime), --      [CADIS_SYSTEM_UPDATED],
        N'UNKNOWN',                                   --      [CADIS_SYSTEM_CHANGEDBY],
        1,                                            --      [CADIS_SYSTEM_PRIORITY],
        CAST(N'2016-09-15 15:12:57.327' AS DateTime)  --      [CADIS_SYSTEM_LASTMODIFIED]
    )

    insert into [Sales.BP].WoodfordAccountContact
    (
        AccountId,
        ContactId
    )
    select      wa.Id,
                wc.Id
    from        [Sales.BP].WoodfordAccount  wa
    cross join  [Sales.BP].WoodfordContact  wc
    where       wa.AccName  = 'Acklam Financial Ltd'
    and         wc.CntFcaId = 'JTS00002'
    and         wc.IsActive = 0

    exec [Sales.BP].usp_CloseOldAccCntRelationship @YYYYMMDD_hhmm, N -- not salesforce data, need confirm

    set @n =
    (
        select count(*) from
        (
            select      wa.AccName                          wa_AccName  ,
                        wc.CntFcaId                         wc_CntFcaId ,
                        wa.IsActive                         wa_IsActive,
                        wc.IsActive                         wc_IsActive,
                        wac.IsActive                        wac_IsActive,
                        wac.IsConfirmRequired               wac_IsConfirmRequired,
                        count(*) over()                     n
            from        [Sales.BP].WoodfordAccountContact   wac
            cross join  [Sales.BP].WoodfordAccount          wa
            cross join  [Sales.BP].WoodfordContact          wc
            where       wac.AccountId                       = wa.Id
            and         wac.ContactId                       = wc.Id
            and         wc.CntFcaId                         = 'JTS00002'
            intersect
            (
                select 'Acklam Financial Ltd', 'JTS00002', 1, 0, 0, 1, 1 
            )
        ) x

    )

    if ( @n = 1 )
        print 'pass'
    else
        print '*** FAIL ***'

end

--go
--exec [Sales.BP].usp_CloseOldAccCntRelationship_TEST_2
--go
