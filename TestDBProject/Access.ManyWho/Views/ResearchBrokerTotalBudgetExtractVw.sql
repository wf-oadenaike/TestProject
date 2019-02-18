CREATE VIEW [Access.ManyWho].[ResearchBrokerTotalBudgetExtractVw]
	AS 
SELECT (ISNULL(SUM(rbr.InitialBudgetAmount),0) + ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 WHERE rbbc.[BudgetAmendmentDate] <= GetDate()), 0)) as CurrentFiscalYearBudget
	 , (ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbbc.[BudgetAmendmentDate] BETWEEN cal.FiscalFirstDayOfYear AND cal.FiscalLastDayOfYear),0)) as CurrentFiscalYearBudgetChanges
	 , (ISNULL(SUM(rbr.InitialBudgetAmount),0) + ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbbc.[BudgetAmendmentDate] <= cal.FiscalLastDayOfQuarter),0))/4 as CurrentQuarterBudget
	 , (ISNULL(SUM(rbr.InitialBudgetAmount),0) + ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbbc.[BudgetAmendmentDate] <= DATEADD(d,-1,cal.FiscalFirstDayOfQuarter)),0))/4 as PreviousQuarterBudget
	, (ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbbc.[BudgetAmendmentDate] BETWEEN cal.FiscalFirstDayOfQuarter AND cal.FiscalLastDayOfQuarter),0)) as CurrentQuarterBudgetChanges
	 , (ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbbc.[BudgetAmendmentDate] BETWEEN (SELECT DISTINCT cal1.FiscalFirstDayOfQuarter FROM [Core].[Calendar] cal1 WHERE cal1.FiscalLastDayOfQuarter = DATEADD(d,-1,cal.FiscalFirstDayOfQuarter)) AND DATEADD(d,-1,cal.FiscalFirstDayOfQuarter)),0)) as PreviousQuarterBudgetChanges	
  FROM [Investment].[ResearchBrokerRegister] rbr
 
  ;
