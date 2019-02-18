CREATE FUNCTION [wct].[FIND]
(@Find_text NVARCHAR (MAX) NULL, @Within_text NVARCHAR (MAX) NULL, @Start INT NULL)
RETURNS INT
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[FIND]

