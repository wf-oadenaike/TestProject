create view [Sales.BP].[PlannedActivityVw] as 
select      PersonsName         ,
            ActivityDate        ,
            ActivityTime        ,
            AddrCity        AccountCity,
            AddrPostcode        AccountPostcode,
            AccName         AccountName,
            Location        ActivityLocation,
            Subject         ActivitySubject,
            ActivityDuration
from
(
    select      p.PersonsName,
                    substring ( es.ActivityDateTime, 1, 4 )
                +   '-'
                +   substring ( es.ActivityDateTime, 5, 2 )
                +   '-'
                +   substring ( es.ActivityDateTime, 7, 2 )
                ActivityDate,
                    substring ( es.ActivityDateTime, 10, 2 )
                +   ':'
                +   substring ( es.ActivityDateTime, 12, 2 )
                ActivityTime,
                addr.AddrCity       ,
                addr.AddrPostcode   ,
                wa.AccName          ,
                es.Location         ,
                es.Subject          ,
                es.DurationInMinutes ActivityDuration
    from        [Staging.Salesforce.BP].EventSrc        es
    cross join  [Core].Persons                          p
    cross join  [Sales.BP].[WoodfordAccount]            wa
    cross join  [Sales.BP].[WoodfordAccountAddress]     waa
    cross join  [Sales.BP].[WoodfordAddress]            addr
    where       p.FullEmployeeBK                        = es.CreatedById
    and         wa.AccSalesforceId                      = es.AccountId
    and         waa.AccountId                           = wa.Id
    and         waa.AddressId                           = addr.Id
    and         wa.IsActive                             = 1
    and         addr.IsActive                           = 1
    and         p.JobTitle                              = 'Relationship Manager'
) x
where       cast ( ActivityDate as datetime ) >= dateadd ( month, datediff ( month, 0, getdate() ) + 1, 0 )
and         cast ( ActivityDate as datetime ) <  dateadd ( month, datediff ( month, 0, getdate() ) + 2, 0 )
