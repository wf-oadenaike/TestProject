CREATE FUNCTION [wct].[Modulo]
(@Number FLOAT (53) NULL, @Divisor FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[Modulo]

