CREATE FUNCTION [wct].[IRR_q]
(@Cashflows_RangeQuery NVARCHAR (MAX) NULL, @Guess FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[IRR_q]

