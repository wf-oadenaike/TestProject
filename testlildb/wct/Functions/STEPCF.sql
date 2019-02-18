CREATE FUNCTION [wct].[STEPCF]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Steps NVARCHAR (MAX) NULL, @Yield FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL, @Issue DATETIME NULL, @FirstCoupon DATETIME NULL, @LastCoupon DATETIME NULL)
RETURNS 
     TABLE (
        [date_pmt]     DATETIME   NULL,
        [amt_cashflow] FLOAT (53) NULL,
        [N]            FLOAT (53) NULL,
        [PVF]          FLOAT (53) NULL,
        [PVCF]         FLOAT (53) NULL,
        [cumPVCF]      FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[STEPCF]

