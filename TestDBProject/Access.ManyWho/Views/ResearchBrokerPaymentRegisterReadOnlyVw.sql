


CREATE VIEW [Access.ManyWho].[ResearchBrokerPaymentRegisterReadOnlyVw]
	AS 

-- B.Katsadoros: 15/09/2017 JIRA: DAP-1281 [New 3rd Party Research Payments flow]

SELECT
	rbpr.ResearchBrokerPaymentId,
	rbpr.ResearchBrokerId,				
	rbr.BrokerCompanyName,
	rbpr.StatusId,
	rbps.StatusName,
	rbpr.QuarterId,
	rbpq.QuarterEndingName,
	rbpr.QuarterBudget,
	rbpr.BrokerLetterSentDate,
	rbpr.InvoicedAmount,
	rbpr.InvoiceSentDate,
	rbpr.PaidAmount,
	rbpr.PaymentDate,
	rbpr.SubmittedByPersonId,      
	cp.PersonsName,
	rbpr.DocumentationFolderLink,
	rbpr.JoinGUID,
	rbpr.CADIS_SYSTEM_INSERTED,
	rbpr.CADIS_SYSTEM_UPDATED,
	rbpr.CADIS_SYSTEM_CHANGEDBY,
	rbpr.CADIS_SYSTEM_LASTMODIFIED	
  FROM [Investment].[ResearchBrokerPaymentRegister] rbpr
  INNER JOIN [Investment].[ResearchBrokerRegister] rbr
  ON rbpr.ResearchBrokerId = rbr.ResearchBrokerId 

  INNER JOIN [Investment].[ResearchBrokerPaymentStatus] rbps
  ON rbpr.StatusId = rbps.StatusId
  
  INNER JOIN [Core].[Persons] cp
  ON rbpr.SubmittedByPersonId = cp.PersonId

  INNER JOIN [Investment].[ResearchBrokerQuarter] rbpq
  ON rbpr.QuarterId = rbpq.QuarterId;

