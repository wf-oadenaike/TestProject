CREATE FUNCTION [wct].[KAPPA_FLEISS_TV]
(@InputData_RangeQuery NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [Rating] SQL_VARIANT NULL,
        [Z]      FLOAT (53)  NULL,
        [K]      FLOAT (53)  NULL,
        [P]      FLOAT (53)  NULL,
        [SE]     FLOAT (53)  NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[KAPPA_FLEISS_TV]

