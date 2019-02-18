CREATE VIEW [Access.ManyWho].[UnquotedCompaniesReadOnlyVw]
	AS
SELECT uc.[CompanyId]
	 , uc.[CompanyName]
	 , uc.[CompanySalesforceId]
	 , uc.[PrimaryContactSalesforceId]
	 , uc.[InvestmentAnalystPersonId]
	 , iap.PersonsName as InvestmentAnalyst
	 , uc.[InvestmentManagerOwnerPersonId]
	 , imp.PersonsName as InvestmentManager
	 , uc.[CurrentUnquotedCompanyStage]
	 , cs.CompanyStageDescription
	 , uc.[NextReviewDate]
     , uc.[CompanyOverview]
     , uc.[NotesForSalesTeam]
     , uc.[CurrentPrice]
     , uc.[CurrencyCode]
	 , uc.[CompanyRootFolderURL]
 	 , uc.[InitialInformationFolderURL]
	 , uc.[InitialInvestmentRulesAssessment]
	 , uc.[SectorId]
	 , sec.Sector
	 , uc.[SubSectorId]
	 , sub.Sector as SubSector
	 , uc.[CountryISOCode]
	 , cou.Country
	 , uc.[WIMEIFCompanyMaturityId]
	 , cm.CompanyMaturity as WIMEIFCompanyMaturity
	 , uc.[WIMPCTCompanyMaturityId]
	 , cm1.CompanyMaturity as WIMPCTCompanyMaturity
	 , uc.[InvestmentDate]
	 , uc.[NAVatInvestment]
	 , uc.[JiraEpicKey]
	 , uc.[JiraIssueKey]
	 , uc.[ComplianceChecksComplete]
	 , uc.[InvestmentTrustBoardReporting]
	 , uc.[DevelopmentClassificationId]
	 , ds.[Name] as DevelopmentClassification
	 , uc.[PrimaryRelationInvestmentSourceId]
	 , iso.[Name] as PrimaryInvestmentSource
	 , uc.[SecondaryRelationEstEvergreenVentureId]
	 , eev.[Name] as SecondaryEstablishedEvergreenVenture
	 , uc.[IsFCARegulated]
	 , uc.[IsSRARegulated]
	 , uc.[JoinGUID]
	 , uc.[CompaniesCreationDate]
	 , uc.[CompaniesLastModifiedDate]
  FROM [Investment].[Companies] uc
  LEFT OUTER JOIN [Core].[Persons] iap
  ON uc.InvestmentAnalystPersonId = iap.PersonId
  LEFT OUTER JOIN [Core].[Persons] imp
  ON uc.InvestmentManagerOwnerPersonId = imp.PersonId 
  INNER JOIN [Unquoted].[CompanyStages] cs
  ON uc.CurrentUnquotedCompanyStage = cs.CompanyStage
  LEFT OUTER JOIN [Core].[Sectors] sec
  ON uc.SectorId = sec.SectorId
  LEFT OUTER JOIN [Core].[Sectors] sub
  ON uc.SectorId = sub.SectorId 
  LEFT OUTER JOIN [Core].[Countries] cou
  ON uc.CountryISOCode = cou.ISOCode
  LEFT OUTER JOIN [Core].[CompanyMaturities] cm
  ON uc.WIMEIFCompanyMaturityId = cm.CompanyMaturityId
  LEFT OUTER JOIN [Core].[CompanyMaturities] cm1
  ON uc.WIMPCTCompanyMaturityId = cm1.CompanyMaturityId
  LEFT OUTER JOIN [Investment].[DevelopmentStages] ds
  ON ds.Id = uc.DevelopmentClassificationId
  LEFT OUTER JOIN [Investment].[InvestmentSources] iso
  ON iso.Id = uc.PrimaryRelationInvestmentSourceId
  LEFT OUTER JOIN [Investment].[EstablishedEvergreenVentures] eev
  ON eev.Id = uc.SecondaryRelationEstEvergreenVentureId  
  WHERE uc.IsQuotedCompany=0
