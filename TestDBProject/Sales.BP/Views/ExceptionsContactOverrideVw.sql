



---------------------------------------------------------------

-------------------------------------------------------------------------------------- 
-- Name: Contact Exception overrid view [Sales.BP].[ExceptionsContactOverrideVw]
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi, 10/06/2017 
-- Reads Exported Exception to update EDM and SF
-- 
--------------------------------------------------------------------------------------

CREATE VIEW [Sales.BP].[ExceptionsContactOverrideVw]
AS
SELECT      distinct
            cnt.CntSalesforceId                     CntSalesforceId                      ,
            acc.AccSalesforceId                     CntAccountSalesforceId               ,
            cnt.CntMatrixId                         CntMatrixId                          ,
            cnt.CntSivId                            CntSivId                             ,
            acc.AccSivId                            CntAccountSivId                      ,
            acc.AccFcaId                            CntAccountFcaId                      ,
            CO.ContactOwnerId                          CntOwnerId                           ,
            ''                         CntOwnerName                         ,
            cnt.CntSalutation                       CntSalutation                        ,
            CO.FirstName                        CntFirstName                         ,
            CO.LastName                         CntLastName                          ,
            cnt.CntFcaId                            CntFcaId                             ,
            cnt.CntJobTitle                         CntJobTitle                          ,
            CO.Phone                         CntLandline                          ,
            CO.Mobile                           CntMobile                            ,
            cnt.CntFax                              CntFax                               ,
            CO.EmailAddress                            CntEmail                             ,
            adr.AddrStreet                          CntMailingStreet                     ,
            adr.AddrCity                            CntMailingCity                       ,
            adr.AddrState                           CntMailingState                      ,
            adr.AddrPostcode                        CntMailingPostcode                   ,
            adr.AddrCountry                         CntMailingCountry                    ,
            cnt.CntIsCf1                            CntIsCf1                             ,
            cnt.CntIsCf2                            CntIsCf2                             ,
            cnt.CntIsCf3                            CntIsCf3                             ,
            cnt.CntIsCf4                            CntIsCf4                             ,
            cnt.CntIsCf10                           CntIsCf10                            ,
            cnt.CntIsCf11                           CntIsCf11                            ,
            cnt.CntIsCf30                           CntIsCf30                            ,
            null                                    CntVerifiedBy                        ,
            null                                    CntExistingCompanyRelationship
from        [Sales.BP].[WoodfordAccountVw]          acc
cross join  [Sales.BP].[WoodfordAddressVw]          adr
cross join  [Sales.BP].[WoodfordContactVw]          cnt
cross join  [Sales.BP].[WoodfordAccountAddress]     aa
cross join  [Sales.BP].[WoodfordAccountContact]     ac
cross join  [Staging.Salesforce.BP].[SalesteamContactOverrides] CO
where       acc.Id                                  = aa.AccountId
and         acc.Id                                  = ac.AccountId
and         adr.Id                                  = aa.AddressId
and         cnt.Id                                  = ac.ContactId
and         cnt.IsConfirmRequired                   = 0
and         cnt.IsActive                            = 1
and         adr.IsActive                            = 1
and         acc.IsActive                            = 1
and         acc.AccIsLocked                         = 0 -- IanMc 21/2/17
and			CO.sfContactId = cnt.CntSalesforceId
and			CO.FcaId = cnt.CntFcaId
and			CO.ContactMatrixId = cnt.CntMatrixId




