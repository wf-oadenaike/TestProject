CREATE FUNCTION [wct].[SPEARMAN_TV]
(@x_y_Query NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [R]  FLOAT (53) NULL,
        [P]  FLOAT (53) NULL,
        [T]  FLOAT (53) NULL,
        [DF] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[SPEARMAN_TV]

