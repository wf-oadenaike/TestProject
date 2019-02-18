CREATE PROCEDURE [Reporting.Investment].[usp_GetFullPortfolioDetails]
	@PositionDate date = NULL
AS
Set NoCount on

	SELECT * FROM (
		SELECT
			PRICE_DATE
			,FUND_SHORT_NAME
			,mv.EDM_SEC_ID
			,mv.UNIQUE_BLOOMBERG_ID
			,COALESCE(lc.ListedCompanyName, uc.UnquotedCompanyName,mv.SECURITY_NAME) AS CompanyName
			,mv.PARSEKEYABLE_DESCRIPTION AS Ticker
			,mv.SECURITY_ISO_CCY AS CurrencyCode
			,LONG_SHORT_IND
			,QUANTITY
			,IsUnquoted
			,tms.ISSUE_COUNTRY_ISO AS GeographyISO
			,cc.Country AS [Geography]
			,MARKET_VALUE_LOCAL
			,MARKET_VALUE_BASE
			,UnquotedSecuritiesId
			,uc.UnquotedCompanyId
			,lc.ListedCompanyId
			,COALESCE(imPersons1.PersonsName, imPersons.PersonsName) AS InvestmentManager
			,COALESCE(iaPersons1.PersonsName, iaPersons.PersonsName) AS InvestmentAnalyst
			,COALESCE(s1.Sector, s.Sector, tms.[BBG_SECTOR]) AS Sector
			,COALESCE(ss1.Sector, ss.Sector, [BBG_SUBSECTOR]) AS SubSector
			,COALESCE(cmWEIF1.CompanyMaturity, cmWEIF.CompanyMaturity) AS CompanyMaturityWEIF
			,COALESCE(cmPCT1.CompanyMaturity, cmPCT.CompanyMaturity) AS CompanyMaturityPCT
			,COALESCE(lc.DevelopmentClassification, ucai.DevelopmentClassification) AS DevelopmentClassification
			,0 AS IsCash
			,COALESCE(is1.Name, is2.Name) AS InvestmentSource
			,COALESCE(eev1.Name, eev2.Name) AS EstablishedEvergreenVenture
		FROM [Reporting.Investment].[ufn_GetFundHoldingsMarketValue] (@PositionDate) mv
		LEFT JOIN [dbo].[T_MASTER_SEC] tms ON tms.EDM_SEC_ID = mv.EDM_SEC_ID
		LEFT JOIN [Organisation].[UnquotedSecurities] us ON us.[BBGUniqueId/FOID] = mv.[UNIQUE_BLOOMBERG_ID]
		LEFT JOIN [Organisation].[UnquotedCompanies] uc ON us.UnquotedCompanyId = uc.UnquotedCompanyId
		LEFT JOIN [Organisation].[UnquotedCompanyAdditionalInfo] ucai ON ucai.UnquotedCompanyId = uc.UnquotedCompanyId
		LEFT JOIN [Core].[Sectors] s ON ucai.SectorId = s.SectorId
		LEFT JOIN [Core].[Sectors] ss ON ucai.SubSectorId = ss.SectorId
		LEFT JOIN [Core].[CompanyMaturities] cm ON ucai.CompanyMaturityId = cm.CompanyMaturityId
		LEFT JOIN [Core].[CompanyMaturities] cmWEIF ON ucai.WIMEIFCompanyMaturityId = cmWEIF.CompanyMaturityId
		LEFT JOIN [Core].[CompanyMaturities] cmPCT ON ucai.WIMPCTCompanyMaturityId = cmPCT.CompanyMaturityId
		LEFT JOIN [Core].[Persons] imPersons ON imPersons.PersonId = uc.InvestmentManagerOwnerPersonId
		LEFT JOIN [Core].[Persons] iaPersons ON iaPersons.PersonId = uc.InvestmentAnalystPersonId
		LEFT JOIN [Core].[Countries] cc ON cc.ISOCode = tms.ISSUE_COUNTRY_ISO

		LEFT JOIN [unquoted].[ListedSecurities] ls ON ls.UniqueBloombergId = mv.UNIQUE_BLOOMBERG_ID
		LEFT JOIN [unquoted].[ListedCompanies] lc ON ls.ListedCompanyId = lc.ListedCompanyId
		LEFT JOIN [Core].[Sectors] s1 ON lc.SectorId = s1.SectorId
		LEFT JOIN [Core].[Sectors] ss1 ON lc.SubSectorId = ss1.SectorId
		LEFT JOIN [Core].[Persons] imPersons1 ON imPersons1.PersonId = lc.InvestmentManagerOwnerPersonId
		LEFT JOIN [Core].[Persons] iaPersons1 ON iaPersons1.PersonId = lc.InvestmentAnalystPersonId
		LEFT JOIN [Core].[CompanyMaturities] cmWEIF1 ON lc.WIMEIFCompanyMaturityId = cmWEIF1.CompanyMaturityId
		LEFT JOIN [Core].[CompanyMaturities] cmPCT1 ON lc.WIMPCTCompanyMaturityId = cmPCT1.CompanyMaturityId

		LEFT JOIN [Investment].[InvestmentSources] is1 ON is1.Id = ucai.PrimaryRelationInvestmentSource
		LEFT JOIN [Investment].[InvestmentSources] is2 ON is2.Id = lc.PrimaryRelationInvestmentSource
		LEFT JOIN [Investment].[EstablishedEvergreenVentures] eev1 ON eev1.Id = ucai.SecondaryRelationEstEvergreenVentureId
		LEFT JOIN [Investment].[EstablishedEvergreenVentures] eev2 ON eev2.Id = lc.SecondaryRelationEstEvergreenVentureId

		UNION ALL

		SELECT
			LastUpdatedDate AS PriceDate
			,FUND_SHORT_NAME
			,NULL
			,NULL
			,'Cash:' + Description AS CompanyName
			,NULL AS Ticker
			,'GBP' AS CurrencyCode
			,NULL
			,1
			,NULL
			,NULL AS GeographyISO
			,NULL AS [Geography]
			,VALUE
			,VALUE
			,NULL
			,NULL
			,NULL
			,NULL AS InvestmentManager
			,NULL AS InvestmentAnalyst
			,NULL AS Sector
			,NULL AS SubSector
			,NULL AS CompanyMaturityWEIF
			,NULL AS CompanyMaturityPCT
			,NULL AS DevelopmentClassification
			,1 AS IsCash
			,NULL
			,NULL
	FROM [Reporting.Investment].[ufn_GetAUMs] (@PositionDate)
	WHERE Description NOT IN ('Portfolio Market Value') AND IsEstimate = 1
) data
ORDER BY Fund_Short_Name, IsCash, CompanyName
