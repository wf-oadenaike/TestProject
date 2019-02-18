
CREATE VIEW [Access.ManyWho].[UnquotedSecuritiesFundInvestmentsReadOnlyVw]
AS
SELECT sfi.[SecurityFundInvestmentId]
	 , sfi.[SecurityBloombergId]
	 , ms.[SECURITY_NAME] as SecurityName
	 , sfi.[Tranche]
	 , sfi.[FundCode]
	 , sfi.[NumberOfShares]
	 , sfi.[FundAllocation]
	 , sfi.[TotalAmountInvested]
	 , sfi.[PercentageHeldAtClosing]
	 , sfi.[StampDuty]
	 , sfi.[SubmittedByPersonId]
	 , sp.PersonsName
	 , sfi.[JoinGUID]
	 , sfi.[CreationDatetime]
	 , sfi.[LastModifiedDatetime]
  FROM [Unquoted].[SecurityFundInvestments] sfi
  INNER JOIN [Investment].[CompanySecurities] cs
  ON sfi.SecurityBloombergId = cs.SecurityBloombergId
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON cs.SecurityBloombergId = ms.UNIQUE_BLOOMBERG_ID
  LEFT OUTER JOIN [Core].[Persons] sp
  ON sfi.SubmittedByPersonId = sp.PersonId
