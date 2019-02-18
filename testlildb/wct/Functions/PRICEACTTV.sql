CREATE FUNCTION [wct].[PRICEACTTV]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Rate FLOAT (53) NULL, @Par FLOAT (53) NULL, @Yield FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL, @Repayments NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [date_pmt]     DATETIME   NULL,
        [amt_prin]     FLOAT (53) NULL,
        [amt_coupon]   FLOAT (53) NULL,
        [amt_prinpay]  FLOAT (53) NULL,
        [amt_cashflow] FLOAT (53) NULL,
        [DIP]          FLOAT (53) NULL,
        [DIY]          FLOAT (53) NULL,
        [t]            FLOAT (53) NULL,
        [DF]           FLOAT (53) NULL,
        [PVF]          FLOAT (53) NULL,
        [PVCF]         FLOAT (53) NULL,
        [cumPVCF]      FLOAT (53) NULL,
        [PVP]          FLOAT (53) NULL,
        [cumPVP]       FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PRICEACTTV]

