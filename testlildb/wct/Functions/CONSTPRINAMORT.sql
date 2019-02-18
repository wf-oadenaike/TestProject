CREATE FUNCTION [wct].[CONSTPRINAMORT]
(@PV FLOAT (53) NULL, @Rate FLOAT (53) NULL, @LoanDate DATETIME NULL, @NumPmtsPerYear INT NULL, @FirstPaymentDate DATETIME NULL, @DaysInYr INT NULL, @NumberOfPayments INT NULL, @LastPaymentNumber INT NULL, @FirstPrinPayNo INT NULL, @FV FLOAT (53) NULL, @PPMT FLOAT (53) NULL, @eom BIT NULL)
RETURNS 
     TABLE (
        [num_pmt]       INT        NULL,
        [date_pmt]      DATETIME   NULL,
        [amt_prin_init] FLOAT (53) NULL,
        [amt_pmt]       FLOAT (53) NULL,
        [amt_int_pay]   FLOAT (53) NULL,
        [amt_prin_pay]  FLOAT (53) NULL,
        [amt_prin_end]  FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CONSTPRINAMORT]

