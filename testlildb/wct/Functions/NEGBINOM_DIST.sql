CREATE FUNCTION [wct].[NEGBINOM_DIST]
(@Number_f INT NULL, @Number_s INT NULL, @Probability_s FLOAT (53) NULL, @Cumulative BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[NEGBINOM_DIST]

