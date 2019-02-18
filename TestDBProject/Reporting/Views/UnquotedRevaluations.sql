create view [Reporting].[UnquotedRevaluations]
as
SELECT DISTINCT
uc.UnquotedCompanyName
,ucr.[UnquotedCompanyId]
,ucr.EventDate
,[EventType]
,COALESCE(ucr.[CurrencyCode], uc.[CurrencyCode] ) AS [CurrencyCode]
,[RevaluationPrice]
,us.Ticker as 'TickerUnquotedSecurities'
,imPersons.PersonsName AS InvestmentManager
,iaPersons.PersonsName AS InvestmentAnalyst
,s.Sector AS Sector
,cmWEIF.CompanyMaturity AS CompanyMaturityWEIF
,cmPCT.CompanyMaturity AS CompanyMaturityPCT
,ucai.DevelopmentClassification AS DevelopmentClassification
,pv.POSITION_DATE
,pv.[FUND_SHORT_NAME]
,pv.[SECURITY_NAME]
,pv.[TICKER] as 'TickerPositionMarketValue'
,pv.[UNIQUE_BLOOMBERG_ID]
,pv.[SECURITY_ISO_CCY]
,pv.[LONG_SHORT_IND]
,pv.[QUANTITY]
,pv.[IsUnquoted]
,pv.[ISSUE_COUNTRY_ISO]
,pv.[EODPrice]
,pv.[MidPrice]
,pv.[PreviousEODPrice]
,pv.[PreviousMidPrice]
,pv.[PriceCCY]
,pv.[Multiplier]
,pv.[FUND_MARKET_VALUE_LOCAL]
,pv.[FUND_MARKET_VALUE_BASE]
,pv.[FUND_BASE_CURRENCY]
,pv.[FUND_VALUATION_PERIOD] 
,pv.[FX]
,pv.[PreviousFX]
,pv.[MARKET_VALUE_BASE]
FROM [Organisation].[UnquotedCompanyRevaluation] ucr 
LEFT JOIN [Organisation].[UnquotedCompanies] uc ON uc.UnquotedCompanyId = ucr.UnquotedCompanyId
LEFT JOIN [Organisation].[UnquotedSecurities] us ON us.[UnquotedCompanyId] = uc.UnquotedCompanyId
LEFT JOIN [Organisation].[UnquotedCompanyAdditionalInfo] ucai ON ucai.UnquotedCompanyId = uc.UnquotedCompanyId
LEFT JOIN [Core].[Sectors] s ON ucai.SectorId = s.SectorId
LEFT JOIN [Core].[CompanyMaturities] cm ON ucai.CompanyMaturityId = cm.CompanyMaturityId
LEFT JOIN [Core].[CompanyMaturities] cmWEIF ON ucai.WIMEIFCompanyMaturityId = cmWEIF.CompanyMaturityId
LEFT JOIN [Core].[CompanyMaturities] cmPCT ON ucai.WIMPCTCompanyMaturityId = cmPCT.CompanyMaturityId
LEFT JOIN [Core].[Persons] imPersons ON imPersons.PersonId = uc.InvestmentManagerOwnerPersonId
LEFT JOIN [Core].[Persons] iaPersons ON iaPersons.PersonId = uc.InvestmentAnalystPersonId
LEFT JOIN (SELECT 
[EventDate]
,MAX(pv.POSITION_DATE) AS POSITION_DATE
FROM
[Organisation].[UnquotedCompanyRevaluation] ucr
LEFT JOIN [Reporting].[PositionsMarketValue] pv ON pv.POSITION_DATE <= ucr.[EventDate]
WHERE EventType = 'Revaluation' 
GROUP BY [EventDate]) dt ON dt.EventDate = ucr.EventDate
LEFT JOIN [Reporting].[PositionsMarketValue] pv ON pv.POSITION_DATE = dt.POSITION_DATE
AND us.[BBGUniqueId/FOID] = pv.[UNIQUE_BLOOMBERG_ID]
LEFT JOIN [Core].[Countries] cc ON cc.ISOCode = pv.ISSUE_COUNTRY_ISO
WHERE EventType = 'Revaluation' 
AND RevaluationPrice IS NOT NULL
