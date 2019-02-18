CREATE FUNCTION [wct].[RunningSHARPE]
(@R FLOAT (53) NULL, @Rf FLOAT (53) NULL, @Scale FLOAT (53) NULL, @Prices BIT NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[RunningSHARPE]

