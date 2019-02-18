CREATE FUNCTION [wct].[TRENDMX_q]
(@Matrix_RangeQuery NVARCHAR (MAX) NULL, @Y_ColumnNumber INT NULL, @New_x NVARCHAR (MAX) NULL, @Lconst BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[TRENDMX_q]

