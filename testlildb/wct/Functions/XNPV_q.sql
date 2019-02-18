CREATE FUNCTION [wct].[XNPV_q]
(@Rate FLOAT (53) NULL, @CashFlows_RangeQuery NVARCHAR (MAX) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[XNPV_q]

