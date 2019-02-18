CREATE FUNCTION [wct].[NSCOEF]
(@YieldCurve_RangeQuery NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [B0]   FLOAT (53) NULL,
        [B1]   FLOAT (53) NULL,
        [B2]   FLOAT (53) NULL,
        [Tau]  FLOAT (53) NULL,
        [RMSE] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[NSCOEF]

