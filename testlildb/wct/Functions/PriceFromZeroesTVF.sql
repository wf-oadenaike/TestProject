CREATE FUNCTION [wct].[PriceFromZeroesTVF]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Rate SQL_VARIANT NULL, @CurveSpread FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL, @LastCouponDate DATETIME NULL, @FirstCouponDate DATETIME NULL, @IssueDate DATETIME NULL, @CCZero NVARCHAR (MAX) NULL, @CurveType NVARCHAR (4000) NULL, @CurveStartDate DATETIME NULL, @CurveDayCount NVARCHAR (4000) NULL, @CurveFrequency INT NULL, @InterpMethod NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [date_pmt] DATETIME   NULL,
        [T]        FLOAT (53) NULL,
        [delta]    FLOAT (53) NULL,
        [cczero]   FLOAT (53) NULL,
        [spot]     FLOAT (53) NULL,
        [pvf]      FLOAT (53) NULL,
        [fwd]      FLOAT (53) NULL,
        [spread]   FLOAT (53) NULL,
        [df]       FLOAT (53) NULL,
        [cf]       FLOAT (53) NULL,
        [dcf]      FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PriceFromZeroesTVF]

