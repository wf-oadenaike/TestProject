CREATE VIEW [Access.ManyWho].[ShareClassWaiverRegisterReadOnlyVw]
	AS 
SELECT
	   scwr.ShareClassWaiverId
	 , scwr.AgentName
	 , scwr.AccountName
	 , scwr.Designation
	 , scwr.AccountSalesforceId
	 , scwr.ContactSalesforceId
	 , scwr.SalesforceNoteId
	 , scwr.RequestedByPersonId
	 , rp.PersonsName as RequestedBy
	 , scwr.RequestedDate
	 , scwr.Status
	 , scwr.BusinessCase
	 , scwr.Decision
	 , scwr.DecisionDate
	 , scwr.DecisionByPersonId
	 , dp.PersonsName as DecisionBy
	 , scwr.SummaryDetails
	 , scwr.IndicativeFlowImmediately
	 , scwr.IndicativeFlowWithin12Months
	 , scwr.IsUSInvestor
	 , scwr.IsUnregulated
	 , scwr.IsIndividual
	 , scwr.MandateId
	 , m.MandateName
	 , m.PortfolioCode
	 , scwr.ShareClassId
	 , sc.ShareClass
	 , scwr.JiraTaskKey
	 , scwr.DocumentationFolderLink
	 , scwr.JoinGUID
	 , scwr.ShareClassWaiverRegisterCreationDatetime
	 , scwr.ShareClassWaiverRegisterLastModifiedDatetime
  FROM [Investment].[ShareClassWaiverRegister] scwr
  INNER JOIN [Core].[Persons] rp
  ON scwr.RequestedByPersonId = rp.PersonId
  LEFT OUTER JOIN [Core].[Persons] dp
  ON scwr.DecisionByPersonId = dp.PersonId
  LEFT OUTER JOIN [Investment].[Mandates] m
  ON scwr.MandateId = m.MandateId
  LEFT OUTER JOIN [Investment].[ShareClass] sc
  ON scwr.ShareClassId = sc.ShareClassId

  ;
