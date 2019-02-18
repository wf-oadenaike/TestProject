﻿CREATE FUNCTION [wct].[AMORTRATE]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Rate FLOAT (53) NULL, @FaceAmount FLOAT (53) NULL, @CleanPrice FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL, @IssueDate DATETIME NULL, @FirstInterestDate DATETIME NULL, @LastInterestDate DATETIME NULL, @Holidays NVARCHAR (MAX) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[AMORTRATE]

