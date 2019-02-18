CREATE FUNCTION [wct].[RANDCAUCHY]
(@Rows INT NULL, @mu FLOAT (53) NULL, @sig FLOAT (53) NULL)
RETURNS 
     TABLE (
        [Seq] INT        NULL,
        [X]   FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RANDCAUCHY]

