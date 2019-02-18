create procedure [Sales.BP].usp_OpenNewAccCntRelationship_TEST as
begin

    declare @n int

    -- John Smith has moved to Ayton Law

    delete      [Staging.Salesforce.BP].ContactMerge 
    where       CntFcaId in ( 'JTS00002' ) 

    delete      [Sales.BP].WoodfordAccountContact 
    where       ContactId in 
                ( 
                    select      Id
                    from        [Sales.BP].WoodfordContact 
                    where       CntFcaId in ( 'JTS00002' )
                )

    delete      [Sales.BP].WoodfordContact 
    where       [CntFcaId] in ( 'JTS00002' )

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

    delete      [Sales.BP].WoodfordAccount 
    where       AccName in ( 'Acklam Financial Ltd', 'Ayton-Law Ltd' )

    INSERT [Sales.BP].WoodfordContact
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
        N'JTS00002',
        N'0032000001BtfuoAAB',
        N'$VPIE',
        N'con16859#323031342D30332D3238',
        N'Mr',
        N'John',
        N'Smith',
        N'Mr',
        N'01642 828222',
        NULL,
        NULL,
        N'johnsmith@acklamfinancial.co.uk',
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        NULL,
        NULL,
        0,
        0,
        CAST(N'2016-09-15 15:12:51.660' AS DateTime),
        CAST(N'2099-12-31 00:00:00.000' AS DateTime),
        1,
        NULL,
        NULL,
        CAST(N'2016-09-15 15:12:57.327' AS DateTime),
        CAST(N'2016-09-15 15:12:57.327' AS DateTime),
        N'UNKNOWN',
        1,
        CAST(N'2016-09-15 15:12:57.327' AS DateTime)
    )

    INSERT [Sales.BP].WoodfordAccount
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
        N'Acklam Financial Ltd',                                             --     [AccName],
        N'^RMIM',                                                            --     [AccMatrixOutletId],
        N'acc6581#323031342D30332D3238',                                     --     [AccSivId],
        NULL,                                                                --     [AccParentSivId],
        223707,                                                              --     [AccFcaId],
        N'TS5 7BP',                                                          --     [AccPostcode],
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

    INSERT [Sales.BP].WoodfordAccount
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
        N'00120000017Kei6AAC',
        N'Ayton-Law Ltd',
        N'^CJGL',
        N'acc5557#323031342D30332D3238',
        NULL,
        191446,
        N'TS5 5HR',
        N'01642 659500',
        N'01642 659600',
        NULL,
        N'Small Firm',
        N'Appointed Representative',
        N'FundsNetwork;Skandia Investment Solutions',
        N'Head Office',
        NULL,
        0,
        0,
        N'00520000003S826AAC',
        N'Steve Baxter',
        NULL,
        NULL,
        CAST(N'2016-09-14 16:33:47.037' AS DateTime),
        CAST(N'2099-12-31 00:00:00.000' AS DateTime),
        1,
        NULL,
        0,
        NULL
    )

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
        N'0032000001BtfuoAAB',                                   --    [CntSalesforceId],
        N'00120000017Kf2fAAC',                                   --    [CntAccountSalesforceId],
        N'JTS00002',                                             --    [CntFcaId],
        N'191446',                                               -- *  [CntAccountFcaId],
        N'00520000003S826AAC',                                   --    [CntOwnerId],
        N'Steve Baxter',                                         --    [CntOwnerName],
        N'acc6581#323031342D30332D3238',                         --    [CntAccountSivId],
        N'con16859#323031342D30332D3238',                        --    [CntSivId],
        N'$VPIE',                                                --    [CntMatrixId],
        N'Mr',                                                   --    [CntSalutation],
        N'John',                                                 --    [CntFirstName],
        N'Smith',                                                --    [CntLastName],
        N'Mr',                                                   --    [CntJobTitle],
        N'261a Acklam Road',                                     --    [CntMailingStreet],
        N'Middlesbrough',                                        --    [CntMailingCity],
        NULL,                                                    --    [CntMailingState],
        N'TS5 5HR',                                              -- *  [CntMailingPostcode],
        N'United Kingdom',                                       --    [CntMailingCountry],
        N'01642 828222',                                         --    [CntLandline],
        NULL,                                                    --    [CntMobile],
        NULL,                                                    --    [CntFax],
        N'johnsmith@acklamfinancial.co.uk',                      --    [CntEmail],
        N'0',                                                    --    [CntIsCf1],
        N'0',                                                    --    [CntIsCf2],
        N'0',                                                    --    [CntIsCf3],
        N'0',                                                    --    [CntIsCf4],
        N'0',                                                    --    [CntIsCf10],
        N'0',                                                    --    [CntIsCf11],
        N'1',                                                    --    [CntIsCf30],
        NULL,                                                    --    [CntVerifiedBy],
        NULL                                                     --    [CntExistingCompanyRelationship]
    );

    declare @YYYYMMDD_hhmm varchar(99)
    
    select @YYYYMMDD_hhmm = convert ( char(16), getdate(), 121 ) 

    exec [Sales.BP].usp_OpenNewAccCntRelationship @TimeNow = @YYYYMMDD_hhmm

    set @n = 
    (
        select count(*) from
        (
            select      wa.AccName  ,                  
                        wc.CntFcaId ,                  
                        wac.IsActive,                  
                        wac.IsConfirmRequired,          
                        count(*) over() n
            from        [Sales.BP].WoodfordAccountContact   wac
            cross join  [Sales.BP].WoodfordAccount          wa
            cross join  [Sales.BP].WoodfordContact          wc
            where       wac.AccountId                       = wa.Id
            and         wac.ContactId                       = wc.Id
            and         wc.CntFcaId 			    in ( 'JTS00002' )
            intersect
            (
                select 'Ayton-Law Ltd'       , 'JTS00002', 1, 0, 1
            )
        ) x

    )

    if ( @n = 1 ) 
        print 'pass'
    else 
        print '*** FAIL ***'

end
