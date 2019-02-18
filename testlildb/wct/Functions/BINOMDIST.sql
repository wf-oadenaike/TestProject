CREATE FUNCTION [wct].[BINOMDIST]
(@Number_s FLOAT (53) NULL, @Trials FLOAT (53) NULL, @Probability_s FLOAT (53) NULL, @Cumulative BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BINOMDIST]

