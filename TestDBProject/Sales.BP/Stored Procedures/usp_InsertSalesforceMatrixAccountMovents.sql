
CREATE PROCEDURE [Sales.BP].[usp_InsertSalesforceMatrixAccountMovents]

AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_InsertSalesforceMatrixAccountMovents]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 08/06/2017 JIRA: DAP-867 Inserts Account Movements into FCAccountMovementOverride table
-- R.Dixon: 18/09/2017 JIRA: DAP-1290 set MakeContact to 0 when inserting records
-- R.Dixon: 27/09/2017 JIRA: DAP-1374 Populate post code field
-- R.Dixon: 05/10/2017 JIRA: DAP-1289 populate SalesFromDate and SalesToDate
-- V.Khatri: 08/05/2018 Jira: DAP-1753 Added extra fields to highlight exceptions
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_InsertSalesforceMatrixAccountMovents]'
BEGIN TRANSACTION

INSERT [Sales.BP].FCAccountMovementOverride
		(SfAccountId,
		Sector,
		AccountName,
		SalesforceHyperlink,
		PostCode,
		AccountOwnerId,
		IsPriorityClient,
		CurrOutletOwnSales,
		PrevOutletOwnSales,
		SalesMoveValue,
		CurrOutletMarketSales,
		PrevOutletMarketSales,
		CurrMktShare,
		PrevMktShare,
		MktShareMoveValue,
		SalesFromDate,
		SalesToDate,
		MakeContact,
		OverrideStatus)
SELECT	V.[SfAccountId],
		V.[Sector],
		V.[AccountName],
		REF.[URL] + V.[SfAccountId],
		SF.[BillingPostcode],
		V.[AccountOwnerId],
		V.[IsPriorityClient],
		V.[CurrOutletOwnSales],
		V.[PrevOuletOwnSales],
		V.[SalesMoveValue],
		V.[CurrOutletMarketSales],
		V.[PrevOuletMarketSales],
		V.[CurrMktShare],
		V.[PrevMktShare],
		V.[MktShareMoveValue],
		V.[PrevDate],
		V.[currDate],
		0,
		'Raised'
FROM	[Sales.BP].[FCMovementsAllVw] V
LEFT	OUTER JOIN [Sales.BP].FCAccountMovementOverride OV
ON		OV.SfAccountId = V.sfaccountid
LEFT	OUTER JOIN [Sales.BP].SfAccountvw SF
ON		SF.sfaccountid = v.sfaccountid 
LEFT	OUTER JOIN CADIS_SYS.CO_DBPARM DBP
ON		DBP.NAME = 'EnvironmentDescription'
LEFT	OUTER JOIN dbo.T_REF_SF_URL REF
ON		REF.ENV = DBP.[value]
WHERE	OV.SfAccountId IS NULL

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH
