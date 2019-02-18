CREATE FUNCTION [wct].[TRUNC]
(@Number FLOAT (53) NULL, @Num_digits FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[TRUNC]

