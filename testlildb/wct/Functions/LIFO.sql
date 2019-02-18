CREATE FUNCTION [wct].[LIFO]
(@Qty FLOAT (53) NULL, @Cost FLOAT (53) NULL, @RV NVARCHAR (4000) NULL, @Round INT NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[LIFO]

