CREATE FUNCTION [wct].[FLOOR]
(@Number FLOAT (53) NULL, @Significance FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[FLOOR]

