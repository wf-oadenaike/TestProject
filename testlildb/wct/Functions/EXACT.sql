﻿CREATE FUNCTION [wct].[EXACT]
(@Text1 NVARCHAR (MAX) NULL, @Text2 NVARCHAR (MAX) NULL, @CaseSensitive BIT NULL)
RETURNS BIT
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[EXACT]
