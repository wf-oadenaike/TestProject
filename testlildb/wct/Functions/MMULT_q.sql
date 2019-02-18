CREATE FUNCTION [wct].[MMULT_q]
(@Matrix_A_RangeQuery NVARCHAR (MAX) NULL, @Matrix_B_RangeQuery NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [RowNum]    INT        NULL,
        [ColNum]    INT        NULL,
        [ItemValue] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MMULT_q]

