CREATE FUNCTION [wct].[XFV]
(@StartDate DATETIME NULL, @CashflowDate DATETIME NULL, @EndDate DATETIME NULL, @CashflowRate FLOAT (53) NULL, @EndRate FLOAT (53) NULL, @Cashflow FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[XFV]

