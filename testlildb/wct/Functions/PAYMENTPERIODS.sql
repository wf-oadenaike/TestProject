CREATE FUNCTION [wct].[PAYMENTPERIODS]
(@ReferenceDate DATETIME NULL, @PaymentFrequency INT NULL, @PrevPayDate DATETIME NULL, @StartDate DATETIME NULL, @FirstPayDate DATETIME NULL, @InterimGracePeriodStartDate DATETIME NULL, @InterimGracePeriodEndDate DATETIME NULL, @MaturityDate DATETIME NULL)
RETURNS 
     TABLE (
        [InitialGracePeriod]           INT NULL,
        [InterimGracePeriodMonthStart] INT NULL,
        [InterimGracePeriodMonthEnd]   INT NULL,
        [MonthsUntilFirstPayment]      INT NULL,
        [InterimGracePeriod]           INT NULL,
        [NumberOfPayments]             INT NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PAYMENTPERIODS]

