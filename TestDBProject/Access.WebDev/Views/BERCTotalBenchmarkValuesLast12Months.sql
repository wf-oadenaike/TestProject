CREATE VIEW [Access.WebDev].[BERCTotalBenchmarkValuesLast12Months]
AS
/******************************
** Desc:
** Auth: W.Stubbs
** Date: 23/02/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1571     23/02/2018  W.Stubbs	Initial version of view
** DAP-1570		19/04/2018	R.Walker	Replace code with generic BenchmarkValues view
** DAP-2176		11/07/2018	R.Walker	Restrict IPO trades from Exception analysis 
** DAP-2348		16/10/2018	R.Walker	Reduce to current month scope only - Use Allocated_time instead of Trader_Date_Time
*******************************/


WITH MyCTE AS
(
    SELECT  
		 YEAR(Allocated_Time) as 'Year'
		,MONTH(Allocated_Time) AS 'Month'
		,Benchmark
		,BenchmarkTotal
		,PLPos
		,PLNeg
    FROM 
         [dbo].[Vw_BenchmarkValues]
	WHERE Benchmark IN ('IS/ACE','VWAP')
)

select YEAR, MONTH, Benchmark, SUM(PLPos) AS PositiveTotal, SUM(PLNeg) As NegativeTotal,  SUM(PLPos) + SUM(PLNeg) AS Balance
from mycte
	WHERE (
		-- either year is one less than current and month is equal or greater
		(Year = YEAR(GETDATE()) -1 AND Month >= MONTH(GETDATE()))
		or
		-- or year is equal to current and month is less
		(Year = YEAR(GETDATE()) AND Month < MONTH(GETDATE()))
		)
group by year, month, benchmark





