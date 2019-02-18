CREATE FUNCTION [wct].[KMEANS]
(@dataQuery NVARCHAR (MAX) NULL, @meansQuery NVARCHAR (MAX) NULL, @numclusters INT NULL, @nstart INT NULL, @algorithm NVARCHAR (4000) NULL, @itermax INT NULL, @seed INT NULL, @Formula NVARCHAR (MAX) NULL)
RETURNS 
     TABLE (
        [label] NVARCHAR (15) NULL,
        [rowid] SQL_VARIANT   NULL,
        [colid] SQL_VARIANT   NULL,
        [val]   FLOAT (53)    NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[KMEANS]

