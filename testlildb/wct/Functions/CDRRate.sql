CREATE FUNCTION [wct].[CDRRate]
(@PrinAmt FLOAT (53) NULL, @InterestRate FLOAT (53) NULL, @NumPmts INT NULL, @LastPmtNum INT NULL, @PmtPerYr INT NULL, @CPRRatesQuery NVARCHAR (MAX) NULL, @DefAmt FLOAT (53) NULL, @InterestOnly BIT NULL, @PrinPaymentMultiple INT NULL, @FirstPrinPayNo INT NULL, @PmtPayPct FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CDRRate]

