CREATE FUNCTION [wct].[LUdecomp_q]
(@Matrix_RangeQuery NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [RowNum] INT          NULL,
        [ColNum] INT          NULL,
        [Value]  FLOAT (53)   NULL,
        [Type]   NVARCHAR (2) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[LUdecomp_q]

