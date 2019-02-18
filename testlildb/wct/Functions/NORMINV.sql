CREATE FUNCTION [wct].[NORMINV]
(@Probability FLOAT (53) NULL, @Mean FLOAT (53) NULL, @Standard_dev FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[NORMINV]

