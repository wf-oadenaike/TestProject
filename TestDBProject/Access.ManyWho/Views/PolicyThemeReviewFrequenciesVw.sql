
CREATE VIEW [Access.ManyWho].[PolicyThemeReviewFrequenciesVw]
	AS 
    SELECT  [PolicyThemeReviewFrequencyId]
          , [ReviewFrequencyName]
          , [ReviewWithin]
          , [ValidityPeriod]
          , [Frequency]
  FROM [Organisation].[PolicyThemeReviewFrequencies]
;
