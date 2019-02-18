CREATE FUNCTION [wct].[WMPSR_TV]
(@x_y_Query NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [W]  FLOAT (53) NULL,
        [Z]  FLOAT (53) NULL,
        [PL] FLOAT (53) NULL,
        [PG] FLOAT (53) NULL,
        [P2] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[WMPSR_TV]

