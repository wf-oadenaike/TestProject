CREATE PROCEDURE dbo.usp_Unquoted_PerformanceMonitoring 
as


--  --Clear Table 
TRUNCATE TABLE  dbo.Unquoted_PerformanceMonitoring  

SET NOCOUNT ON 

-- Declare variables
DECLARE 

@CR Varchar(256),
@LoopCounter INT , 
@MaxIssuerId INT, 
@MinCal INT, 
@MaxCal INT, 
@LastDayOfMonth VARCHAR(256) ,
@StartDate AS DATETIME,  
 @EndDate AS DATETIME,  
@CurrentDate AS DATETIME, 
@OverallEndDate	datetime,
@LoopDate DATEtime

SET @StartDate  = '01 January 2013';
SET @EndDate    = '30 April 2018';
--SET @Date


-- Loop around dates 
WITH CTE_Months
AS
(
    SELECT @StartDate dates
    UNION ALL
    SELECT DATEADD(dd,1,dates)
    FROM CTE_Months
    WHERE DATEADD(MONTH,1,dates) < @EndDate
	


)


SELECT @LoopDate = dates
        
FROM CTE_Months A
option (maxrecursion 0)





-- SET LAST DAY OF THE YEAR , FIRST DAY OF YEAR 


--Return Minimum IssuerID and Latest IssuerID
SELECT @LoopCounter = min(id) , @MaxIssuerId = max(Id) 
FROM Investment.T_UnquotedIssuers



WHILE 
 (@LoopCounter IS NOT NULL 
      AND @LoopCounter <= @MaxIssuerId)



BEGIN


-- Loop around to fetch each Issuer Name
SELECT @CR = KnownName
FROM Investment.T_UnquotedIssuers 
WHERE Id = @LoopCounter


-- Increment Each ID and date/day 
SET @LoopCounter  = @LoopCounter  + 1 
--set @StartDate = @EndDate
--set @EndDate =   DATEADD(dd,4,@StartDate)
--END




DECLARE @Temp_buy TABLE (
  BUY decimal(38, 12),
  TICKER varchar(20),
  FUND varchar(12),
  Initial_Investment datetime,
  IPO CHAR(3)
  
)

INSERT INTO @Temp_buy
  SELECT 
    CASE
      WHEN C_CURRENCY = 'USD' THEN isnull(F_PRINCIPAL,0) * F_EX_RATE
      ELSE isnull(F_PRINCIPAL,0)
    END
    AS BUY,
    LEFT(C_SECURITY,LEN(C_SECURITY)-3) AS C_TICKER,
    C_ACCOUNT,
    D_ASOFDATE AS Initial_Investment,
	C_IPO
	
	
  FROM T_BBG_TCA_TRADE_ORDERS_AUDIT a
   LEFT JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker =  LEFT(C_SECURITY,LEN(C_SECURITY)-3)
	
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
--	inner join Investment.T_REF_ICBSubsectors ir
--on ir.ID = ti.SubsectorID

  WHERE C_EVENT IN ( 'ACTIVATED ORDER')
  AND LEFT(a.C_SECURITY, 1) = '.'
	AND C_SIDE = 'BUY'
AND TI.KnownName = @cr


	
DECLARE @Temp_SELL TABLE (
  SELL decimal(38, 12),
  TICKER varchar(20),
  FUND varchar(12),
  Initial_Investment datetime,
  IPO CHAR(3)

)


INSERT INTO @Temp_Sell
  SELECT
    CASE
      WHEN C_CURRENCY = 'USD' THEN isnull(F_PRINCIPAL,0) * F_EX_RATE
      ELSE isnull(F_PRINCIPAL,0)
    END
    AS BUY,
    LEFT(C_SECURITY,LEN(C_SECURITY)-3) AS C_TICKER,
    C_ACCOUNT,
    D_ASOFDATE AS Initial_Investment,
	C_IPO

	
  FROM T_BBG_TCA_TRADE_ORDERS_AUDIT a
  LEFT JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker =  LEFT(C_SECURITY,LEN(C_SECURITY)-3)
	
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
--inner join Investment.T_REF_ICBSubsectors ir
--on ir.ID = ti.SubsectorID
  WHERE C_EVENT = 'ORDER ALLOCATED'
  AND LEFT(a.C_TICKER, 1) = '.'
  AND C_SIDE = 'SELL'
  --AND   LEFT(C_SECURITY,LEN(C_SECURITY)-3) LIKE '%GIG%'
   --AND D_ASOFDATE = @CurrentDate
   AND TI.KnownName = @cr
    

DECLARE @temp_POS TABLE (
  --EDM_SEC_ID INT, 
  TICKER varchar(12),
  POSITION decimal(38, 2),
  INTIAL_INVESTMENT datetime,
  FUND varchar(20),
  IPO CHAR(3)
  
)
INSERT INTO @temp_POS
SELECT DISTINCT
 S.TICKER,
 CASE
      WHEN PR.PRICE_ISO_CCY = 'USD' THEN ISNULL(master_price * quantity,0) *  ISNULL(K.SPOT_RATE,0)
      ELSE ISNULL(master_price * quantity,0)
    END AS POSITION,
  p.POSITION_DATE,
  P.FUND_SHORT_NAME,
  NULL AS IPO

  FROM  
  T_MASTER_POS P 
  INNER JOIN dbo.T_MASTER_PRC PR
    ON P.EDM_SEC_ID = PR.EDM_SEC_ID
    AND p.POSITION_DATE = pr.PRICE_DATE
   AND POSITION_DATE = @LoopDate
  INNER JOIN 
  T_MASTER_SEC S
  ON P.EDM_SEC_ID = S.EDM_SEC_ID
    AND LEFT(S.TICKER,1) = '.'
	LEFT JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker =  S.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID  

 LEFT JOIN (SELECT
    DATE,
    SPOT_RATE
  FROM T_MASTER_FXRATE
  WHERE FROM_ISO_CURRENCY_CODE = 'USD'
  AND TO_ISO_CURRENCY_CODE = 'GBP'
  AND DATE = (SELECT
    MAX(DATE)
  FROM T_MASTER_FXRATE)) K
    ON K.DATE = P.POSITION_DATE
	   AND PR.PRICE_TYPE = 'EOD'
where KnownName = @cr


end




DECLARE @temp_Perf TABLE (
  KnownLegalName varchar(500),
  MEASURE decimal(38, 9),
  Fund_Type varchar(50),
  Initial_Investment datetime,
  Measure_Type varchar(250),
  IPO CHAR(3),
  INDUSTRY VARCHAR(100)

)


-- Insert union of data into table variable 
INSERT INTO @temp_Perf

-- Measure Type 1
SELECT DISTINCT
    KnownName AS KnownLegalName,
    BUY AS MEASURE,
    CASE WHEN FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END ,
	INITIAL_INVESTMENT,
    '1. Total Cash Invested' AS MEASURE_TYPE,
	IPO,
	IR.Name
  FROM @Temp_buy A
  INNER JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  INNER JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
		inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID


  


  UNION
-- Measure Type 2
  SELECT DISTINCT
    KnownName AS KnownLegalName,
    SELL AS MEASURE,
    CASE WHEN FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END ,
    INITIAL_INVESTMENT,
    '2. Total Cash Realisations' AS MEASURE_TYPE,
	IPO,
	IR.Name
  FROM @Temp_SELL A
  INNER JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  INNER JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
		inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID

  --AND A.TICKER LIKE '%.FEDW%'


  UNION

-- Measure Type 3 Net Cash Invested
  SELECT DISTINCT
    KnownName AS KnownLegalName,
     ISNULL(BUY, 0) - ISNULL(SELL, 0)  AS MEASURE,
       CASE WHEN b.FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN b.FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN b.FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END ,
   NULL AS INITIAL_INVESTMENT,
    '3. Net Cash Invested' AS MEASURE_TYPE,
	IPO,
	IR.Name
  FROM (SELECT
    SUM(buy) AS buy,
    fund,
    TICKER,
	IPO
  FROM @Temp_buy
  GROUP BY FUND,
           IPO,
           TICKER) b
  LEFT JOIN (SELECT
    ISNULL(SUM(sell), 0) AS sell,
    fund,
	TICKER
  FROM @Temp_SELL
  GROUP BY FUND, TICKER, IPO) s
    ON B.FUND = S.FUND AND B.TICKER = S.TICKER
  LEFT JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = b.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID

	

  UNION
-- Measure Type 4 -Positions Data
  select KnownName, measure, 
   CASE WHEN p.FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN p.FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN p.FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END ,

     INTIAL_INVESTMENT AS INITIAL_INVESTMENT,
	
  '4. Position' AS MEASURE_TYPE,
   NULL AS IPO,
  ir.Name
    from  

  (
  SELECT distinct
  position AS measure ,
    p.fund AS FUND,
	p.ticker,
	p.INTIAL_INVESTMENT
  FROM @temp_POS p 
 --  WHERE INTIAL_INVESTMENT = '2018-03-30 00:00:00.000' -- Show its the right Position
 --group by   p.fund, p.TICKER,INTIAL_INVESTMENT
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID


  UNION


  -- Measure Type 5 - Realised/UnRealised Value Gain
   select KnownName, measure, fund, 
  null as INITIAL_INVESTMENT,
  '5. Realised/UnRealised Value Gain' AS MEASURE_TYPE ,
  IPO,
  ir.Name
  from 

  (
  SELECT distinct
 position -  (isnull(sum(sell),0) + sum(buy)) as measure,
      CASE WHEN p.FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN p.FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN p.FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END AS FUND,
	p.ticker,
	B.IPO
  FROM @temp_POS p 
  inner join  @Temp_buy b
  on p.TICKER = b.TICKER and p.FUND =b.FUND
  left join  @Temp_SELL s 
  on p.TICKER = s.TICKER and p.FUND =s.FUND
 group by   p.fund, p.TICKER, POSITION, B.IPO
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID
	

  UNION



  -- Measure Type 6 --Un
   select KnownName, measure,    CASE WHEN p.FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN p.FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN p.FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END ,
  null as INITIAL_INVESTMENT,

  '6. UnRealised Value Gain' AS MEASURE_TYPE ,
    IPO,
	ir.Name
  from  

  (
  SELECT distinct
	 CASE
      WHEN isnull(position,0) > 0 THEN isnull(position,0) - isnull(sum(sell),0 +  isnull(sum(buy),0)) 
    END AS measure,
    p.fund AS FUND,
	p.ticker,
	 B.IPO
  FROM @temp_POS p 
  inner join  @Temp_buy b
  on p.TICKER = b.TICKER and p.FUND =b.FUND
  left join  @Temp_SELL s 
  on p.TICKER = s.TICKER and p.FUND =s.FUND
   --WHERE INTIAL_INVESTMENT = '2018-03-30 00:00:00.000'
 group by   p.fund, p.TICKER, POSITION,  B.IPO
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID



  UNION


   
   select KnownName, measure,    CASE WHEN p.FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN p.FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN p.FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END ,
  null as INITIAL_INVESTMENT,
  '7. Realised Value Gain' AS MEASURE_TYPE,
  IPO,
  ir.Name
   from  

  (


  SELECT distinct
	(position   -  (isnull(sum(sell),0 +  sum(buy)))) -  CASE
      WHEN isnull(position,0) > 0 THEN isnull(position,0) - isnull(sum(sell),0 +  sum(buy))
    END AS measure,
    p.fund AS FUND,
	p.ticker,
	B.IPO
  FROM @temp_POS p 
  inner join  @Temp_buy b
  on p.TICKER = b.TICKER and p.FUND =b.FUND
  left join  @Temp_SELL s 
  on p.TICKER = s.TICKER and p.FUND =s.FUND
   --WHERE INTIAL_INVESTMENT = '2018-03-30 00:00:00.000'
 group by   p.fund, p.TICKER, POSITION,  B.IPO
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID



	UNION

    select KnownName,
	 measure, 
	    CASE WHEN FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END , 
	    NULL AS Initial_Investment,
  '8. MMX' AS MEASURE_TYPE,
  IPO,
  IR.Name
  from  

  (
  SELECT distinct
 ( position    - isnull(sum(sell),0)) / nullif(sum(buy),0) as measure,
    p.fund AS FUND,
	p.ticker,
	B.IPO
  FROM @temp_POS p 
  inner join  @Temp_buy b
  on p.TICKER = b.TICKER and p.FUND =b.FUND
  left join  @Temp_SELL s 
  on p.TICKER = s.TICKER and p.FUND =s.FUND
   --WHERE INTIAL_INVESTMENT = '2018-03-30 00:00:00.000'
 group by   p.fund, p.TICKER, POSITION, B.IPO
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID


  UNION
  
  select KnownLegalName as KnownName,
	 measure, 
	 fund,
	 INITIAL_INVESTMENT AS Initial_Investment,
  '9. Gross IRR' AS MEASURE_TYPE,
  IPO,
  Name 
  FROM 
  (
     SELECT DISTINCT
 
 	KnownName AS KnownLegalName,
    NULL AS MEASURE,
	   CASE WHEN FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END as FUND ,
	NULL AS  INITIAL_INVESTMENT,

	'9. Gross IRR' AS MEASURE_TYPE,
	NULL AS IPO,
	IR.Name
    

  FROM @Temp_buy A
  INNER JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  INNER JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID

	UNION
	
	
		SELECT
		KnownName AS KnownLegalName,
    NULL AS MEASURE,
	   CASE WHEN FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END as FUND,
	NULL AS  INITIAL_INVESTMENT,
	'9. Gross IRR' AS MEASURE_TYPE,
		NULL AS IPO,
		IR.Name
	FROM @Temp_SELL A
  INNER JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  INNER JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID
	 
UNION

		SELECT
		KnownName AS KnownLegalName,
    NULL AS MEASURE,
	 CASE WHEN FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END as FUND,
	null as  INITIAL_INVESTMENT,
	'9. Gross IRR' AS MEASURE_TYPE,
		NULL AS IPO,
		IR.Name
   from  

  (
  SELECT distinct
  position AS measure ,
    p.fund AS FUND,
	p.ticker,
	p.INTIAL_INVESTMENT
  FROM @temp_POS p 
   --WHERE INTIAL_INVESTMENT = '2018-03-30 00:00:00.000' -- Show its the right Position
 --group by   p.fund, p.TICKER,INTIAL_INVESTMENT
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	inner join Investment.T_REF_ICBSubsectors ir
on ir.ID = ti.SubsectorID
) PR

	


 
 

	



	
DECLARE @Test MyXirrTable
Insert into @Test([theValue],[theDate],[KnownName],[Fund_Type])
  	 
	 
	   SELECT DISTINCT
 
    -BUY AS MEASURE,
	INITIAL_INVESTMENT,
	KnownName AS KnownLegalName,
   CASE WHEN FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END as FUND 

  FROM @Temp_buy A
  left JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  left JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
		

	UNION
	
	   SELECT DISTINCT
 
    SELL AS MEASURE,
	INITIAL_INVESTMENT,
	KnownName AS KnownLegalName,
    CASE WHEN FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END as FUND
	FROM @Temp_SELL A
  left JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  left JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
		
	 
UNION

	   select distinct measure,
     INTIAL_INVESTMENT AS INITIAL_INVESTMENT,
	 KnownName,
	  CASE WHEN FUND = 'WIMEIF' THEN 'a. WIMEIF'
		 WHEN FUND = 'WIMPCT' THEN 'b. WIMPCT'
		 WHEN FUND = 'OMNIS1' THEN 'c.  Omnis'
		 END as FUND
   from  

  (
  SELECT distinct
  position AS measure ,
    p.fund AS FUND,
	p.ticker,
	p.INTIAL_INVESTMENT
  FROM @temp_POS p 
   --WHERE INTIAL_INVESTMENT = '2018-03-30 00:00:00.000' -- Show its the right Position
 --group by   p.fund, p.TICKER,INTIAL_INVESTMENT
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID

	

--select * from @Test
--where KnownName = 'Gigaclear'
--and Fund_Type = 'OMNIS1'




DECLARE @theValue VARCHAR(50)  
DECLARE @date datetime
DECLARE @FundType VARCHAR(256) 
DECLARE @KnownName VARCHAR(256)


DECLARE xirr_cursor CURSOR FOR 
SELECT distinct  Fund_Type, KnownName
FROM @Test


OPEN xirr_cursor  
FETCH NEXT FROM xirr_cursor INTO  @FundType, @KnownName

WHILE @@FETCH_STATUS = 0  
BEGIN  



--select dbo.XIRR(@Test, 0.1,@KnownName, @FundType) * 100,   Fund_Type  from  @temp_Perf
--where Fund_Type = @fundtype
--and Measure_Type = 9

UPDATE tp
SET MEASURE = (SELECT	dbo.XIRR(@Test, 0.1, @FundType, @KnownName))  * 100 
from @temp_Perf tp
WHERE Measure_Type = '9. Gross IRR' 
and Fund_Type = @FundType
AND KnownLegalName = @KnownName



--Fetch Next Fundtype and KnownName into the Cursor
FETCH NEXT FROM xirr_cursor INTO  @FundType, @KnownName
END 

CLOSE xirr_cursor  
DEALLOCATE xirr_cursor 





INSERT INTO   dbo.Unquoted_PerformanceMonitoring  (KnownLegalName, MEASURE, Fund_Type, Initial_Investment, Measure_Type, IPO, INDUSTRY)
SELECT
  *

FROM @temp_Perf
--WHERE KnownLegalName = 'GigaClear'
ORDER BY Measure_Type  DESC





