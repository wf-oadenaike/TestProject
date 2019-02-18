CREATE FUNCTION [wct].[VDB]
(@Cost FLOAT (53) NULL, @Salvage FLOAT (53) NULL, @Life FLOAT (53) NULL, @Start_period FLOAT (53) NULL, @End_period FLOAT (53) NULL, @Factor FLOAT (53) NULL, @No_switch BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[VDB]

