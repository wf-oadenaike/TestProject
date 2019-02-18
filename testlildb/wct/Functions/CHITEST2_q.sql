CREATE FUNCTION [wct].[CHITEST2_q]
(@Actual_range_RangeQuery NVARCHAR (MAX) NULL, @Expected_range_RangeQuery NVARCHAR (MAX) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CHITEST2_q]

