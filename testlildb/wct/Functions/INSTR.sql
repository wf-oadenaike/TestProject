﻿CREATE FUNCTION [wct].[INSTR]
(@Start INT NULL, @Text NVARCHAR (MAX) NULL, @SearchString NVARCHAR (MAX) NULL, @CaseSensitive BIT NULL)
RETURNS INT
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[INSTR]

