CREATE FUNCTION [wct].[PERMUT]
(@Number FLOAT (53) NULL, @Number_chosen FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PERMUT]

