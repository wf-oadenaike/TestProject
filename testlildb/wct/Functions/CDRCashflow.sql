CREATE FUNCTION [wct].[CDRCashflow]
(@PrinAmt FLOAT (53) NULL, @InterestRate FLOAT (53) NULL, @NumPmts INT NULL, @LastPmtNum INT NULL, @PmtPerYr INT NULL, @LSRatesQuery NVARCHAR (MAX) NULL, @CPRRatesQuery NVARCHAR (MAX) NULL, @CDRRatesQuery NVARCHAR (MAX) NULL, @InterestOnly BIT NULL, @PrinPaymentMultiple INT NULL, @FirstPrinPayNo INT NULL, @PmtPayPct FLOAT (53) NULL)
RETURNS 
     TABLE (
        [num_pmt]           INT        NULL,
        [CPR]               FLOAT (53) NULL,
        [CDR]               FLOAT (53) NULL,
        [LS]                FLOAT (53) NULL,
        [cont_prin_begin]   FLOAT (53) NULL,
        [cont_pmt]          FLOAT (53) NULL,
        [cont_int_pay]      FLOAT (53) NULL,
        [cont_prin_pay]     FLOAT (53) NULL,
        [cont_prin_end]     FLOAT (53) NULL,
        [proj_prin_begin]   FLOAT (53) NULL,
        [proj_pmt]          FLOAT (53) NULL,
        [proj_int_pay]      FLOAT (53) NULL,
        [proj_prin_pay]     FLOAT (53) NULL,
        [prin_prepay]       FLOAT (53) NULL,
        [amt_default]       FLOAT (53) NULL,
        [amt_loss_severity] FLOAT (53) NULL,
        [proj_prin_end]     FLOAT (53) NULL,
        [proj_amt_cashflow] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CDRCashflow]

