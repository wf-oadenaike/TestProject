CREATE FUNCTION [wct].[RANDBINOM]
(@Rows INT NULL, @p FLOAT (53) NULL, @Trials INT NULL)
RETURNS 
     TABLE (
        [Seq] INT NULL,
        [X]   INT NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RANDBINOM]

