CREATE PROCEDURE [Reporting.Investment].[usp_GetFullPortfolio]
	@PositionDate date = NULL
AS
	SELECT
		PRICE_DATE
		,FUND_SHORT_NAME
		,mv.EDM_SEC_ID
		,mv.UNIQUE_BLOOMBERG_ID
		,COALESCE(uc.UnquotedCompanyName,mv.SECURITY_NAME) AS CompanyName
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
		,imPersons.PersonsName AS InvestmentManager
		,iaPersons.PersonsName AS InvestmentAnalyst
		,COALESCE(s.Sector, tms.[BBG_SECTOR]) AS Sector
		,COALESCE(ss.Sector, [BBG_SUBSECTOR]) AS SubSector
		,cm.CompanyMaturity AS CompanyMaturity
		,ucai.DevelopmentClassification
	FROM [Reporting.Investment].[ufn_GetFundHoldingsMarketValue] (@PositionDate) mv
	LEFT JOIN [dbo].[T_MASTER_SEC] tms ON tms.EDM_SEC_ID = mv.EDM_SEC_ID
	LEFT JOIN [Organisation].[UnquotedSecurities] us ON us.[BBGUniqueId/FOID] = mv.[UNIQUE_BLOOMBERG_ID]
	LEFT JOIN [Organisation].[UnquotedCompanies] uc ON us.UnquotedCompanyId = uc.UnquotedCompanyId
	LEFT JOIN [Organisation].[UnquotedCompanyAdditionalInfo] ucai ON ucai.UnquotedCompanyId = uc.UnquotedCompanyId
	LEFT JOIN [Core].[Sectors] s ON ucai.SectorId = s.SectorId
	LEFT JOIN [Core].[Sectors] ss ON ucai.SubSectorId = ss.SectorId
	LEFT JOIN [Core].[CompanyMaturities] cm ON ucai.CompanyMaturityId = cm.CompanyMaturityId
	LEFT JOIN [Core].[Persons] imPersons ON imPersons.PersonId = uc.InvestmentManagerOwnerPersonId
	LEFT JOIN [Core].[Persons] iaPersons ON iaPersons.PersonId = uc.InvestmentAnalystPersonId
	LEFT JOIN [Core].[Countries] cc ON cc.ISOCode = tms.ISSUE_COUNTRY_ISO
	ORDER BY Position_Date, Fund_Short_Name, CompanyName
