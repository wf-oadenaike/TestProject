
CREATE VIEW [Access.ManyWho].[ResearchBrokerRegisterReadOnlyVw]
	AS 
SELECT
       rbr.ResearchBrokerId
	 , rbr.BrokerCompanyName
	 , rbr.BloombergId
	 , rbr.BrokerServiceTypeId
	 , st.ServiceType
	 , CASE WHEN rbr.UnderCSAControl=0 THEN 'No' WHEN rbr.UnderCSAControl=1 THEN 'Yes' ELSE NULL END as UnderCSAControl
	 , rbr.ServiceCost
	 , rbr.ResearchCostWIMFundsPercent
	 , rbr.ResearchCostWIMLLPPercent
	 , rbr.PaymentFrequencyId
	 , pf.PaymentFrequency
	 , rbr.PaymentTerms
	 , rbr.ServiceDescription
	 , (ISNULL(rbr.InitialBudgetAmount,0) + ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 WHERE rbr.[ResearchBrokerId] = rbbc.[ResearchBrokerId]
		 AND rbbc.[BudgetAmendmentDate] <= GetDate()), 0)) as CurrentFiscalYearBudget
	 , (ISNULL(rbr.InitialBudgetAmount,0) + ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbr.[ResearchBrokerId] = rbbc.[ResearchBrokerId]
		 AND rbbc.[BudgetAmendmentDate] <= cal.FiscalLastDayOfQuarter),0))/4 as CurrentQuarterBudget
	 , (ISNULL(rbr.InitialBudgetAmount,0) + ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbr.[ResearchBrokerId] = rbbc.[ResearchBrokerId]
		 AND rbbc.[BudgetAmendmentDate] <= DATEADD(d,-1,cal.FiscalFirstDayOfQuarter)),0))/4 as PreviousQuarterBudget
	 , (ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbr.[ResearchBrokerId] = rbbc.[ResearchBrokerId]
		 AND rbbc.[BudgetAmendmentDate] BETWEEN cal.FiscalFirstDayOfQuarter AND cal.FiscalLastDayOfQuarter),0)) as CurrentQuarterBudgetChanges
	 , (ISNULL((SELECT SUM(rbbc.ChangeAmount) 
		 FROM  [Investment].[ResearchBrokerBudgetChanges] rbbc
		 INNER JOIN [Core].[Calendar] cal
		 ON cal.[CalendarDate]=CAST(GetDate() as date)
		 WHERE rbr.[ResearchBrokerId] = rbbc.[ResearchBrokerId]
		 AND rbbc.[BudgetAmendmentDate] BETWEEN (SELECT DISTINCT cal1.FiscalFirstDayOfQuarter FROM [Core].[Calendar] cal1 WHERE cal1.FiscalLastDayOfQuarter = DATEADD(d,-1,cal.FiscalFirstDayOfQuarter)) AND DATEADD(d,-1,cal.FiscalFirstDayOfQuarter)),0)) as PreviousQuarterBudgetChanges	
	 , rbr.RecordedByPersonId
	 , rp.PersonsName as RecordedBy
	 , rp.EmployeeBK as RecordedSalesforceUserId
	 , rbr.BrokerRelationshipPersonId
	 , brp.PersonsName as BrokerRelationshipPerson
	 , brp.EmployeeBK as BrokerRelationshipSalesforceUserId
	 , rbr.ResearchAccountSalesforceId
	 , rbr.InitialBudgetAmount
	 , rbr.InitialBudgetDate
	 , rbr.DocumentationFolderLink
	 , rbr.JoinGUID
	 , rbr.ResearchBrokerCreationDatetime
	 , rbr.ResearchBrokerLastModifiedDatetime
	 , rbr.IsActive 
  FROM [Investment].[ResearchBrokerRegister] rbr
  LEFT OUTER JOIN [Investment].[ResearchBrokerPaymentFrequency] pf
  ON rbr.PaymentFrequencyId = pf.PaymentFrequencyId
  INNER JOIN [Organisation].[BrokerServiceTypes] st
  ON rbr.BrokerServiceTypeId = st.ServiceTypeId
  INNER JOIN [Core].[Persons] rp
  ON rbr.RecordedByPersonId = rp.PersonId
  INNER JOIN [Core].[Persons] brp
  ON rbr.BrokerRelationshipPersonId = brp.PersonId

  ;

