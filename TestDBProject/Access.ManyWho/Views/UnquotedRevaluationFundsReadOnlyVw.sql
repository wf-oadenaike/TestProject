CREATE VIEW [Access.ManyWho].[UnquotedRevaluationFundsReadOnlyVw]
AS
SELECT DISTINCT
		ucr.[UnquotedCompanyRevaluationId]
	  , ucr.[UnquotedCompanyId]
	  , uc.[UnquotedCompanyName]
      , ucr.[EventType]
	  , ucr.[EventOverview]
	  , ucr.[EventDate]
      , ucr.[FurtherFundingAmount]
	  , ucr.[Notes]
      , ucr.[BoxUrl]
      , ucr.[PresentedToPricingCommitee]
	  , ucr.[RevaluationPreviousPrice]
      , ucr.[RevaluationPrice]
	  , ucr.[RevaluationEndDate]
	  , ucr.[IsActive]
	  , ucr.[Status]
	  , ucr.[JiraIssueKey]
	  , ucr.[CurrencyCode]
	  , ucr.[IsComplete]
      , ucr.[WorkflowVersionGUID]
      , ucr.[JoinGUID]
      , ucr.[UnquotedSecuritiesCreationDate]
      , ucr.[UnquotedSecuritiesCreatedByPersonId]
	  , cp.PersonsName as CreatedBy
      , ucr.[UnquotedSecuritiesLastModifiedDate]
      , ucr.[UnquotedSecuritiesLastModifiedByPersonId]
	  , mp.PersonsName as ModifiedBy
	  , us.[UnquotedSecuritiesId]
      , usfi.[FundCode]
  FROM [Organisation].[UnquotedSecuritiesFundInvestments] usfi
  INNER JOIN [Organisation].[UnquotedSecurities] us
  ON usfi.UnquotedSecuritiesId = us.UnquotedSecuritiesId
  INNER JOIN [Organisation].[UnquotedCompanyRevaluation] ucr
  ON ucr.UnquotedCompanyId = us.UnquotedCompanyId
  INNER JOIN [Organisation].[UnquotedCompanies] uc
  ON ucr.UnquotedCompanyId = uc.UnquotedCompanyId
  INNER JOIN [Core].[Persons] cp
  ON ucr.UnquotedSecuritiesCreatedByPersonId = cp.PersonId
  INNER JOIN [Core].[Persons] mp
  ON ucr.UnquotedSecuritiesLastModifiedByPersonId = mp.PersonId 
  WHERE ucr.IsActive = 1
  AND (ucr.ISComplete IS NULL OR ucr.ISComplete = 0)
