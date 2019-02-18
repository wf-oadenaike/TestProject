CREATE VIEW [Access.ManyWho].[UnquotedSecuritiesInFundReadOnlyVw]
	AS
  SELECT uc.[CompanyId],  
         uc.[CompanyName],
		 usr.[SecurityBloombergId],
	     ms.[SECURITY_NAME] as SecurityName,
		 sfi.[FundCode], 
		 usr.[EventType], 
		 usr.[IsActive], 
         usr.[Status], 
		 usr.[Notes],
		 usr.[PresentedToPricingCommittee],
		 usr.[RevaluationPreviousPrice],
		 usr.[RevaluationPrice],
		 usr.[EventDate], 
		 usr.[RevaluationEndDate], 
		 usr.[SecurityRevaluationCreationDate],
		 usr.[SecurityRevaluationLastModifiedDate]
  FROM [Unquoted].[SecurityRevaluation] usr
  INNER JOIN [Investment].[CompanySecurities] cs
  ON usr.[SecurityBloombergId] = cs.[SecurityBloombergId]
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON cs.SecurityBloombergId = ms.UNIQUE_BLOOMBERG_ID
  INNER JOIN [Investment].[Companies] uc
  ON cs.[CompanyId] = uc.[CompanyId]
  INNER JOIN [Unquoted].[SecurityFundInvestments] sfi
  ON sfi.[SecurityBloombergId] = usr.[SecurityBloombergId]
  WHERE uc.IsQuotedCompany=0 

 ;
