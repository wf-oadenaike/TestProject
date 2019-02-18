CREATE FUNCTION [wct].[ConstantPrincipalRate]
(@OutstandingAmount FLOAT (53) NULL, @InterestBasis NVARCHAR (4000) NULL, @InterestRate FLOAT (53) NULL, @FreqPayPrincipal INT NULL, @FreqPayInterest INT NULL, @AmortizationRate FLOAT (53) NULL, @MinimumPayment FLOAT (53) NULL, @ReferenceDate DATETIME NULL, @PrevPrincipalPayDate DATETIME NULL, @PrevInterestPayDate DATETIME NULL, @StartDate DATETIME NULL, @FirstPrincipalPayDate DATETIME NULL, @FirstInterestPayDate DATETIME NULL, @PrincipalGracePeriodStartDate DATETIME NULL, @PrincipalGracePeriodEndDate DATETIME NULL, @InterestGracePeriodStartDate DATETIME NULL, @InterestGracePeriodEndDate DATETIME NULL)
RETURNS 
     TABLE (
        [Period]              INT        NULL,
        [PrincipalPayment]    FLOAT (53) NULL,
        [InterestPayment]     FLOAT (53) NULL,
        [CashFlow]            FLOAT (53) NULL,
        [OutstandingExposure] FLOAT (53) NULL,
        [CapitalAmountInDebt] FLOAT (53) NULL,
        [TotalExposure]       FLOAT (53) NULL,
        [NumberOfMonth]       INT        NULL,
        [PaymentDate]         DATETIME   NULL,
        [GraceInterest]       FLOAT (53) NULL,
        [InterestRate]        FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[ConstantPrincipalRate]

