CREATE FUNCTION [wct].[CDRCashflowDCF]
(@DiscRate FLOAT (53) NULL, @PrinAmt FLOAT (53) NULL, @InterestRate FLOAT (53) NULL, @NumPmts INT NULL, @LastPmtNum INT NULL, @PmtPerYr INT NULL, @LSRatesQuery NVARCHAR (MAX) NULL, @CPRRatesQuery NVARCHAR (MAX) NULL, @CDRRatesQuery NVARCHAR (MAX) NULL, @InterestOnly BIT NULL, @PrinPaymentMultiple INT NULL, @FirstPrinPayNo INT NULL, @PmtPayPct FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CDRCashflowDCF]

