CREATE VIEW [Reporting.Investment].[RevaluationFurtherFundingVw]
	AS 

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
		uc.UnquotedCompanyId
	  ,uc.UnquotedCompanyName AS CompanyName
	  ,'Revaluation' AS [Type]
	  ,ri.[BloombergUniqueId]
      ,[EffectiveDate]
      ,[SecurityName]
      ,ri.[CurrencyCode]
      ,[PreviousPrice]
      ,[UpdatedPrice]
      ,[Source]
	  , NULL AS FurtherFundingAmount
  FROM [Unquoted].[RevaluationInstructions] ri
  LEFT JOIN [Organisation].[UnquotedSecurities] us ON ri.[BloombergUniqueId] = us.[BBGUniqueId/FOID]
  LEFT JOIN [Organisation].[UnquotedCompanies] uc ON uc.UnquotedCompanyId = us.UnquotedCompanyId
  UNION ALL
  SELECT 
	ucr.[UnquotedCompanyId]
	,uc.UnquotedCompanyName 
      ,[EventType]
	  ,NULL
      ,[EventDate]
      , NULL
	  , NULL
	  , NULL
	  , NULL
	  , 'ManyWho Flow'
	  ,(CASE WHEN [FurtherFundingAmount] < 100 THEN [FurtherFundingAmount] * 1000000.00 ELSE [FurtherFundingAmount] END) AS [FurtherFundingAmount] 
  FROM [Organisation].[UnquotedCompanyRevaluation] ucr
  LEFT JOIN [Organisation].[UnquotedCompanies] uc ON uc.UnquotedCompanyId = ucr.UnquotedCompanyId
  WHERE EventType = 'Further Funding' AND [FurtherFundingAmount] IS NOT NULL
