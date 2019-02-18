CREATE FUNCTION [wct].[CHISQ_DIST]
(@X FLOAT (53) NULL, @Degrees_freedom FLOAT (53) NULL, @Cumulative BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CHISQ_DIST]

