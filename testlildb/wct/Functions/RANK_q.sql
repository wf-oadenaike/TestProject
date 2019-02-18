CREATE FUNCTION [wct].[RANK_q]
(@Number FLOAT (53) NULL, @Values_RangeQuery NVARCHAR (MAX) NULL, @Order FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RANK_q]

