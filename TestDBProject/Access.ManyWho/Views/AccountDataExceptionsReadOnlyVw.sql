    --  IanMc 12/12/16 Added owner id mismatch to predicate
    CREATE view [Access.ManyWho].[AccountDataExceptionsReadOnlyVw] as         
    select      AccSalesforceId   ,
                AccFcaId          ,
                AccMatrixOutletId ,
                IsActive          ,
                NewWaId           ,
                NewAccName        ,
                NewAccOwnerId     ,
                NewAccOwnerName   ,
                NewAccPostcode    ,
                NewAddrStreet     ,
                NewAddrCity       ,
                NewAddrCountry    ,
                OldWaId           ,
                OldAccName        ,
                OldAccOwnerId     ,
                OldAccOwnerName   ,
                OldAccPostcode    ,
                OldAddrCity       ,
                OldAddrStreet     ,
                OldAddrCountry
    from
    (
        select      acc.AccSalesforceId                                                                         AccSalesforceId   ,
                    acc.AccFcaId                                                                                AccFcaId          ,
                    acc.AccMatrixOutletId                                                                       AccMatrixOutletId ,
                    acc.IsActive                                                                                IsActive          ,
                    acc.Id                                                                                      NewWaId           ,
                    acc.AccName                                                                                 NewAccName        ,
                    acc.AccOwnerId                                                                              NewAccOwnerId     ,
                    p.PersonsName                                                                               NewAccOwnerName   ,
                    acc.AccPostcode                                                                             NewAccPostcode    ,
                    addr.AddrStreet                                                                             NewAddrStreet     ,
                    addr.AddrCity                                                                               NewAddrCity       ,
                    addr.AddrCountry                                                                            NewAddrCountry    ,
                    lag ( acc.Id          ) over ( partition by AccSalesforceId order by acc.StartDateTime )    OldWaId           ,
                    lag ( acc.AccName     ) over ( partition by AccSalesforceId order by acc.StartDateTime )    OldAccName        ,
                    lag ( acc.AccOwnerId  ) over ( partition by AccSalesforceId order by acc.StartDateTime )    OldAccOwnerId     ,
                    lag ( p.PersonsName   ) over ( partition by AccSalesforceId order by acc.StartDateTime )    OldAccOwnerName   ,
                    lag ( acc.AccPostcode ) over ( partition by AccSalesforceId order by acc.StartDateTime )    OldAccPostcode    ,
                    lag ( addr.AddrStreet ) over ( partition by AccSalesforceId order by acc.StartDateTime )    OldAddrStreet     ,
                    lag ( addr.AddrCity   ) over ( partition by AccSalesforceId order by acc.StartDateTime )    OldAddrCity       ,
                    lag ( addr.AddrCountry) over ( partition by AccSalesforceId order by acc.StartDateTime )    OldAddrCountry
        from        [Sales.BP].[WoodfordAccount]            acc
        cross join  [Sales.BP].[WoodfordAccountAddress]     waa
        cross join  [Sales.BP].[WoodfordAddress]            addr
        left join   [Core].[Persons]                        p
        on          acc.AccOwnerId                          = p.FullEmployeeBK
        where       waa.AccountId                           = acc.Id
        and         waa.AddressId                           = addr.Id
        and         AccIsPriorityClient                     = 1
        and         acc.AccSalesforceId                     is not null
    ) x
    where IsActive = 1
    and
    (
        OldAccPostcode  != NewAccPostcode
        or
        OldAccOwnerName != NewAccOwnerName
    )
