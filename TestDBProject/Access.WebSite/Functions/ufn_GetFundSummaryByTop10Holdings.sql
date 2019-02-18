
CREATE FUNCTION [Access.WebSite].[ufn_GetFundSummaryByTop10Holdings]
(

	@SEDOL varchar(10) = NULL
	
	
)
RETURNS
 
@Output TABLE (
	PREFERRED_NAME VARCHAR(250),
	Sector VARCHAR(250),
	EndWeight DECIMAL(38,2),
	AS_AT_DATE DATETIME
	
	)
 



 

---------------------------------------------------------------------------------------- 
---- Name: [Access.WebSite].[ufn_GetFundSummaryByTop10Holdings]
---- 

---- Returns: Table
---------------------------------------------------------------------------------------- 
---- History:
---- WHO WHEN WHY
-----OLU:     23/01/2019 JIRA: DAP-2462 - Return Summary of Portfolio By FundType
---------------------------------------------------------------------------------------- 




BEGIN
DECLARE @DATE DATETIME

 IF @Date IS NULL
	SET @Date =  (select max (AS_AT_DATE) from T_NT_FUND_PERFORMANCE_ATTRIBUTION )


DECLARE @Temp table
(
	PREFERRED_NAME VARCHAR(250),
	SECTOR VARCHAR(250),
	EndWeight DECIMAL(38,2),
	AS_AT_DATE DATETIME,
	SEDOL VARCHAR(10)
)


INSERT INTO @Temp
select PREFERRED_NAME, sector, isnull(sum(CTR_TO_WI0001),0) as EndWeight,  AS_AT_DATE, 'WIMEIF' AS SEDOL 
 from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @Date
group by sector, AS_AT_DATE, SEDOL,PREFERRED_NAME
 
 union 

select   PREFERRED_NAME, sector, isnull(sum(CTR_TO_WI0002),0) as wi0002,  AS_AT_DATE, 'SJPDST' AS SEDOL    from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @Date
group by sector, AS_AT_DATE,SEDOL,PREFERRED_NAME
 
 
 union
 
 select   PREFERRED_NAME, sector, isnull(sum(CTR_TO_WI0003),0) as wi0003,  AS_AT_DATE, 'SJPNUK' AS SEDOL  from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @Date
group by sector, AS_AT_DATE,SEDOL,PREFERRED_NAME
 
 
 
 union 

select   PREFERRED_NAME, sector, isnull(sum(CTR_TO_WI0004),0) as wi0004,   AS_AT_DATE, 'SJPXUK' AS SEDOL    from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @Date
group by sector, AS_AT_DATE,SEDOL,PREFERRED_NAME
 
 
 
 union
 
 select   PREFERRED_NAME, sector, isnull(sum(CTR_TO_WI0005),0) as wi0005, AS_AT_DATE, 'SJPHIY' AS SEDOL   from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @Date
group by sector, AS_AT_DATE,SEDOL,PREFERRED_NAME
 
 
 
 union 

select   PREFERRED_NAME, sector, isnull(sum(CTR_TO_WI0006),0) as wi0006,  AS_AT_DATE, 'WEST01' AS SEDOL     from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @Date
group by sector, AS_AT_DATE,SEDOL,PREFERRED_NAME
 
 
 

  union
 
 select   PREFERRED_NAME, sector, isnull(sum(CTR_TO_WI0007),0) as wi0007,   AS_AT_DATE, 'OMWEIF' AS SEDOL    from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @Date
group by sector, AS_AT_DATE,SEDOL,PREFERRED_NAME
 
 
 
 union 

select   PREFERRED_NAME, sector, isnull(sum(CTR_TO_WI0013),0) as wi0013,   AS_AT_DATE, 'WIMPCT' AS SEDOL    from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @Date
group by sector, AS_AT_DATE,SEDOL,PREFERRED_NAME
 
 
 
  union 

select PREFERRED_NAME, sector,   isnull(sum(CTR_TO_WI0014),0) as wi0014,   AS_AT_DATE, 'OMNIS1' AS SEDOL    from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @Date
group by sector, AS_AT_DATE,SEDOL,PREFERRED_NAME
 
 
 


  union 

select   PREFERRED_NAME, sector, isnull(sum(CTR_TO_WI0018),0) as wi0018,    AS_AT_DATE, 'WIMIFF' AS SEDOL   from T_NT_FUND_PERFORMANCE_ATTRIBUTION
WHERE AS_AT_DATE = @Date
group by sector, AS_AT_DATE,SEDOL,PREFERRED_NAME
 
 
 

 insert into @Output(PREFERRED_NAME, Sector,EndWeight, AS_AT_DATE)
 SELECT TOP 10 PREFERRED_NAME, SECTOR, SUM(EndWeight), AS_AT_DATE FROM @Temp
 WHERE SEDOL = @SEDOL OR @SEDOL IS NULL
 AND AS_AT_DATE = @Date OR @Date IS NULL
 GROUP BY  SECTOR, AS_AT_DATE,  PREFERRED_NAME
 ORDER BY SUM(EndWeight) DESC


 
RETURN


END