CREATE FUNCTION [wct].[POLYFIT_q]
(@XY_RangeQuery NVARCHAR (MAX) NULL, @n INT NULL)
RETURNS 
     TABLE (
        [coe_num] INT        NULL,
        [coe_val] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[POLYFIT_q]

