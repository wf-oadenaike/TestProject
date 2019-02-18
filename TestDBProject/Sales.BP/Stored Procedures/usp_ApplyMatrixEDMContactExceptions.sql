CREATE PROCEDURE [Sales.BP].[usp_ApplyMatrixEDMContactExceptions] AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_GenerateSalesforceMatrixContactExceptions]
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

DECLARE @Today varchar(100)

BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_ApplyMatrixEDMContactExceptions]';

BEGIN TRANSACTION

DECLARE @WFContact TABLE (
[CntFcaId] [char](8) NOT NULL,
[CntSalesforceId] [char](18) NULL,
[CntMatrixId] [char](5) NULL,
[CntSivId] [nvarchar](100) NULL,
[CntSalutation] [nvarchar](100) NULL,
[CntFirstName] [nvarchar](100) NULL,
[CntLastName] [nvarchar](100) NOT NULL,
[CntJobTitle] [nvarchar](100) NULL,
[CntLandline] [nvarchar](100) NULL,
[CntMobile] [nvarchar](100) NULL,
[CntFax] [nvarchar](100) NULL,
[CntEmail] [nvarchar](100) NULL,
[CntIsCf1] [bit] NOT NULL,
[CntIsCf2] [bit] NOT NULL,
[CntIsCf3] [bit] NOT NULL,
[CntIsCf4] [bit] NOT NULL,
[CntIsCf10] [bit] NOT NULL,
[CntIsCf11] [bit] NOT NULL,
[CntIsCf30] [bit] NOT NULL,
[WoodfordLastUpdate] [datetime] NULL,
[MatrixLastUpdate] [datetime] NULL,
[IsConfirmRequired] [bit] NOT NULL,
[IsReviewed] [bit] NOT NULL,
[StartDateTime] [datetime] NOT NULL,
[EndDateTime] [datetime] NOT NULL,
[IsActive] [bit] NOT NULL,
[ModifiedByPersonId] [smallint] NULL,
[JoinGUID] [uniqueidentifier] NULL,
[CADIS_SYSTEM_INSERTED] [datetime] NULL,
[CADIS_SYSTEM_UPDATED] [datetime] NULL,
[CADIS_SYSTEM_CHANGEDBY] [nvarchar](50) NULL,
[CADIS_SYSTEM_PRIORITY] [int] NULL,
--[CADIS_SYSTEM_TIMESTAMP] [timestamp] NOT NULL,
[CADIS_SYSTEM_LASTMODIFIED] [datetime] NULL)

INSERT INTO @WFContact
SELECT 
CO.FcaId, 
CO.sfContactId, 
CO.ContactMatrixId, 
WC.CntSivId,
WC.CntSalutation,
CO.FirstName, 
CO.LastName,
WC.CntJobTitle,
CO.Phone, 
CO.Mobile,
WC.CntFax, 
CO.emailAddress, 
WC.CntIsCf1,
WC.CntIsCf2,
WC.CntIsCf3,
WC.CntIsCf4,
WC.CntIsCf10,
WC.CntIsCf11,
WC.CntIsCf30,
getdate() AS WoodfordLastUpdate,
getdate()AS MatrixLastUpdate,
0 AS IsConfirmRequired,
0 AS IsReviewed,
getdate() AS StartDateTime,
'2099-12-31T00:00:00'	AS EndDateTime, 	
1 AS IsActive,
-1 AS ModifiedByPersonId,
WC.JoinGUID AS JoinGUID,
getdate()AS CADIS_SYSTEM_INSERTED,
getdate()AS CADIS_SYSTEM_UPDATED,
'EDM UI' AS CADIS_SYSTEM_CHANGEDBY,
0 AS CADIS_SYSTEM_PRIORITY,
getdate() AS CADIS_SYSTEM_LASTMODIFIED
FROM [Staging.Salesforce.BP].[SalesteamContactOverrides] CO
JOIN [Sales.BP].[WoodfordContact] WC
ON CO.FcaId = WC.CntFcaId
AND CO.ContactMatrixId = WC.CntMatrixId
AND WC.IsActive = 1


--- Set DW SCD flag to 0
UPDATE WC
SET WC.IsActive = '0', WC.EndDateTime = getdate()
--SELECT * 
FROM [Sales.BP].WoodfordContact WC
JOIN [Staging.Salesforce.BP].[SalesteamContactOverrides] CO
ON CO.sfContactId = WC.CntSalesforceId
AND CO.FcaId = WC.CntFcaId
AND CO.ContactMatrixId = WC.CntMatrixId
AND WC.IsActive = 1


INSERT INTO [Sales.BP].WoodfordContact(
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
--[CADIS_SYSTEM_TIMESTAMP] [timestamp] NOT NULL,
[CADIS_SYSTEM_LASTMODIFIED])
SELECT 
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
--[CADIS_SYSTEM_TIMESTAMP] [timestamp] NOT NULL,
[CADIS_SYSTEM_LASTMODIFIED]
FROM @WFContact


--- Readjust AccountContact relationship (Ian Code)

SELECT @Today = CONVERT(varchar(100), getdate(), 120) 

EXEC [Sales.BP].[usp_CloseOldAccCntRelationship] @Today, 'N'
EXEC [Sales.BP].[usp_OpenNewAccCntRelationship] @Today

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
    
