CREATE FUNCTION [wct].[RANDFDIST]
(@Rows INT NULL, @df1 FLOAT (53) NULL, @df2 FLOAT (53) NULL)
RETURNS 
     TABLE (
        [Seq] INT        NULL,
        [X]   FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RANDFDIST]

