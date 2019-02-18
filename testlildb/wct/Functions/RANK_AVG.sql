CREATE FUNCTION [wct].[RANK_AVG]
(@x_y_Query NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [x]     FLOAT (53) NULL,
        [y]     FLOAT (53) NULL,
        [xrank] FLOAT (53) NULL,
        [yrank] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RANK_AVG]

