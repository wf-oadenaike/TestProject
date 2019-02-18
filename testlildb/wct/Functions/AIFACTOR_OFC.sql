﻿CREATE FUNCTION [wct].[AIFACTOR_OFC]
(@Basis NVARCHAR (4000) NULL, @Rate FLOAT (53) NULL, @IssueDate DATETIME NULL, @Settlement DATETIME NULL, @FirstInterestDate DATETIME NULL, @Frequency INT NULL, @Holidays NVARCHAR (MAX) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[AIFACTOR_OFC]

