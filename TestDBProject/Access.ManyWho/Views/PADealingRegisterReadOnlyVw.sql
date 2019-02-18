
CREATE VIEW [Access.ManyWho].[PADealingRegisterReadOnlyVw]
	AS 	
SELECT pdrr.PADealingRegisterId
	 , pdrr.RequestorPersonId
	 , rp.PersonsName as RequestorName
	 , pdrr.RequestedDate
	 , (CASE WHEN pdrr.WithdrawalRequestedYesNo = 'True' THEN 'Withdrawal requested' ELSE pdrr.status END) as 'Status'
	 , pdrr.OnStopList
	 , pdrr.BloombergId
	 , CASE WHEN pdrr.BloombergId IS NULL THEN pdrr.InvestmentName ELSE ms.Name END as InvestmentName
	 , pdrr.InvestmentType
	 , pdrr.TransactionType
	 , pdrr.WoodfordInvestmentYesNo 
	 , pdrr.Value
	 , pdrr.CurrencyCode
	 , pdrr.NumOfShares
	 , pdrr.SalaryPercentage
	 , pdrr.EmployeeComments
	 , pdrr.ComplianceComments
	 , pdrr.ComplianceDecisionDate
	 , pdrr.CompliancePersonId
	 , cp.PersonsName as CompliancePerson
	 , pdrr.WithdrawalRequestedYesNo
	 , pdrr.JIRAIssueKey
	 , pdrr.DocumentationFolderLink
	 , pdrr.JoinGUID
	 , pdrr.PADealingCreationDatetime
	 , pdrr.PADealingLastModifiedDatetime
  FROM [Compliance].[PADealingRegister] pdrr
  INNER JOIN [Core].[Persons] rp
  ON pdrr.RequestorPersonId = rp.PersonId
  LEFT OUTER JOIN [Access.ManyWho].[MasterSecuritiesVw] ms
  ON ms.BloombergId = pdrr.BloombergId
  LEFT OUTER JOIN [Core].[Persons] cp
  ON pdrr.CompliancePersonId = cp.PersonId 

  ;

