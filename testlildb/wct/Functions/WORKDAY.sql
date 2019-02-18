CREATE FUNCTION [wct].[WORKDAY]
(@Holiday_TableName NVARCHAR (4000) NULL, @HolidayDates_ColumnName NVARCHAR (4000) NULL, @GroupedColumnName NVARCHAR (4000) NULL, @GroupedColumnValue SQL_VARIANT NULL, @StartDate DATETIME NULL, @Days INT NULL)
RETURNS DATETIME
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[WORKDAY]

