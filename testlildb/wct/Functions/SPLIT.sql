CREATE FUNCTION [wct].[SPLIT]
(@SourceString NVARCHAR (MAX) NULL, @Delimiter NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [item] NVARCHAR (MAX) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[SPLIT]

