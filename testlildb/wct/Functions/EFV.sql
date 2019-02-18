CREATE FUNCTION [wct].[EFV]
(@StartPer FLOAT (53) NULL, @Per FLOAT (53) NULL, @EndPer FLOAT (53) NULL, @CashflowRate FLOAT (53) NULL, @EndRate FLOAT (53) NULL, @Cashflow FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[EFV]

