﻿CREATE FUNCTION [wct].[LASTWEEKDAY]
(@StartDate DATETIME NULL, @DayofWeek NVARCHAR (4000) NULL)
RETURNS DATETIME
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[LASTWEEKDAY]
