

CREATE FUNCTION [Access.WebDev].[ufn_NJRFinancialDashboardAll]
(
    @FinancialYear int = NULL
)
RETURNS TABLE 
AS

RETURN
(
select * from [Access.WebDev].[FinanceDashboardAllVw]
where FISCALYEAR = @FinancialYear

)
