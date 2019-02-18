CREATE FUNCTION [wct].[RelativeError]
(@TrueValue FLOAT (53) NULL, @MeasuredValue FLOAT (53) NULL, @NullReturnValue FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RelativeError]

