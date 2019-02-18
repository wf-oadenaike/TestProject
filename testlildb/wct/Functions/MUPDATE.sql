CREATE FUNCTION [wct].[MUPDATE]
(@A NVARCHAR (MAX) NULL, @start_row_A INT NULL, @end_row_A INT NULL, @start_col_A INT NULL, @end_col_A INT NULL, @EOperator NVARCHAR (4000) NULL, @B NVARCHAR (MAX) NULL, @start_row_B INT NULL, @end_row_B INT NULL, @start_col_B INT NULL, @end_col_B INT NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MUPDATE]

