

CREATE VIEW  [dbo].[vw_UnquotedFundingRevaluation]


AS

---------------------------------------------------------------------------------------- 
---- Name: [dbo].[vw_UnquotedFundingRevaluation]
---- 
---------------------------------------------------------------------------------------- 
---- History:

---- WHO WHEN WHY
---- Olu : 05/07/2018 JIRA: DAP-2035 - vw_UnquotedFundingRevaluation
---- OLU : 26/11/2018 JIRA: DAP-2408 - Add EDM_SEC_ID as part of the field being returned as a result of 
--	 Olu:  18/12/2018 - DAP-2434 Add EDM_SEC_ID to join to revaluation table in subquery   
---- Olu:  01/02/2019 --DAP-2500 Add FullAllocationsProvided to output of view
-----Olu  08/02/2019 --DAP-2489 Refactor view to use new Base tables -- T_FUNDING_PORTFOLIO_ALLOCATION,T_FUNDING_SECURITY_ALLOCATION, T_MASTER_FND
---------------------------------------------------------------------------------------- 

---- View logic goes here



  SELECT B.fundingid, 
         B.allocationamount, 
         M.SHORT_NAME AS FUND_SHORT_NAME, 
         revaluation_id, 
         [actual_enactment_date], 
         [expected_enactment_date], 
         [tech_status], 
         tradedate       AS Trade_Date ,
		 EDM_SEC_ID,
		 FullAllocationsProvided
  FROM   (SELECT tf.FundingID AS FundingId, 
                 TA.FUND_SHORT_NAME, 
                 CASE 
                   WHEN tf.fullallocationsprovided = 0 THEN ta.InitialAllocationAmount 
                   WHEN tf.fullallocationsprovided = 1 THEN 
                   Sum(sa.allocationamount) 
                 END   AS AllocationAmount, 
                 [revaluation_id], 
                 [actual_enactment_date], 
                 [expected_enactment_date], 
                 [tech_status], 
                 tf.tradedate,
				 r.EDM_SEC_ID,
				 FullAllocationsProvided
          FROM  dbo.T_MASTER_FUNDING tf 
                 LEFT JOIN dbo.T_FUNDING_PORTFOLIO_ALLOCATION ta 
                        ON tf.FundingID = ta.fundingid 
                 LEFT JOIN dbo.T_FUNDING_SECURITY_ALLOCATION sa 
                        ON SA.AllocationID = Ta.AllocationID
                 LEFT JOIN (SELECT distinct
									
                                   Max([revaluation_id]) AS [REVALUATION_ID], 
                                   [actual_enactment_date], 
                                   [expected_enactment_date], 
                                   [tech_status] ,
								   sm.EDM_SEC_ID
                            FROM   
                                  t_master_sec sm     
                                   LEFT JOIN [dbo].[t_unquoted_revaluation] r 
                                          ON R.EDM_ISSUER_ID = SM.EDM_ISSUER_ID 
									and r.EDM_SEC_ID =sm.EDM_SEC_ID
                            GROUP  BY [actual_enactment_date], 
                                      [expected_enactment_date], 
                                      [tech_status],
									  sm.EDM_SEC_ID,
									  sm.SECURITY_NAME,
									sm.TICKER) R 
                        ON SA.EDM_SEC_ID = R.EDM_SEC_ID 
          GROUP  BY TA.FUND_SHORT_NAME, 
                    fullallocationsprovided, 
                    tf.FundingID, 
                    revaluation_id, 
                    [actual_enactment_date], 
                    [expected_enactment_date], 
                    [tech_status], 
                    ta.InitialAllocationAmount, 
                    tradedate,
					r.EDM_SEC_ID) B 
         LEFT JOIN T_MASTER_FND M 
               ON B.FUND_SHORT_NAME = M.SHORT_NAME 


		

