CREATE FUNCTION [wct].[KENDALLT_TV]
(@x_y_Query NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [Tau_b] FLOAT (53) NULL,
        [Zb]    FLOAT (53) NULL,
        [Pb]    FLOAT (53) NULL,
        [SDb]   FLOAT (53) NULL,
        [Tau_a] FLOAT (53) NULL,
        [Za]    FLOAT (53) NULL,
        [Pa]    FLOAT (53) NULL,
        [SDa]   FLOAT (53) NULL,
        [C]     FLOAT (53) NULL,
        [D]     FLOAT (53) NULL,
        [S]     FLOAT (53) NULL,
        [T]     FLOAT (53) NULL,
        [U]     FLOAT (53) NULL,
        [N]     FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[KENDALLT_TV]

