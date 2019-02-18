CREATE FUNCTION [wct].[RANDPOISSON]
(@Rows INT NULL, @lambda FLOAT (53) NULL)
RETURNS 
     TABLE (
        [Seq] INT NULL,
        [X]   INT NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RANDPOISSON]

