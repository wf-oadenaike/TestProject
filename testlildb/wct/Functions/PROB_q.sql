CREATE FUNCTION [wct].[PROB_q]
(@Prob_range_X_range_RangeQuery NVARCHAR (MAX) NULL, @Lower_limit FLOAT (53) NULL, @Upper_limit FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PROB_q]

