CREATE FUNCTION [wct].[AMORTIZECASHFLOWS]
(@CashFlows_RangeQuery NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [num_pmt]      INT        NULL,
        [date_pmt]     DATETIME   NULL,
        [pv_begin]     FLOAT (53) NULL,
        [amt_cashflow] FLOAT (53) NULL,
        [pv_end]       FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[AMORTIZECASHFLOWS]

