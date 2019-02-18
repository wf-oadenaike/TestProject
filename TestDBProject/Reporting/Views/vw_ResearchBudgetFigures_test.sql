
CREATE VIEW  [Reporting].[vw_ResearchBudgetFigures_test]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_ResearchBudgetFigures]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- oLU: 11/07/2018 JIRA: DAP-2198 [Add InitialFiscalYearBudget], Set current quarter to the most recent quarter, Set payment and Invoice sent logic to the most recent quarter it was paid


--
-- 
-------------------------------------------------------------------------------------- 
SELECT brokercompanyname, quarterbudget,quarterendingname, QuarterBudget * 4  as annualbudget, PaidAmount, BrokerLetterSentDate,paymentdate, InvoiceSentDate FROM Investment.ResearchBrokerRegister rt
inner join investment.ResearchBrokerPaymentRegister rp 
on rt.ResearchBrokerId = rp.ResearchBrokerId 
inner join Investment.ResearchBrokerQuarter rq
on rq.QuarterId = rp.QuarterId