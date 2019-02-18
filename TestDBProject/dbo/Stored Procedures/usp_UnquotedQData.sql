CREATE  proc dbo.usp_UnquotedQData 
(



@CompanyName Varchar(256) = NULL,
@Postion_Date DATETIME = NULL
)
as 
IF @CompanyName is NULL
DECLARE @LoopCounter INT , @MaxIssuerId INT
        
SELECT @LoopCounter = min(id) , @MaxIssuerId = max(Id) 
FROM Investment.T_UnquotedIssuers
 
WHILE(@LoopCounter IS NOT NULL
      AND @LoopCounter <= @MaxIssuerId)
BEGIN
   SELECT @CompanyName = KnownName
   FROM Investment.T_UnquotedIssuers WHERE Id = @LoopCounter
    
 
   SET @LoopCounter  = @LoopCounter  + 1        
END

 
DECLARE @Temp_buy TABLE (
  BUY decimal(38, 12),
  TICKER varchar(20),
  FUND varchar(12),
  Initial_Investment datetime
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
    D_ASOFDATE AS Initial_Investment
  FROM T_BBG_TCA_TRADE_ORDERS_AUDIT a
   LEFT JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker =  LEFT(C_SECURITY,LEN(C_SECURITY)-3)
		
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
  WHERE C_EVENT IN ( 'ACTIVATED ORDER')
  AND LEFT(a.C_SECURITY, 1) = '.'
	AND C_SIDE = 'BUY'
--AND LEFT(C_SECURITY,LEN(C_SECURITY)-3) LIKE '%AJB%'
 AND TI.KnownName = @CompanyName
    ORDER BY  C_SECURITY



DECLARE @Temp_SELL TABLE (
  SELL decimal(38, 12),
  TICKER varchar(20),
  FUND varchar(12),
  Initial_Investment datetime
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
    D_ASOFDATE AS Initial_Investment
  FROM T_BBG_TCA_TRADE_ORDERS_AUDIT a
  LEFT JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker =  LEFT(C_SECURITY,LEN(C_SECURITY)-3)
	
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
  WHERE C_EVENT = 'ORDER ALLOCATED'
  AND LEFT(a.C_TICKER, 1) = '.'
  AND C_SIDE = 'SELL'
  --AND   LEFT(C_SECURITY,LEN(C_SECURITY)-3) LIKE '%GIG%'
   AND TI.KnownName = @CompanyName


DECLARE @temp_POS TABLE (
  --EDM_SEC_ID INT, 
  TICKER varchar(12),
  POSITION decimal(38, 2),
  INTIAL_INVESTMENT datetime,
  FUND varchar(20)
)

INSERT INTO @temp_POS
SELECT DISTINCT
 S.TICKER,
 CASE
      WHEN PR.PRICE_ISO_CCY = 'USD' THEN ISNULL(master_price * quantity,0) *  ISNULL(K.SPOT_RATE,0)
      ELSE ISNULL(master_price * quantity,0)
    END AS POSITION,
  p.POSITION_DATE,
  P.FUND_SHORT_NAME 
  FROM  
  T_MASTER_POS P 
  INNER JOIN dbo.T_MASTER_PRC PR
    ON P.EDM_SEC_ID = PR.EDM_SEC_ID
    AND p.POSITION_DATE = pr.PRICE_DATE
   AND POSITION_DATE = @Postion_Date
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
	   --WHERE S.TICKER LIKE '%AJB%'
where KnownName = @CompanyName

  


DECLARE @temp_Perf TABLE (
  KnownLegalName varchar(500),
  MEASURE decimal(38, 9),
  Fund_Type varchar(50),
  Initial_Investment datetime,
  Measure_Type varchar(250)

)



INSERT INTO @temp_Perf
  SELECT DISTINCT
    KnownName AS KnownLegalName,
    BUY AS MEASURE,
    FUND,
    INITIAL_INVESTMENT,
    '1' AS MEASURE_TYPE
  FROM @Temp_buy A
  INNER JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  INNER JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID

  --AND A.TICKER LIKE '%.FEDW%'


  UNION

  SELECT DISTINCT
    KnownName AS KnownLegalName,
    SELL AS MEASURE,
    FUND,
    INITIAL_INVESTMENT,
    '2' AS MEASURE_TYPE
  FROM @Temp_SELL A
  INNER JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  INNER JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID

  ----AND A.TICKER LIKE '%.FEDW%'


  UNION

  SELECT DISTINCT
    KnownName AS KnownLegalName,
     ISNULL(BUY, 0) - ISNULL(SELL, 0)  AS MEASURE,
    b.FUND,
   NULL AS INITIAL_INVESTMENT,
    '3' AS MEASURE_TYPE
  FROM (SELECT
    SUM(buy) AS buy,
    fund,
    TICKER
  FROM @Temp_buy
  GROUP BY FUND,
           
           TICKER) b
  LEFT JOIN (SELECT
    ISNULL(SUM(sell), 0) AS sell,
    fund,
	TICKER
  FROM @Temp_SELL
  GROUP BY FUND, TICKER) s
    ON B.FUND = S.FUND AND B.TICKER = S.TICKER
  LEFT JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = b.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID

	

  UNION

  select KnownName, measure, fund, 
     INTIAL_INVESTMENT AS INITIAL_INVESTMENT,
  '4' AS MEASURE_TYPE from  

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


  UNION


  
   select KnownName, measure, fund, 
  null as INITIAL_INVESTMENT,
  '5' AS MEASURE_TYPE from 

  (
  SELECT distinct
 position -  (isnull(sum(sell),0) + sum(buy)) as measure,
    p.fund AS FUND,
	p.ticker
  FROM @temp_POS p 
  inner join  @Temp_buy b
  on p.TICKER = b.TICKER and p.FUND =b.FUND
  left join  @Temp_SELL s 
  on p.TICKER = s.TICKER and p.FUND =s.FUND
 group by   p.fund, p.TICKER, POSITION
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	

  UNION



  
   select KnownName, measure, fund, 
  null as INITIAL_INVESTMENT,
  '6' AS MEASURE_TYPE from  

  (
  SELECT distinct
	 CASE
      WHEN isnull(position,0) > 0 THEN isnull(position,0) - isnull(sum(sell),0 +  isnull(sum(buy),0)) 
    END AS measure,
    p.fund AS FUND,
	p.ticker
  FROM @temp_POS p 
  inner join  @Temp_buy b
  on p.TICKER = b.TICKER and p.FUND =b.FUND
  left join  @Temp_SELL s 
  on p.TICKER = s.TICKER and p.FUND =s.FUND
   --WHERE INTIAL_INVESTMENT = '2018-03-30 00:00:00.000'
 group by   p.fund, p.TICKER, POSITION
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID



  UNION


   
   select KnownName, measure, fund, 
  null as INITIAL_INVESTMENT,
  '7' AS MEASURE_TYPE from  

  (


  SELECT distinct
	(position   -  (isnull(sum(sell),0 +  sum(buy)))) -  CASE
      WHEN isnull(position,0) > 0 THEN isnull(position,0) - isnull(sum(sell),0 +  sum(buy))
    END AS measure,
    p.fund AS FUND,
	p.ticker
  FROM @temp_POS p 
  inner join  @Temp_buy b
  on p.TICKER = b.TICKER and p.FUND =b.FUND
  left join  @Temp_SELL s 
  on p.TICKER = s.TICKER and p.FUND =s.FUND
   --WHERE INTIAL_INVESTMENT = '2018-03-30 00:00:00.000'
 group by   p.fund, p.TICKER, POSITION
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID



	UNION

    select KnownName,
	 measure, 
	 fund, 
	    NULL AS Initial_Investment,
  '8' AS MEASURE_TYPE from  

  (
  SELECT distinct
 ( position    - isnull(sum(sell),0)) / nullif(sum(buy),0) as measure,
    p.fund AS FUND,
	p.ticker
  FROM @temp_POS p 
  inner join  @Temp_buy b
  on p.TICKER = b.TICKER and p.FUND =b.FUND
  left join  @Temp_SELL s 
  on p.TICKER = s.TICKER and p.FUND =s.FUND
   --WHERE INTIAL_INVESTMENT = '2018-03-30 00:00:00.000'
 group by   p.fund, p.TICKER, POSITION
  ) p 
  LEFT JOIN Investment.T_UnquotedSecurities us --1 issuer can have 1 or more securities
    ON us.Ticker = p.TICKER
  LEFT JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID



  UNION
  
  select * FROM 
  (
     SELECT DISTINCT
 
 	KnownName AS KnownLegalName,
    NULL AS MEASURE,
	FUND,
	NULL AS  INITIAL_INVESTMENT,
	'9' AS MEASURE_TYPE
    

  FROM @Temp_buy A
  INNER JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  INNER JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID

	UNION
	
	
		SELECT
		KnownName AS KnownLegalName,
    NULL AS MEASURE,
	FUND,
	NULL AS  INITIAL_INVESTMENT,
	'9' AS MEASURE_TYPE
	FROM @Temp_SELL A
  INNER JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  INNER JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	 
UNION

		SELECT
		KnownName AS KnownLegalName,
    NULL AS MEASURE,
	FUND,
	NULL AS  INITIAL_INVESTMENT,
	'9' AS MEASURE_TYPE
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

) PR

	



	
DECLARE @Test MyXirrTable
Insert into @Test([theValue],[theDate],[KnownName],[Fund_Type])
  	 
	 
	   SELECT DISTINCT
 
    -BUY AS MEASURE,
	INITIAL_INVESTMENT,
	KnownName AS KnownLegalName,
    FUND

  FROM @Temp_buy A
  INNER JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  INNER JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID

	UNION
	
	   SELECT DISTINCT
 
    SELL AS MEASURE,
	INITIAL_INVESTMENT,
	KnownName AS KnownLegalName,
    FUND
	FROM @Temp_SELL A
  INNER JOIN Investment.T_UnquotedSecurities us
    ON us.Ticker = A.TICKER
  INNER JOIN Investment.T_UnquotedIssuers ti
    ON ti.ID = us.IssuerID
	 
UNION

	   select  measure,
     INTIAL_INVESTMENT AS INITIAL_INVESTMENT,
	 KnownName,
	  fund
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
order by KnownName


	




DECLARE @theValue VARCHAR(50)  
DECLARE @date datetime
DECLARE @FundType VARCHAR(256) 
DECLARE @KnownName VARCHAR(256)


DECLARE xirr_cursor CURSOR FOR 
SELECT distinct  Fund_Type
FROM @Test


OPEN xirr_cursor  
FETCH NEXT FROM xirr_cursor INTO  @FundType

WHILE @@FETCH_STATUS = 0  
BEGIN  



--select dbo.XIRR(@Test, 0.1,@KnownName, @FundType) * 100, KnownLegalName  Fund_Type  from  @temp_Perf
--where Fund_Type = @fundtype
--and Measure_Type = 9

UPDATE tp
SET MEASURE = (SELECT	dbo.XIRR(@Test, 0.1, @FundType))  * 100 
from @temp_Perf tp
WHERE Measure_Type = '9' 
and Fund_Type = @FundType



--Fetch Next Fundtype and KnownName into the Cursor
FETCH NEXT FROM xirr_cursor INTO   @FundType
END 

CLOSE xirr_cursor  
DEALLOCATE xirr_cursor 






SELECT
  *
FROM @temp_Perf
----WHERE KnownLegalName = 'GigaClear'
ORDER BY Measure_Type  DESC


