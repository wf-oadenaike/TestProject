CREATE FUNCTION [wct].[LINEST_q]
(@Matrix_RangeQuery NVARCHAR (MAX) NULL, @Y_ColumnNumber INT NULL, @Lconst BIT NULL)
RETURNS 
     TABLE (
        [stat_name] NVARCHAR (10)  NULL,
        [idx]       INT            NULL,
        [stat_val]  FLOAT (53)     NULL,
        [col_name]  NVARCHAR (128) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[LINEST_q]

