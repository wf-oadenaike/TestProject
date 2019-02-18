CREATE FUNCTION [wct].[LogNormalIRLattice]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Rate SQL_VARIANT NULL, @Spread FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency INT NULL, @Basis NVARCHAR (4000) NULL, @LastCouponDate DATETIME NULL, @FirstCouponDate DATETIME NULL, @IssueDate DATETIME NULL, @CCZero NVARCHAR (MAX) NULL, @CurveType NVARCHAR (4000) NULL, @TradeDate DATETIME NULL, @CurveDayCount NVARCHAR (4000) NULL, @Notice INT NULL, @CurveInterpMethod NVARCHAR (4000) NULL, @Vol FLOAT (53) NULL, @OptionSched NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [date_step]       DATETIME   NULL,
        [num_step]        INT        NULL,
        [num_node]        INT        NULL,
        [rate_fwd]        FLOAT (53) NULL,
        [rate_calibrated] FLOAT (53) NULL,
        [T]               FLOAT (53) NULL,
        [delta]           FLOAT (53) NULL,
        [df]              FLOAT (53) NULL,
        [df_calibrated]   FLOAT (53) NULL,
        [cczero]          FLOAT (53) NULL,
        [PVCF]            FLOAT (53) NULL,
        [coupon]          FLOAT (53) NULL,
        [price_call]      FLOAT (53) NULL,
        [price_put]       FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[LogNormalIRLattice]

