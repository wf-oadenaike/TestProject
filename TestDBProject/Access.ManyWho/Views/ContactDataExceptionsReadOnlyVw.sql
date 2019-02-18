-- IanMc 17.10.16 - Reformatted and changed IdPriorityAccount predicate to look at IsConfirmRequired
-- IanMc 25.11.16 - Exclude dupes caused by contact moves or Matrix dupes
-- IanMc 25.11.16 - Choose first id instead of last where dupes
CREATE VIEW [Access.ManyWho].[ContactDataExceptionsReadOnlyVw]
AS 
WITH LatestBeforeCnt as
(
    SELECT      Id,
                MAX ( StartDateTime ) LatestDate
    FROM        [Sales.BP].WoodfordContact
    WHERE       IsActive = 0
    GROUP BY    Id
)
SELECT      AccName                       ,
            AccFcaId                      ,
            AccPostcode                   ,
            OldId                         ,
            OldCntFcaId                   ,
            OldCntSalesforceId            ,
            OldCntMatrixId                ,
            OldCntSalutation              ,
            OldCntFirstName               ,
            OldCntLastName                ,
            OldCntFirstNameLastName       ,
            OldCntJobTitle                ,
            OldCntLandline                ,
            OldCntMobile                  ,
            OldCntFax                     ,
            OldCntEmail                   ,
            OldCntIsCf1                   ,
            OldCntIsCf2                   ,
            OldCntIsCf3                   ,
            OldCntIsCf4                   ,
            OldCntIsCf10                  ,
            OldCntIsCf11                  ,
            OldCntIsCf30                  ,
            OldLastUpdate                 ,
            OldIsConfirmRequired          ,
            OldStartDateTime              ,
            OldEndDateTime                ,
            OldIsActive                   ,
            OldIsReviewed                 ,
            NewId                         ,
            NewCntFcaId                   ,
            NewCntSalesforceId            ,
            NewCntMatrixId                ,
            NewCntSalutation              ,
            NewCntFirstName               ,
            NewCntLastName                ,
            NewCntFirstNameLastName       ,
            NewCntJobTitle                ,
            NewCntLandline                ,
            NewCntMobile                  ,
            NewCntFax                     ,
            NewCntEmail                   ,
            NewCntIsCf1                   ,
            NewCntIsCf2                   ,
            NewCntIsCf3                   ,
            NewCntIsCf4                   ,
            NewCntIsCf10                  ,
            NewCntIsCf11                  ,
            NewCntIsCf30                  ,
            NewLastUpdate                 ,
            NewIsConfirmRequired          ,
            NewStartDateTime              ,
            NewEndDateTime                ,
            NewIsActive                   ,
            NewIsReviewed                 ,
            AccOwnerId                    ,
            AccOwnerName                  
FROM
(
    SELECT      wa.AccName                                            AccName                       ,
                wa.AccFcaId                                           AccFcaId                      ,
                wa.AccPostcode                                        AccPostcode                   ,
                old.Id                                                OldId                         ,
                old.CntFcaId                                          OldCntFcaId                   ,
                old.CntSalesforceId                                   OldCntSalesforceId            ,
                old.CntMatrixId                                       OldCntMatrixId                ,
                old.CntSalutation                                     OldCntSalutation              ,
                old.CntFirstName                                      OldCntFirstName               ,
                old.CntLastName                                       OldCntLastName                ,
                old.CntFirstName + ' ' + old.CntLastName              OldCntFirstNameLastName       ,
                old.CntJobTitle                                       OldCntJobTitle                ,
                old.CntLandline                                       OldCntLandline                ,
                old.CntMobile                                         OldCntMobile                  ,
                old.CntFax                                            OldCntFax                     ,
                old.CntEmail                                          OldCntEmail                   ,
                old.CntIsCf1                                          OldCntIsCf1                   ,
                old.CntIsCf2                                          OldCntIsCf2                   ,
                old.CntIsCf3                                          OldCntIsCf3                   ,
                old.CntIsCf4                                          OldCntIsCf4                   ,
                old.CntIsCf10                                         OldCntIsCf10                  ,
                old.CntIsCf11                                         OldCntIsCf11                  ,
                old.CntIsCf30                                         OldCntIsCf30                  ,
                old.WoodfordLastUpdate                                OldLastUpdate                 ,
                old.IsConfirmRequired                                 OldIsConfirmRequired          ,
                old.StartDateTime                                     OldStartDateTime              ,
                old.EndDateTime                                       OldEndDateTime                ,
                old.IsActive                                          OldIsActive                   ,
                old.IsReviewed                                        OldIsReviewed                 ,
                new.Id                                                NewId                         ,
                new.CntFcaId                                          NewCntFcaId                   ,
                new.CntSalesforceId                                   NewCntSalesforceId            ,
                new.CntMatrixId                                       NewCntMatrixId                ,
                new.CntSalutation                                     NewCntSalutation              ,
                new.CntFirstName                                      NewCntFirstName               ,
                new.CntLastName                                       NewCntLastName                ,
                new.CntFirstName + ' ' + new.CntLastName              NewCntFirstNameLastName       ,
                new.CntJobTitle                                       NewCntJobTitle                ,
                new.CntLandline                                       NewCntLandline                ,
                new.CntMobile                                         NewCntMobile                  ,
                new.CntFax                                            NewCntFax                     ,
                new.CntEmail                                          NewCntEmail                   ,
                new.CntIsCf1                                          NewCntIsCf1                   ,
                new.CntIsCf2                                          NewCntIsCf2                   ,
                new.CntIsCf3                                          NewCntIsCf3                   ,
                new.CntIsCf4                                          NewCntIsCf4                   ,
                new.CntIsCf10                                         NewCntIsCf10                  ,
                new.CntIsCf11                                         NewCntIsCf11                  ,
                new.CntIsCf30                                         NewCntIsCf30                  ,
                new.MatrixLastUpdate                                  NewLastUpdate                 ,
                new.IsConfirmRequired                                 NewIsConfirmRequired          ,
                new.StartDateTime                                     NewStartDateTime              ,
                new.EndDateTime                                       NewEndDateTime                ,
                new.IsActive                                          NewIsActive                   ,
                new.IsReviewed                                        NewIsReviewed                 ,
                wa.AccOwnerId                                         AccOwnerId                    ,
                wa.AccOwnerName                                       AccOwnerName                  ,
                row_number() over
                (
                    partition by old.CntFcaId
                    order by     old.Id 
                )
                OldCntFcaIdRank
    --
    FROM        [Sales.BP].[WoodfordAccount]            wa
    CROSS JOIN  [Sales.BP].[WoodfordAccountContact]     wac
    CROSS JOIN  [Sales.BP].[WoodfordContact]            new
    CROSS JOIN  [Sales.BP].[WoodfordContact]            old
    CROSS JOIN  LatestBeforeCnt                         lbc
    --
    WHERE       wa.Id                                   = wac.AccountId
    AND         wac.ContactId                           = new.Id
    AND         new.CntFcaId                            = old.CntFcaId
    AND         old.Id                                  = lbc.Id
    --
    AND         old.IsActive                            = 0
    AND         new.IsActive                            = 1
    AND         new.IsConfirmRequired                   = 1
    AND         wa.IsActive                             = 1
) x
WHERE OldCntFcaIdRank = 1 -- exclude any dupes caused by Matrix or contact movers
