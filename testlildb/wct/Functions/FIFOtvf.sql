CREATE FUNCTION [wct].[FIFOtvf]
(@DataQuery NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [ID]    SQL_VARIANT NULL,
        [QTY]   FLOAT (53)  NULL,
        [EB]    FLOAT (53)  NULL,
        [GM]    FLOAT (53)  NULL,
        [COGS]  FLOAT (53)  NULL,
        [UP]    FLOAT (53)  NULL,
        [LP]    FLOAT (53)  NULL,
        [COGSC] FLOAT (53)  NULL,
        [GMC]   FLOAT (53)  NULL,
        [GMP]   FLOAT (53)  NULL,
        [CGMP]  FLOAT (53)  NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[FIFOtvf]

