Create FUNCTION [Access.WebDev].[ufn_FinancialDashboardDepartmentMonthLines]
(
    @FinancialYear float 
)
RETURNS @OutputTable table
(
        FinancialFactId bigint NULL,
        FiscalYear int NULL,
        FiscalFirstDayOfYear date NULL,
        FiscalLastDayOfYear date NULL,
        DepartmentNumber smallint NULL,
        DepartmentName varchar(128) NULL,
        TransactionDate datetime NULL,
        Details varchar(255) NULL,
        Amount money NULL,
        Forecast money NULL,
        TransactionNo int NULL,
        AccountName varchar(128) NULL,
        AccountCategory nvarchar(128) NULL,
        TransactionTypeBK char(2) NULL,
		Supplier nvarchar(255) NULL,
		NominalCode int NULL,
		FinancialLineCode varchar(20) NULL,
		ProjectName varchar(255) NULL,
		IsDiscretionary int NULL,
		IsNonDiscretionary int NULL,
		AmountRaw money NULL,
		ControlDate datetime NULL,
		LastUpdatedDate datetime NULL,
		RE varchar(10) NULL
)
AS

BEGIN

Insert into @OutputTable (
FinancialFactId,
FiscalYear,
FiscalFirstDayOfYear,
FiscalLastDayOfYear,
DepartmentNumber,
DepartmentName,
TransactionDate,
Details,
Amount,
Forecast,
TransactionNo,
AccountName,
AccountCategory,
TransactionTypeBK,
Supplier,
NominalCode,
FinancialLineCode,
ProjectName,
IsDiscretionary,
IsNonDiscretionary,
AmountRaw,
ControlDate,
LastUpdatedDate,
RE)

select 
FinancialFactId,
FiscalYear,
FiscalFirstDayOfYear,
FiscalLastDayOfYear,
DepartmentNumber,
DepartmentName,
TransactionDate,
Details,
Amount,
Forecast,
TransactionNo,
AccountName,
AccountCategory,
TransactionTypeBK,
Supplier,
NominalCode,
FinancialLineCode,
ProjectName,
IsDiscretionary,
IsNonDiscretionary,
AmountRaw,
ControlDate,
LastUpdatedDate,
case when
nominalcode>=4300 then 'Expense' else 'Revenue' end as RE
from [Access.WebDev].[ufn_FinancialDashboardAll](20162017)
where nominalcode>=4000  -- and FinancialLineCode='A'  
and departmentNumber=(@FinancialYear - cast(@FinancialYear as integer))*100
and Year(transactiondate)=cast(@FinancialYear/100 as integer)
and Month(transactiondate)= cast(@FinancialYear as integer)-(cast(@FinancialYear as integer)/100)*100

RETURN

END

