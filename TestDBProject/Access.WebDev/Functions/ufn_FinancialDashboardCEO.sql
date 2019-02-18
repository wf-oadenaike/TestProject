-- JIRA DAP-926
CREATE FUNCTION [Access.WebDev].[ufn_FinancialDashboardCEO]
(
    @FinancialYear int = NULL
)
RETURNS @OutputTable table
(
    
        Amount money NULL,
        Forecast money NULL,
		DepartmentName varchar(128) NULL,
		FinancialLineCode varchar(20) NULL,
		FiscalYear int NULL,
		TransactionDate int NULL,
		Details varchar(255) NULL
       
)
AS

BEGIN

    IF @FinancialYear IS NULL
       set @FinancialYear = (SELECT FiscalYear FROM [Core].[Calendar] WHERE CalendarDate = CAST(GetDate() as date));

Insert into @OutputTable
Select Actual,Forecast,DepartmentName,FinancialLineCode,FiscalYear,yyyy*100+mm as transactiondate, 
RE from (
select sum(amountraw) as Actual, sum(forecast) as Forecast, DepartmentName, 
FinancialLineCode,FiscalYear,YEAR(transactiondate) as yyyy, MONTH(transactiondate ) as mm ,case when
nominalcode>=4300 then 'Expense' else 'Revenue' end as RE
from [Access.WebDev].[ufn_FinancialDashboardAll](@FinancialYear)
where nominalcode>=4000  
group by DepartmentName, FinancialLineCode, case when
nominalcode>=4300 then 'Expense' else 'Revenue' end ,FiscalYear ,YEAR(transactiondate), MONTH(transactiondate) 
)B

RETURN

END

