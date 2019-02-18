CREATE VIEW [Access.ManyWho].[ResearchBrokerRegisterVw]
	AS 
SELECT
       ResearchBrokerId
	 , BrokerCompanyName
	 , BloombergId
	 , BrokerServiceTypeId
	 , UnderCSAControl
	 , ServiceCost
	 , ResearchCostWIMFundsPercent
	 , ResearchCostWIMLLPPercent
	 , PaymentFrequencyId
	 , PaymentTerms
	 , ServiceDescription
	 , RecordedByPersonId
	 , BrokerRelationshipPersonId
	 , ResearchAccountSalesforceId
	 , InitialBudgetAmount
	 , InitialBudgetDate
	 , DocumentationFolderLink
	 , JoinGUID
	 , ResearchBrokerCreationDatetime
	 , ResearchBrokerLastModifiedDatetime
  FROM [Investment].[ResearchBrokerRegister]
