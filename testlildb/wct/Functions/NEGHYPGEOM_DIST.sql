CREATE FUNCTION [wct].[NEGHYPGEOM_DIST]
(@num_trials FLOAT (53) NULL, @num_success FLOAT (53) NULL, @pop_success FLOAT (53) NULL, @pop_size FLOAT (53) NULL, @Cumulative BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[NEGHYPGEOM_DIST]

