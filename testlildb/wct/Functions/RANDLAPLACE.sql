CREATE FUNCTION [wct].[RANDLAPLACE]
(@Rows INT NULL, @Location FLOAT (53) NULL, @Scale FLOAT (53) NULL)
RETURNS 
     TABLE (
        [Seq] INT        NULL,
        [X]   FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RANDLAPLACE]

