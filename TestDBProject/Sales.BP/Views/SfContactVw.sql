
CREATE VIEW [Sales.BP].[SfContactVw]
AS

-------------------------------------------------------------------------------------- 
-- WHO WHEN WHY
-- Vipul Khatri  09/05/2018 DAP-1929   - Salesforce contact feed.
-------------------------------------------------------------------------------------- 


SELECT CntSalesforceId                                       AS SfContactId,
       CntAccountSalesforceId                                AS SfAccountId,
       CntLastName                                           AS LastName,
       CntFirstName                                          AS FirstName,
       CntSalutation                                         AS Salutation,
       CntJobTitle                                           AS JobTitle,
       CntFcaId                                              AS FcaId,
       CntAccountFcaId                                       AS AccountFcaId,
       CntOwnerId                                            AS ContactOwnerId,
	   CntOwnerName											 AS ContactOwnerName,
       CntAccountSivId                                       AS AccountSivId,
       CntSivId                                              AS ContactSivId,
       CntMatrixId                                           AS ContactMatrixId,
       CntMailingStreet                                      AS MailingStreet,
       CntMailingCity                                        AS MailingCity,
       CntMailingState                                       AS MailingState,
       CntMailingPostcode                                    AS MailingPostcode,
       case when LEN(CntMailingPostcode) > 2
	        then LEFT(CntMailingPostcode, LEN(CntMailingPostcode) - 2) 
			else CntMailingPostcode
	   end													 AS MailingPostcodeMapping,
       CntMailingCountry                                     AS MailingCountry,
       CntLandline                                           AS Phone,
       CntMobile                                             AS Mobile,
       CntFax                                                AS Fax,
       CntEmail                                              AS EmailAddress,
       CntIsCf1                                              AS IsCf1,
       CntIsCf2                                              AS IsCf2,
       CntIsCf3                                              AS IsCf3,
       CntIsCf4                                              AS IsCf4,
       CntIsCf10                                             AS IsCf10,
       CntIsCf11                                             AS IsCf11,
       CntIsCf30                                             AS IsCf30,
       CntFCAStatus                                          AS FCAStatus,
       CntMFIDStatus                                         AS MFIDStatus,
       CntIsActive                                           AS IsActive,
	   CntVerifiedBy										 as VerifiedBy,
	   CntExistingCompanyRelationship						 as ExistingCompanyRelationship,
       AccountIsPriorityClient								 as AccIsPriorityClient,
       AccountIsLocked										 as AccIsLocked,
       AccountRecordtypeName								 as AccRecordtypeName,
	   CASE
            WHEN (CntMailingStreet IS NULL AND
                 CntMailingCity IS NULL AND
                 CntMailingPostcode IS NULL AND
                 CntMailingCountry IS NULL) THEN 1
            ELSE 0
       END                                                   AS IsMailingAddressNull,
	   CASE
            WHEN (CntLastName IS NULL AND
                 CntFirstName IS NULL AND
				 CntSalutation IS NULL) THEN 1
            ELSE 0
       END                                                   AS IsNameNull
FROM [Staging.Salesforce.BP].MxContactExtract
