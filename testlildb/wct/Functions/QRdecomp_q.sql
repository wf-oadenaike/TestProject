CREATE FUNCTION [wct].[QRdecomp_q]
(@Matrix_RangeQuery NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [Matrix]    NVARCHAR (2) NULL,
        [RowNum]    INT          NULL,
        [ColNum]    INT          NULL,
        [ItemValue] FLOAT (53)   NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[QRdecomp_q]

