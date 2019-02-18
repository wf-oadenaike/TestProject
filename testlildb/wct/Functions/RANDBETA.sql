CREATE FUNCTION [wct].[RANDBETA]
(@Rows INT NULL, @a FLOAT (53) NULL, @b FLOAT (53) NULL)
RETURNS 
     TABLE (
        [Seq] INT        NULL,
        [X]   FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RANDBETA]

