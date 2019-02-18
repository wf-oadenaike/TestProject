CREATE FUNCTION [wct].[MovingFORECAST]
(@New_x FLOAT (53) NULL, @Y FLOAT (53) NULL, @X FLOAT (53) NULL, @Offset INT NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[MovingFORECAST]

