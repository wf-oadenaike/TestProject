create procedure [Sales.BP].usp_OpenNewAccCntRelationship @TimeNow varchar(99) as
---------------------------------------------------------------------------------------------------- 
-- Name:    Sales.BP.usp_OpenNewAccCntRelationship                                               --
-- Author:  Ian McLaughlin                                                                        --
-- Date:    28/12/2016                                                                            --
-- Set all WoodfordAccountContact rows to active where a new row in ContactMerge exists.          --
----------------------------------------------------------------------------------------------------
begin

    declare @AccountId int
    declare @ContactId int
    declare @AccIsPriorityClient int

    -- Get all new account contact relationships from merge table

    declare     c1 cursor read_only for
    select      wa.Id                                   AccountId,
                wc.Id                                   ContactId
    from        [Staging.Salesforce.BP].[ContactMerge]  cm
    cross join  [Sales.BP].WoodfordContact              wc
    cross join  [Sales.BP].WoodfordAccount              wa
    where       cm.CntAccountFcaId                      = wa.AccFcaId
    and         cm.CntMailingPostcode                   = wa.AccPostcode
    and         cm.CntFcaId                             = wc.CntFcaId
    and         wa.IsActive                             = 1
    and         wc.IsActive                             = 1
    ------
    except
    ------
    select      wa.id,
                wc.id
    from        [Sales.BP].WoodfordAccount          wa
    cross join  [Sales.BP].WoodfordContact          wc
    cross join  [Sales.BP].WoodfordAccountContact   wac
    where       wac.AccountId                       = wa.Id
    and         wac.ContactId                       = wc.Id
    and         wac.IsActive                        = 1
    and         wa.IsActive                         = 1
    and         wc.IsActive                         = 1

    open c1
    
    while 1=1 begin

        -- For all new relationships

        fetch next from c1 into @AccountId, @ContactId

        if @@fetch_status != 0 break

        insert into [Sales.BP].WoodfordAccountContact
        (
            IsActive            ,
            StartDateTime       ,
            EndDateTime         ,
            IsConfirmRequired   ,
            AccountId           ,
            ContactId           
        )
        values
        (
            1,
			@TimeNow,
            '2099-12-31',
            0,
            @AccountId,
            @ContactId
        )

    end
    
    close c1

end
