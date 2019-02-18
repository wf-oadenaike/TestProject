CREATE FUNCTION [wct].[ZTEST_q]
(@Values_RangeQuery NVARCHAR (MAX) NULL, @Test_value FLOAT (53) NULL, @Sigma FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[ZTEST_q]

