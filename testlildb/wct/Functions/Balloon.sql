CREATE FUNCTION [wct].[Balloon]
(@OutstandingAmount FLOAT (53) NULL, @InterestBasis NVARCHAR (4000) NULL, @InterestRate FLOAT (53) NULL, @PaymentFrequency INT NULL, @MaturityDate DATETIME NULL, @ReferenceDate DATETIME NULL, @PrevPayDate DATETIME NULL, @StartDate DATETIME NULL, @FirstPayDate DATETIME NULL, @GracePeriodStartDate DATETIME NULL, @GracePeriodEndDate DATETIME NULL)
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
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[Balloon]

