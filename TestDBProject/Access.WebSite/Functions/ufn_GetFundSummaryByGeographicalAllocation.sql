
CREATE FUNCTION [Access.WebSite].[ufn_GetFundSummaryByGeographicalAllocation]
(
	
	@SEDOL VARCHAR(10) = 'WIMEIF'
	
)
 

 RETURNS
 
@Output TABLE (
	Geographic VARCHAR(250),
	Allocation DECIMAL(38,2),
	AS_AT_DATE DATETIME)
AS

---------------------------------------------------------------------------------------- 
---- Name: [Access.WebSite].[ufn_GetFundSummaryByGeographicalAllocation]
---- 

---- Returns: Table
---------------------------------------------------------------------------------------- 
---- History:
---- WHO WHEN WHY
-----OLU:     23/01/2019 JIRA: DAP-2462 - Return Summary of Portfolio By Geography
---------------------------------------------------------------------------------------- 
BEGIN




DECLARE @DATE Datetime = NULL

 IF @Date IS NULL
	SET @Date =  (select max (AS_AT_DATE) from T_NT_FUND_PERFORMANCE_ATTRIBUTION )



DECLARE @Temp table
(
	COUNTRY VARCHAR(250),
	Allocation DECIMAL(38,10),
	AS_AT_DATE DATETIME,
	SEDOL VARCHAR(10)
)


INSERT INTO @Temp
select  COUNTRY , isnull(sum(CTR_TO_WI0001),0) as EndWeight, AS_AT_DATE, 'WIMEIF' AS SEDOL from T_NT_FUND_PERFORMANCE_ATTRIBUTION 
WHERE AS_AT_DATE = @DATE 
group by COUNTRY, AS_AT_DATE, SEDOL
 
 union 

select  COUNTRY, isnull(sum(CTR_TO_WI0002),0) as wi0002,  AS_AT_DATE, 'SJPDST' AS SEDOL   from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @DATE 
group by COUNTRY , AS_AT_DATE, SEDOL
 
 
 union
 
 select  COUNTRY, isnull(sum(CTR_TO_WI0003),0) as wi0003,  AS_AT_DATE, 'SJPNUK' AS SEDOL  from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @DATE  
group by COUNTRY, AS_AT_DATE, SEDOL
 
 
 union 

select  COUNTRY, isnull(sum(CTR_TO_WI0004),0) as wi0004,   AS_AT_DATE, 'SJPXUK' AS SEDOL    from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @DATE
group by COUNTRY, AS_AT_DATE, SEDOL
 
 
 union
 
 select  COUNTRY, isnull(sum(CTR_TO_WI0005),0) as wi0005,AS_AT_DATE, 'SJPHIY' AS SEDOL  from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @DATE 
group by COUNTRY, AS_AT_DATE, SEDOL
 
 
 union 

select  COUNTRY, isnull(sum(CTR_TO_WI0006),0) as wi0006, AS_AT_DATE, 'WEST01' AS SEDOL  from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @DATE 
group by COUNTRY, AS_AT_DATE, SEDOL
 
 

  union
 
 select  COUNTRY, isnull(sum(CTR_TO_WI0007),0) as wi0007,  AS_AT_DATE, 'OMWEIF' AS SEDOL from T_NT_FUND_PERFORMANCE_ATTRIBUTION
group by COUNTRY, AS_AT_DATE, SEDOL
 
 
 union 

select  COUNTRY, isnull(sum(CTR_TO_WI0013),0) as wi0013,    AS_AT_DATE, 'WIMPCT' AS SEDOL  from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @DATE  
group by COUNTRY, AS_AT_DATE, SEDOL
 
 
  union 

select  COUNTRY, isnull(sum(CTR_TO_WI0014),0) as wi0014,  AS_AT_DATE, 'OMNIS1' AS SEDOL  from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @DATE  
group by COUNTRY, AS_AT_DATE, SEDOL
 


  union 

select  COUNTRY, isnull(sum(CTR_TO_WI0018),0) as wi0018,  AS_AT_DATE, 'WIMIFF' AS SEDOL  from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @DATE  OR @DATE IS NULL
group by COUNTRY, AS_AT_DATE, SEDOL
 
 
 --Enter tempData into Output table 
 INSERT INTO @Output
 SELECT COUNTRY,  SUM(Allocation) , TR.AS_AT_DATE FROM @Temp TR
 WHERE SEDOL = @SEDOL OR @SEDOL IS NULL
 and TR.AS_AT_DATE = @DATE  
 GROUP BY COUNTRY, TR.AS_AT_DATE
 
 UNION 

 SELECT SECTOR, EndWeight, AS_AT_DATE FROM T_REF_NT_SectorBenchMarks
 WHERE SECTOR = 'Cash'
AND  AS_AT_DATE = @DATE
AND  Fund_Short_Name =  @SEDOL OR @SEDOL IS NULL
 


	RETURN

END








