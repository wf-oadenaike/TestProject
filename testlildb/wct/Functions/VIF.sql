CREATE FUNCTION [wct].[VIF]
(@Matrix_RangeQuery NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [ColNum]    INT        NULL,
        [Rsquared]  FLOAT (53) NULL,
        [VIF]       FLOAT (53) NULL,
        [Tolerance] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[VIF]

