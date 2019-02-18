﻿CREATE FUNCTION [wct].[LPMT]
(@PV FLOAT (53) NULL, @LoanDate DATETIME NULL, @Rate FLOAT (53) NULL, @FirstPayDate DATETIME NULL, @NumPmts INT NULL, @Pmtpyr INT NULL, @DaysInYr FLOAT (53) NULL, @FV FLOAT (53) NULL, @IntRule NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[LPMT]
