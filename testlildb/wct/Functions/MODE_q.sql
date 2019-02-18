CREATE FUNCTION [wct].[MODE_q]
(@Values_RangeQuery NVARCHAR (MAX) NULL, @Behavior FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MODE_q]

