CREATE FUNCTION [wct].[LOGIT]
(@Matrix_RangeQuery NVARCHAR (MAX) NULL, @y_ColumnNumber INT NULL)
RETURNS 
     TABLE (
        [stat_name] NVARCHAR (10) NULL,
        [idx]       INT           NULL,
        [stat_val]  FLOAT (53)    NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[LOGIT]

