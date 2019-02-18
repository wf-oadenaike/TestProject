CREATE FUNCTION [wct].[TTEST_q]
(@Sample1_RangeQuery NVARCHAR (MAX) NULL, @Sample2_RangeQuery NVARCHAR (MAX) NULL, @Tails INT NULL, @Ttype INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[TTEST_q]

