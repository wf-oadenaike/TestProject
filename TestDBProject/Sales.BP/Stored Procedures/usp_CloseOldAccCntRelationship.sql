CREATE 
---------------------------------------------------------------------------------------------------- 
-- Name:    Sales.BP.usp_CloseOldAccCntRelationship                                               --
-- Author:  Ian McLaughlin                                                                        --
-- Date:    28/12/2016                                                                            --
-- Set all WoodfordAccountContact rows to inactive where a matching row does not exist in         --
-- ContactMerge table for this contact.                                                           --
----------------------------------------------------------------------------------------------------
procedure [Sales.BP].usp_CloseOldAccCntRelationship 
    @TimeNow            varchar(99), 
    @IsSalesforceData   varchar(99)
as
begin

    declare @AccountId              int
    declare @ContactId              int
    declare @AccIsPriorityClient    int
    declare @IsConfirmRequired      int

    -- Get all account contact relationships that don't exist in merge table
	-- NOTE: Don't exclude inactive contacts here as they may have just been set inactive by an update
	-- to an attribute, eg salutation.
	-- The important thing is to pick up all active relationships, ie wac.IsActive = 1

    declare     c1 cursor read_only for
    select      wa.id,
                wc.id,
                wa.AccIsPriorityClient
    from        [Sales.BP].WoodfordAccount          wa
    cross join  [Sales.BP].WoodfordContact          wc
    cross join  [Sales.BP].WoodfordAccountContact   wac
    where       wac.AccountId                       = wa.Id
    and         wac.ContactId                       = wc.Id
    and         wac.IsActive                        = 1
    and         wa.IsActive                         = 1
    and         wac.IsConfirmRequired               = 0
    ------
    except
    ------
    select      wa.Id,
                wc.Id,
                wa.AccIsPriorityClient
    from        [Staging.Salesforce.BP].[ContactMerge]  cm
    cross join  [Sales.BP].WoodfordContact              wc
    cross join  [Sales.BP].WoodfordAccount              wa
    where       cm.CntAccountFcaId                      = wa.AccFcaId
    and         cm.CntMailingPostcode                   = wa.AccPostcode
    and         cm.CntFcaId                             = wc.CntFcaId
    and         wa.IsActive                             = 1

    open c1
    
    while 1=1 begin

        -- For all expired relationships

        fetch next from c1 into @AccountId, @ContactId, @AccIsPriorityClient

        if @@fetch_status != 0 break

		if ( @IsSalesforceData = 'N' and @AccIsPriorityClient = 1 ) 
			set @IsConfirmRequired = 1
		else
			set @IsConfirmRequired = 0

        update      [Sales.BP].WoodfordAccountContact
        set         IsActive            = 0,
                    EndDateTime         = @TimeNow,
                    IsConfirmRequired   = @IsConfirmRequired
        where       AccountId           = @AccountId
        and         ContactId           = @ContactId
        and         IsActive            = 1

    end
    
    close c1

end
