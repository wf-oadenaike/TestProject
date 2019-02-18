﻿CREATE FUNCTION [wct].[PMTSCHED]
(@PV FLOAT (53) NULL, @pmt FLOAT (53) NULL, @NumPmts INT NULL, @FV FLOAT (53) NULL, @Pay_type FLOAT (53) NULL)
RETURNS 
     TABLE (
        [num_pmt]       INT        NULL,
        [amt_prin_init] FLOAT (53) NULL,
        [amt_int_pay]   FLOAT (53) NULL,
        [amt_prin_pay]  FLOAT (53) NULL,
        [amt_prin_end]  FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PMTSCHED]

