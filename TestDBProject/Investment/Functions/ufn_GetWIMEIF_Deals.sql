/****** Script for SelectTopNRows command from SSMS  ******/
CREATE FUNCTION [INVESTMENT].[ufn_GetWIMEIF_Deals](@reportdate date = NULL) 
RETURNS @result TABLE (
	[AGENT] [varchar](100) NULL,
	[REPURCHASE] [decimal](16, 2) NULL,
	[SALE] [decimal](16, 2) NULL,
	[GRAND TOTAL][decimal](16, 2) NULL
	)
AS

BEGIN
IF @reportdate IS NULL
	SET @reportdate = @reportdate;

INSERT INTO @result

SELECT COALESCE(AGENT_NAME,MAIN_OWNER_NAME) as AGENT, sum(case when TYPE like '%REPURCHASE%' then VALUE else 0 END) as Repurchase,
sum(case when TYPE like '%SALE%' then VALUE else 0 END ) as Sale,
sum(VALUE) as [Grand Total]
from [dbo].[T_MASTER_DEALS_IN_PROGRESS]
where 
order_date between
DateADD(M,-1,DATEADD(month, DATEDIFF(month, 0, @reportdate), 0)) and
DateADD(s,-1,DATEADD(month, DATEDIFF(month, 0, @reportdate), 0)) --;-- AS EndOfMonth
group by  COALESCE(AGENT_NAME,MAIN_OWNER_NAME)
order by 1




RETURN 

END
  --where ASSET='WIMEIF'
