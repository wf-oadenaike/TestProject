CREATE view  dbo.vw_UnquotedFundingRevalution
as
  select  
  B.FundingId,
  B.AllocationAmount,
  M.PortfolioCode as FUND_SHORT_NAME, 
  Revaluation_ID,
  [ACTUAL_ENACTMENT_DATE],
  [EXPECTED_ENACTMENT_DATE],
  [TECH_STATUS],
   TradeDate as Trade_Date
  from  
  (
  select  tf.id as FundingId, 
   TA.PortfolioID,
  Case when tf.FullAllocationsProvided = 0 then  ta.Allocationamount
		when  tf.FullAllocationsProvided = 1 then sum(pf.Allocationamount) end as AllocationAmount,
[REVALUATION_ID],
 [ACTUAL_ENACTMENT_DATE],
  [EXPECTED_ENACTMENT_DATE],
  [TECH_STATUS],
  tf.TradeDate
    from  Investment.T_UnquotedFundings tf
  left join Investment.T_UnquotedFundingInitialAllocations  ta
  on tf.id = ta.FundingID
  left join  Investment.T_UnquotedFundingSecurityAllocations sa 
  ON SA.FundingID =TF.ID
  LEFT JOIN  [Investment].[T_UnquotedSecurities] US
  ON US.ID = SA.SecurityID
  left join   Investment.T_UnquotedFundingPortfolioAllocations pf
  on pf.SecurityAllocationID =  SA.ID AND PF.PortfolioID = TA.PortfolioID
  LEFT JOIN (SELECT
  S.ID,
  s.Name,
  s.Ticker,
  MAX([REVALUATION_ID]) AS [REVALUATION_ID],
  [ACTUAL_ENACTMENT_DATE],
  [EXPECTED_ENACTMENT_DATE],
  [TECH_STATUS]
FROM Investment.T_UnquotedSecurities s
LEFT JOIN T_MASTER_SEC sm
  ON sm.ticker = s.ticker
LEFT JOIN [dbo].[T_UNQUOTED_REVALUATION] r
  ON R.[EDM_SEC_ID] = SM.[EDM_SEC_ID]
GROUP BY [ACTUAL_ENACTMENT_DATE],
         [EXPECTED_ENACTMENT_DATE],
         s.Name,
         s.Ticker,
         S.ID,
         [TECH_STATUS]) R
  ON SA.SecurityID = R.ID
  --where tf.id =55
  group by 
   TA.PortfolioID,
   FullAllocationsProvided,
   tf.id,
   Revaluation_ID,
    [ACTUAL_ENACTMENT_DATE],
  [EXPECTED_ENACTMENT_DATE],
  [TECH_STATUS],
   ta.Allocationamount,
   TradeDate 
  ) B
  LEFT JOIN Investment.mandates M
  ON B.PortfolioID = M.MandateId
  
 
