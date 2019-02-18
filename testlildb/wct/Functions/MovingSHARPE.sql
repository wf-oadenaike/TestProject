CREATE FUNCTION [wct].[MovingSHARPE]
(@R FLOAT (53) NULL, @Rf FLOAT (53) NULL, @Scale FLOAT (53) NULL, @Prices BIT NULL, @Offset INT NULL, @RowNum INT NULL, @Id TINYINT NULL, @Exact BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[MovingSHARPE]

