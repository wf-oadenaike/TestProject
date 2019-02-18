  
  
CREATE PROCEDURE [Sales.BP].[usp_InsertSalesforceMatrixNewAccounts]  
  
AS  
--------------------------------------------------------------------------------------   
-- Name: [Sales.BP].usp_InsertSalesforceMatrixNewAccounts  
--   
-- Params:   
--   
--------------------------------------------------------------------------------------   
-- History:  
-- WHO WHEN WHY  
-- R.Dixon: 18/09/2017 JIRA: DAP-1290 set MakeContact to 0 when inserting records  
-- R.Dixon: 05/10/2017 JIRA: DAP-1289 added SalesFromDate and SalesToDate fields  
-- A.Cogorno 1/5/2018 JIRA DAP-1420 added a table to copy data to a 'GC' table. This can be uesed to check against user changes to send slack messages  
-- R.Dixon: 19/03/18 JIRA: DAP-1877 remove drop and create of [Sales.BP].[NewAccountOverride_GC] to truncate table and re-populate.  
--------------------------------------------------------------------------------------   
BEGIN TRY  
SET NOCOUNT ON;  
SET XACT_ABORT ON;  
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_InsertSalesforceMatrixNewAccounts]'  
BEGIN TRANSACTION  
  
INSERT [Sales.BP].NewAccountOverride  
  (MatrixOutletId,   
  AccountName,   
  AccountFcaId,   
  AccountOwnerId,   
  BillingCity,   
  BillingPostCode,   
  TotalOwnSales,   
  TotalMarketSales,   
  EquityIncomeOwnSales,   
  EquityIncomeMarketSales,   
  SpecialistSectorOwnSales,   
  SpecialistSectorMarketSales,   
  SalesFromDate,  
  SalesToDate,  
  MakeContact,  
  OverrideStatus)  
  
SELECT EX.[matrix_outlet_id],  
  EX.[Accountname],  
  EX.[AccountFcaId],  
  EX.[AccountOwnerId],  
  EX.[Billingcity],  
  EX.[BillingPostCode],  
  EX.[Total Account Sales],  
  EX.[Total Market Sales],  
  EX.[Equity Income Account Sales],  
  EX.[Equity Income Market Sales],  
  EX.[Specialist Sector Account Sales],  
  EX.[Specialist Sector Market Sales],  
  EX.[FC_From_Date],  
  EX.[FC_To_Date],  
  0,  
  'Raised'  
FROM [Sales.BP].[ExceptionsNewAccountsVw] EX  
LEFT OUTER JOIN [Sales.BP].NewAccountOverride NAO  
ON  NAO.[MatrixOutletId] = EX.[matrix_outlet_id]  
WHERE NAO.[MatrixOutletId] IS NULL  
  
TRUNCATE TABLE [Sales.BP].[NewAccountOverride_GC]  
  
INSERT INTO [Sales.BP].[NewAccountOverride_GC]  
  (MatrixOutletId,  
  AccountName,  
  AccountFcaId,  
  AccountOwnerId,  
  BillingCity,  
  BillingPostCode,  
  TotalOwnSales,  
  TotalMarketSales,  
  EquityIncomeOwnSales,  
  EquityIncomeMarketSales,  
  SpecialistSectorOwnSales,  
  SpecialistSectorMarketSales,  
  SalesFromDate,  
  SalesToDate,  
  MakeContact,  
  OverrideStatus,  
  CADIS_SYSTEM_INSERTED,  
  CADIS_SYSTEM_UPDATED,  
  CADIS_SYSTEM_CHANGEDBY)  
SELECT MatrixOutletId,  
  AccountName,  
  AccountFcaId,  
  AccountOwnerId,  
  BillingCity,  
  BillingPostCode,  
  TotalOwnSales,  
  TotalMarketSales,  
  EquityIncomeOwnSales,  
  EquityIncomeMarketSales,  
  SpecialistSectorOwnSales,  
  SpecialistSectorMarketSales,  
  SalesFromDate,  
  SalesToDate,  
  MakeContact,  
  OverrideStatus,  
  CADIS_SYSTEM_INSERTED,  
  CADIS_SYSTEM_UPDATED,  
  CADIS_SYSTEM_CHANGEDBY  
FROM [Sales.BP].NewAccountOverride  
  
COMMIT TRANSACTION  
END TRY  
BEGIN CATCH  
IF @@TRANCOUNT > 0  
ROLLBACK TRANSACTION;  
  
  
-- Write errors to table: dbo.LogProcErrors  
EXECUTE dbo.usp_LogProcErrors  
  
END CATCH  
  