CREATE FUNCTION [wct].[NSCOEF2]
(@YieldCurve_RangeQuery NVARCHAR (MAX) NULL, @NumSteps INT NULL, @Tau_min FLOAT (53) NULL, @Tau_max FLOAT (53) NULL, @B0_min FLOAT (53) NULL, @B0_max FLOAT (53) NULL, @B1_min FLOAT (53) NULL, @B1_max FLOAT (53) NULL, @B2_min FLOAT (53) NULL, @B2_max FLOAT (53) NULL)
RETURNS 
     TABLE (
        [B0]   FLOAT (53) NULL,
        [B1]   FLOAT (53) NULL,
        [B2]   FLOAT (53) NULL,
        [Tau]  FLOAT (53) NULL,
        [RMSE] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[NSCOEF2]

