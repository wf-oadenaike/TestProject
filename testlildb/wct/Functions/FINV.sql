CREATE FUNCTION [wct].[FINV]
(@Probability FLOAT (53) NULL, @Degrees_freedom1 FLOAT (53) NULL, @Degrees_freedom2 FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[FINV]

