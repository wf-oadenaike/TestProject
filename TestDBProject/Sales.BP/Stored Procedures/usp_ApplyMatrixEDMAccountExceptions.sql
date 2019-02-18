
CREATE PROC [Sales.BP].[usp_ApplyMatrixEDMAccountExceptions]  AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_ApplyMatrixEDMAccountExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi: 25/05/2017 JIRA: Save Exception overrides to Datawarehouse and SF
--
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY

SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_ApplyMatrixEDMAccountExceptions]';

BEGIN TRANSACTION
-------------------------------
DECLARE @WFAccount TABLE (
	[Id] [Int] NOT NULL,
	[AccSalesforceId] [char](18) NULL,
	[AccName] [nvarchar](100) NOT NULL,
	[AccMatrixOutletId] [char](5) NULL,
	[AccSivId] [nvarchar](100) NULL,
	[AccParentSivId] [nvarchar](100) NULL,
	[AccFcaId] [int] NOT NULL,
	[AccPostcode] [nvarchar](20) NOT NULL,
	[AccLandline] [nvarchar](100) NULL,
	[AccFax] [nvarchar](100) NULL,
	[AccWebsite] [nvarchar](100) NULL,
	[AccFirmSegment] [nvarchar](100) NULL,
	[AccAuthStatus] [nvarchar](100) NULL,
	[AccPlatformsUsed] [nvarchar](1000) NULL,
	[AccOutletType] [nvarchar](100) NULL,
	[AccVerifiedBy] [nvarchar](100) NULL,
	[AccIsExistingRel] [bit] NOT NULL,
	[AccIsPriorityClient] [bit] NOT NULL,
	[AccIsLocked] [bit] NOT NULL,
	[AccOwnerId] [nvarchar](100) NULL,
	[AccOwnerName] [nvarchar](100) NULL,
	[WoodfordLastUpdate] [datetime] NULL,
	[MatrixLastUpdate] [datetime] NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[AccCalculatedPriority] [decimal](19, 2) NULL,
	[AccIsKeyAccount] [bit] NOT NULL,
	[RegionId] [int] NULL,
	[AccSalesforceId_15] [nvarchar](15) NULL,
	[IsConfirmRequired] [bit] ,
	[JoinGUID] [uniqueidentifier] NULL,
	[CADIS_SYSTEM_INSERTED] [datetime] NULL,
	[CADIS_SYSTEM_UPDATED] [datetime] NULL,
	[CADIS_SYSTEM_CHANGEDBY] [nvarchar](50) NULL,
	[CADIS_SYSTEM_PRIORITY] [int] NULL,
	[CADIS_SYSTEM_TIMESTAMP] [timestamp] NOT NULL,
	[CADIS_SYSTEM_LASTMODIFIED] [datetime] NULL)

-------------------------------------
INSERT INTO @WFAccount
SELECT DISTINCT
WA.Id, 
WA.[AccSalesforceId],
AO.AccountName, -- OVERRIDE
WA.[AccMatrixOutletId],
WA.[AccSivId],
WA.[AccParentSivId],
WA.[AccFcaId],
AO.[BillingPostcode],
AO.[Phone], 
WA.[AccFax],
WA.[AccWebsite],
WA.[AccFirmSegment],
WA.[AccAuthStatus],
WA.[AccPlatformsUsed],
WA.[AccOutletType],
WA.[AccVerifiedBy],
WA.[AccIsExistingRel],
WA.[AccIsPriorityClient],
WA.[AccIsLocked],
AO.AccountOwnerId,  
CP.PersonsName,
WA.[WoodfordLastUpdate],
WA.[MatrixLastUpdate],
getdate() AS StartDateTime, 
'2099-12-31T00:00:00'	AS EndDateTime, 	
1 AS IsActive,
WA.[AccCalculatedPriority],
WA.[AccIsKeyAccount],
WA.[RegionId],
WA.[AccSalesforceId_15],
WA.[IsConfirmRequired],
WA.[JoinGUID], -- Need a new one?
getdate() AS CADIS_SYSTEM_INSERTED,
getdate() AS CADIS_SYSTEM_UPDATED,
'EDM UI' AS CADIS_SYSTEM_CHANGEDBY,
1 AS CADIS_SYSTEM_PRIORITY,
NULL,
getdate() AS CADIS_SYSTEM_LASTMODIFIED
FROM [Sales.BP].WoodfordAccount WA
JOIN [Staging.Salesforce.BP].[SalesteamAccountOverrides] AO
ON	  WA.AccSalesforceId = AO.SfAccountID
AND	  WA.AccMatrixOutletId = AO.OutletId
AND   WA.AccFcaId = AO.FcaId
JOIN [Core].[Persons] CP
ON LEFT(AO.AccountOwnerId,15) = CP.EmployeeBK
WHERE WA.IsActive = 1

-----------------------------------------------------------------------
-- UPDATE ACCOUNT INFORMATION
--- Set DW SCD flag to 0
-----------------------------------------------------------------------
UPDATE WA
SET WA.IsActive = '0', WA.EndDateTime = getdate()
FROM [Sales.BP].WoodfordAccount WA
JOIN   @WFAccount AO
ON	  WA.AccSalesforceId = AO.AccSalesforceId
AND	  WA.AccMatrixOutletId = AO.AccMatrixOutletId
AND   WA.AccFcaId = AO.AccFcaId
AND   WA.IsActive = 1

---------------------------
INSERT INTO [Sales.BP].WoodfordAccount (
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
	[AccIsLocked],
	[AccOwnerId],
	[AccOwnerName],
	[WoodfordLastUpdate],
	[MatrixLastUpdate],
	[StartDateTime],
	[EndDateTime],
	[IsActive],
	[AccCalculatedPriority],
	[AccIsKeyAccount],
	[RegionId],	
	[IsConfirmRequired],
	[JoinGUID],
	[CADIS_SYSTEM_INSERTED],
	[CADIS_SYSTEM_UPDATED],
	[CADIS_SYSTEM_CHANGEDBY], 
	[CADIS_SYSTEM_PRIORITY],
	[CADIS_SYSTEM_LASTMODIFIED])

SELECT 
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
	[AccIsLocked],
	[AccOwnerId],
	[AccOwnerName],
	[WoodfordLastUpdate],
	[MatrixLastUpdate],
	[StartDateTime],
	[EndDateTime],
	[IsActive],
	[AccCalculatedPriority],
	[AccIsKeyAccount],
	[RegionId],
	--[AccSalesforceId_15],
	[IsConfirmRequired],
	[JoinGUID],
	[CADIS_SYSTEM_INSERTED],
	[CADIS_SYSTEM_UPDATED],
	[CADIS_SYSTEM_CHANGEDBY], 
	[CADIS_SYSTEM_PRIORITY],
	--[CADIS_SYSTEM_TIMESTAMP],
	[CADIS_SYSTEM_LASTMODIFIED]
FROM @WFAccount



/*************************************************************
******* ACCOUNT ADDRESS
**************************************************************/
DECLARE @WFAddress TABLE (
	[SfAccountId] varchar(100),
	[AddrStreet] [nvarchar](100) NULL,
	[AddrCity] [nvarchar](100) NULL,
	[AddrPostcode] [nvarchar](20) NULL,
	[AddrCountry] [nvarchar](100) NULL,
	[WoodfordLastUpdate] [datetime] NULL,
	[MatrixLastUpdate] [datetime] NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL)


INSERT INTO @WFAddress 
SELECT 
AO.SfAccountId,
AO.BillingStreet,
AO.BillingCity,
AO.BillingPostcode,
AO.BillingCountry,
getdate() AS WoodfordLastUpdate,
getdate() AS MatrixLastUpdate,
getdate() AS StartDateTime,
'2099-12-31T00:00:00'	AS EndDateTime, 	
1 AS IsActive
FROM [Staging.Salesforce.BP].[SalesteamAccountOverrides] AO
JOIN @WFAccount ACC
ON AO.SfAccountId = ACC.AccSalesforceId


---------------------------
-- UPDATE MANY-TO-MANY Account Address information
---------------------------

UPDATE  AA
SET AA.accountid = WA.Id
FROM [Sales.BP].WoodfordAccount WA
JOIN @WFAccount WF
ON	  WA.AccSalesforceId = WF.AccSalesforceId
AND	  WA.AccMatrixOutletId = WF.AccMatrixOutletId
AND   WA.AccFcaId = WF.AccFcaId
AND   WA.IsActive = 1
JOIN [Sales.BP].[WoodfordAccountAddress] AA
ON	 AA.AccountId = WF.Id  
AND	AA.IsActive = 1

UPDATE AD SET 
AD.AddrStreet = WFA.AddrStreet, 
AD.AddrCity = WFA.AddrCity, 
AD.AddrPostcode = WFA.AddrPostcode, 
AD.AddrCountry = WFA.AddrCountry,
AD.WoodfordLastUpdate = WFA.WoodfordLastUpdate,
AD.MatrixLastUpdate = WFA.MatrixLastUpdate,
AD.StartDateTime = WFA.StartDateTime,
AD.EndDateTime = WFA.EndDateTime
FROM [Sales.BP].[WoodfordAddress] AD
JOIN [Sales.BP].[WoodfordAccountAddress] AA
ON AD.Id = AA.AddressId
JOIN [Sales.BP].WoodfordAccount WA
ON WA.Id = AA.AccountId
AND WA.IsActive = 1
JOIN @WFAddress WFA
ON WFA.SfAccountId = WA.AccSalesforceId
AND WA.IsActive = 1



-------------------------------
-- PUT CLEARDOWN HERE
-------------------------------
    
COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;
    
    
    

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH    
    
    
