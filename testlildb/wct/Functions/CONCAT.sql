﻿CREATE FUNCTION [wct].[CONCAT]
(@Text1 NVARCHAR (MAX) NULL, @Joiner NVARCHAR (MAX) NULL, @Text2 NVARCHAR (MAX) NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CONCAT]

