
CREATE VIEW [Sales.BP].[SfAccountVw]
AS 
-------------------------------------------------------------------------------------- 
-- WHO WHEN WHY
-- Vipul Khatri  09/05/2018 DAP-1928  - Salesforce Account feed.
-------------------------------------------------------------------------------------- 

SELECT AccSalesforceId                                       AS SfAccountId,
       AccParentSalesforceId                                 AS SfParentAccountId,
       AccName                                               AS AccountName,
       AccFcaId                                              AS FcaId,
       AccMatrixOutletId                                     AS MatrixOutletId,
       AccOutletType                                         AS OutletType,
       AccSivId                                              AS AccountSivId,
       AccParentSivId                                        AS ParentAccountSivId,
       AccOwnerId                                            AS AccountOwnerId,
       AccOwnerName                                          AS AccountOwnerName,
       AccLandline                                           AS Phone,
       AccFax                                                AS Fax,
       AccWebsite                                            AS Website,
       AccEmail                                              AS EmailAddress,
       AccRegionCode                                         AS RegionId,
       AccCalculatedPriority                                 AS CalculatedPriority,
       AccKeyAccount                                         AS IsKeyAccount,
       AccPriorityClient                                     AS IsPriorityClient,
       AccIsLocked                                           AS IsLocked,
       AccFirmSegment                                        AS FirmSegment,
       AccPlatformsUsed                                      AS PlatformsUsed,
       AccAuthStatus                                         AS AuthStatus,
       AccBillingStreet                                      AS BillingStreet,
       AccBillingCity                                        AS BillingCity,
       AccBillingState                                       AS BillingState,
       AccBillingPostcode                                    AS BillingPostcode,
       LEFT(AccBillingPostcode, LEN(AccBillingPostcode) - 2) AS BillingPostcodeMapping,
       AccBillingCountry                                     AS BillingCountry,
       AccFCAStatus                                          AS AccFCAStatus,
       AccMFIDStatus                                         AS AccMFIDStatus,
       accIsActive                                           AS AccIsActive,
       MX_PRIMARY_BUSINESS                                   AS MX_PRIMARY_BUSINESS,
       WF_PRIMARY_BUSINESS                                   AS WF_PRIMARY_BUSINESS,
       AccVerifiedBy                                         AS AccVerifiedBy,
       AccExistingCompanyRelationship                        AS AccExistingCompanyRelationship,
       CASE
            WHEN (AccBillingStreet IS NULL AND
                 AccBillingCity IS NULL AND
                 AccBillingPostcode IS NULL AND
                 AccBillingCountry IS NULL) THEN 1
            ELSE 0
       END                                                   AS IsBillingAddressNull,
	   RecordTypeName
FROM [Staging.Salesforce.BP].MxAccountExtract