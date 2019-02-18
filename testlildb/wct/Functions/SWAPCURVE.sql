CREATE FUNCTION [wct].[SWAPCURVE]
(@InputData_RangeQuery NVARCHAR (MAX) NULL, @StartDate DATETIME NULL, @Frequency FLOAT (53) NULL, @SpotDate DATETIME NULL, @CashBasis NVARCHAR (4000) NULL, @FuturesBasis NVARCHAR (4000) NULL, @SwapsBasis NVARCHAR (4000) NULL, @Interpolation NVARCHAR (4000) NULL, @DateRoll NVARCHAR (4000) NULL, @Holidays NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [mat_date] DATETIME   NULL,
        [df]       FLOAT (53) NULL,
        [rsource]  NCHAR (3)  NULL,
        [zero_cpn] FLOAT (53) NULL,
        [cczero]   FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[SWAPCURVE]

