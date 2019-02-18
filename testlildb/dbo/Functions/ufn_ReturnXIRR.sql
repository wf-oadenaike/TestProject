
CREATE function [dbo].[ufn_ReturnXIRR]
 (
 @DATE AS DATE
 )
RETURNS 
  @OUTPUT TABLE

  (
    FUND VARCHAR(250),
  ISSUER VARCHAR(250),
  XIRR NUMERIC(38,12)

   )
AS
  BEGIN



  



  with cte_buy as (
select DISTINCT
case when  C_CURRENCY not in ('GBP', 'GBp')
THEN F_PRINCIPAL *  F_EX_RATE
	ELSE F_PRINCIPAL END as principal_b,

 max(d_asofdate) as d_asofdate, 
 c_account, 
 t.ticker,
 edm_sec_id,
 
 coalesce(iss.Issuer_Name,s.issuer) as Issuer_Name 
 
from  [dbo].[test_tca_table] t
left join dbo.test_SEC s
on s.TICKER = t.Ticker
left join dbo.test_iss iss
on iss.EDM_Issuer_ID = s.EDM_ISSUER_ID
where c_side = 'BUY'
AND D_ASOFDATE <= @DATE

group by 
c_account,
F_PRINCIPAL,
F_EX_RATE,
C_CURRENCY,
Issuer_Name,
ISSUER,
t.Ticker,
EDM_SEC_ID

) ,

  cte_sell as (
select DISTINCT
case when C_CURRENCY  <> 'GBP'
THEN F_PRINCIPAL* F_EX_RATE
	ELSE F_PRINCIPAL END as principal_S,
		d_asofdate, 
		c_account, 
 iss.Issuer_Name, 
 t.Ticker
from  [dbo].[test_tca_table] t
left join dbo.test_SEC s
on s.TICKER = t.Ticker
left join dbo.test_iss iss
on iss.EDM_Issuer_ID = s.EDM_ISSUER_ID
where c_side = 'sell'
AND D_ASOFDATE <=  @DATE
) ,

cte_pos as (
SELECT  
CASE WHEN PRICE_ISO_CCY  NOT IN ('GBP','GBp') 
	 THEN  SUM(ISNULL(quantity,0) * (ISNULL(COALESCE(MASTER_PRICE,BID_PRICE),0) * ISNULL(SPOT_RATE,0))) 
	 ELSE SUM(ISNULL(quantity,0) * ISNULL((MASTER_PRICE),0)) END
AS POSITION,
POSITION_DATE, 
FUND_SHORT_NAME,
Issuer_Name
from [dbo].[test_pos] p 
LEFT join dbo.test_SEC s
on s.edm_sec_id = p.EDM_SEC_ID
LEFT join dbo.test_iss iss
on iss.edm_issuer_id = s.EDM_ISSUER_ID
LEFT join  dbo.test_prc pr
on p.POSITION_DATE = pr.price_date
and  PR.EDM_SEC_ID = P.EDM_SEC_ID
left join test_fx fx
on fx.date = (select max(POSITION_DATE) from test_pOS where POSITION_DATE = @DATE )
AND (TO_ISO_CURRENCY_CODE = 'GBP' 
AND FROM_ISO_CURRENCY_CODE  = PRICE_ISO_CCY)
where 
POSITION_DATE =  @DATE
 AND price_type = 'EOD'
 and left(s.ticker,1) = '.'
 
 
group by 
POSITION_DATE, 
FUND_SHORT_NAME,
Issuer_Name,
FROM_ISO_CURRENCY_CODE,
TO_ISO_CURRENCY_CODE,
PRICE_ISO_CCY

),




cte_sum as (
select 
SUM(isnull(-principal_b,0)) as principal ,
D_ASOFDATE as date_b,
C_ACCOUNT,
Issuer_Name as IssuerName
from cte_buy
GROUP BY  D_ASOFDATE, C_ACCOUNT,Issuer_Name
UNION ALL 
select 
SUM(isnull(principal_s,0)) as principal,
D_ASOFDATE as date_b,
C_ACCOUNT,
Issuer_Name as IssuerName
from cte_sell
GROUP BY  D_ASOFDATE, C_ACCOUNT,Issuer_Name
union all 
select 
SUM(ISNULL(POSITION,0)) as principal,
POSITION_DATE as date_b,
FUND_SHORT_NAME,
Issuer_Name as IssuerName
from 
cte_pos
GROUP BY  POSITION_DATE, FUND_SHORT_NAME,Issuer_Name

)



 INSERT INTO @output(
  FUND,
  ISSUER,
   
  XIRR 
 
  )
  SELECT  C_ACCOUNT, issuername,  round(wct.XIRR(isnull(principal,0), date_b, -0.2)* 100,0) as xirr
  from cte_sum 
GROUP BY   C_ACCOUNT, IssuerName
RETURN

END