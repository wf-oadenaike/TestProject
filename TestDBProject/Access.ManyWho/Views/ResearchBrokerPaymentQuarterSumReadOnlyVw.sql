
CREATE VIEW [Access.ManyWho].[ResearchBrokerPaymentQuarterSumReadOnlyVw]
	AS 

-- B.Katsadoros: 15/09/2017 JIRA: DAP-1281 [New 3rd Party Research Payments flow]

SELECT
	R.QuarterId,
	RQ.QuarterEndingName,
	SUM(R.QuarterBudget) as TotalQuarterBudget,
	SUM(R.InvoicedAmount) as TotalQuarterInvoicedAmount,
	SUM(R.PaidAmount) as TotalQuarterPaidAmount

  FROM 
	Investment.ResearchBrokerPaymentRegister	R
  INNER JOIN 
	Investment.ResearchBrokerQuarter			RQ ON R.QuarterId = RQ.QuarterId

  GROUP BY R.QuarterId, RQ.QuarterEndingName

