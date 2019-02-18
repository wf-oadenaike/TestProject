
CREATE VIEW   [Reporting].[vw_CashLadderSummaryFund]

AS

-- History:

-- WHO WHEN WHY
-- D.Bacchus: 15/05/2017 JIRA: DAP-XXX [Brief Description]
--
-- 
-------------------------------------------------------------------------------------- 



-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_CashLadderSummaryFund]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- OLU: 18/07/2018 JIRA: DAP-2209 [Create a view for CashLadderSummaryFund] function
--
-- 
-------------------------------------------------------------------------------------- 

select * from [Access.WebDev].[ufn_CashLadderSummaryFundTotal](NULL)
