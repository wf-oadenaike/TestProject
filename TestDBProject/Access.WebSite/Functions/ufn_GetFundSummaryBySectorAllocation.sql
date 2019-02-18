
CREATE FUNCTION [Access.WebSite].[ufn_GetFundSummaryBySectorAllocation]
(
	
	
	@SEDOL VARCHAR(10) = 'WIMEIF'
	
)

RETURNS
@Output TABLE (
	Sector VARCHAR(250),
	Allocation DECIMAL(38,2),
	Benchmark DECIMAL(38,2)
			)


AS

---------------------------------------------------------------------------------------- 
---- Name: [Access.WebSite].[ufn_GetFundSummaryBySectorAllocation]
---- 

---- Returns: Table
---------------------------------------------------------------------------------------- 
---- History:
---- WHO WHEN WHY
-----OLU:     23/01/2019 JIRA: DAP-2462 - Return Summary of Portfolio By Sector
---------------------------------------------------------------------------------------- 
BEGIN


DECLARE @DATE Datetime = NULL

 IF @Date IS NULL
	SET @Date =  (select max (AS_AT_DATE) from "T_REF_NT_SectorBenchMarks" )


DECLARE
@Temp_Output TABLE (
	Sector VARCHAR(250),
	Allocation DECIMAL(38,2),
	Benchmark DECIMAL(38,2),
	FundShortName varchar(12),
	AS_AT_DATE DATETIME
		)




Insert into  @Temp_Output
SELECT SECTOR, EndWeight, BenchMarkWeight, Fund_Short_Name, AS_AT_DATE  FROM "T_REF_NT_SectorBenchMarks"






INSERT INTO @Output(Sector, Allocation, Benchmark)
Select Sector, Allocation, Benchmark from  @Temp_Output
WHERE (FundShortName = @SEDOL OR @SEDOL IS  NULL)
and  AS_AT_DATE = @DATE



RETURN


END


