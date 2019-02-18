CREATE FUNCTION [wct].[MINVERSEN_q]
(@Matrix_RangeQuery NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [RowNum]    INT        NULL,
        [ColNum]    INT        NULL,
        [ItemValue] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MINVERSEN_q]

