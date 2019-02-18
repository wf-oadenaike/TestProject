CREATE FUNCTION [wct].[XIRR2005]
(@CashFlows_TableName NVARCHAR (MAX) NULL, @CashFlows_ColumnName NVARCHAR (4000) NULL, @CashFlows_GroupedColumnName NVARCHAR (4000) NULL, @CashFlows_GroupedColumnValue SQL_VARIANT NULL, @CashFlowDates_ColumnName NVARCHAR (4000) NULL, @Guess FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[XIRR2005]

