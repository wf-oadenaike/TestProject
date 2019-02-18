
CREATE VIEW  [Reporting].[vw_ResearchBudgetFigures]

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



SELECT

	   rbr.BrokerCompanyName
	 , rbr.BloombergId

	  , ISNULL(rbr.InitialBudgetAmount,0) as InitialFiscalYearBudget
	  


	 , (ISNULL(rbr.InitialBudgetAmount,0) + ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 WHERE rbr.[ResearchBrokerId] = rbbc.[ResearchBrokerId]
		 AND rbbc.[BudgetAmendmentDate] <= GetDate()), 0)) as CurrentFiscalYearBudget
	
	
	 ,  (ISNULL(rbr.InitialBudgetAmount,0) + ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 WHERE rbr.[ResearchBrokerId] = rbbc.[ResearchBrokerId]
		 AND rbbc.[BudgetAmendmentDate] <= GetDate()), 0)) / 4 as CurrentQuarterBudget



	 , (ISNULL(rbr.InitialBudgetAmount,0) + ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbr.[ResearchBrokerId] = rbbc.[ResearchBrokerId]
		 AND rbbc.[BudgetAmendmentDate] <= DATEADD(QQ,-2,cal.FiscalFirstDayOfQuarter)),0))/4 as PreviousQuarterBudget

		  , (ISNULL((SELECT SUM(rbbc.ChangeAmount) /4
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbr.[ResearchBrokerId] = rbbc.[ResearchBrokerId]
		 AND rbbc.[BudgetAmendmentDate] BETWEEN (SELECT DISTINCT cal1.FiscalFirstDayOfQuarter FROM [Core].[Calendar] cal1 WHERE cal1.FiscalLastDayOfQuarter = DATEADD(d,-1,cal.FiscalFirstDayOfQuarter)) AND DATEADD(d,-1,cal.FiscalFirstDayOfQuarter)),0)) as PreviousQuarterBudgetChanges


	,	CASE 
			WHEN InvoiceSentDate IS NOT NULL THEN 'Yes' ELSE 'No' END AS [Invoice Sent]
	,	CASE 
			WHEN [PaymentDate] IS NOT NULL THEN 'Yes' ELSE 'No' END AS [PAID]
	,InvoiceSentDate
	,[PaymentDate]
	-- --,	CASE 
	--	--	WHEN rbpe.EventTypeId = 4 THEN 'Yes' ELSE  'No' END AS [Invoice Sent]
	 
	-- --,	CASE 
		--	WHEN rbpe.EventTypeId = 5 THEN 'Yes' ELSE  'No' END AS [PAID]
	 
  FROM [Investment].[ResearchBrokerRegister] rbr
  LEFT OUTER JOIN [Investment].[ResearchBrokerPaymentFrequency] pf
  ON rbr.PaymentFrequencyId = pf.PaymentFrequencyId
  INNER JOIN [Organisation].[BrokerServiceTypes] st
  ON rbr.BrokerServiceTypeId = st.ServiceTypeId
  INNER JOIN [Core].[Persons] rp
  ON rbr.RecordedByPersonId = rp.PersonId
  INNER JOIN [Core].[Persons] brp
  ON rbr.BrokerRelationshipPersonId = brp.PersonId
  LEFT JOIN (SELECT [ResearchBrokerId], MAX (InvoiceSentDate) AS InvoiceSentDate,  MAX([PaymentDate]) as [PaymentDate]
			  FROM Investment.ResearchBrokerPaymentRegister rpr
			   INNER JOIN [Core].[Calendar] cal
				ON cal.[CalendarDate]=CAST(GetDate() as date)
				WHERE [InvoiceSentDate] between DATEADD(qq, -1,FiscalFirstDayOfQuarter) and  DATEADD(QQ, -1, FiscalLastDayOfQuarter)  
			  GROUP BY [ResearchBrokerId] 
			) rbpr
ON rbpr.[ResearchBrokerId] = rbr.[ResearchBrokerId]




