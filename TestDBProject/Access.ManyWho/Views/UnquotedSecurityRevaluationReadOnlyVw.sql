CREATE VIEW [Access.ManyWho].[UnquotedSecurityRevaluationReadOnlyVw]
AS
SELECT 
		usr.[SecurityRevaluationId]
	  , usr.[SecurityBloombergId]
      , ms.[SECURITY_NAME] as SecurityName 
      , usr.[EventType]
	  , usr.[EventOverview]
	  , usr.[EventDate]
      , usr.[FurtherFundingAmount]
	  , usr.[Notes]
      , usr.[PresentedToPricingCommittee]
	  , usr.[RevaluationPreviousPrice]
      , usr.[RevaluationPrice]
	  , usr.[RevaluationEndDate]
	  , usr.[IsActive]
	  , usr.[Status]
	  , usr.[JiraIssueKey]
	  , usr.[CurrencyCode]
	  , usr.[IsComplete]
      , usr.[SubmittedByPersonId]
	  , sp.PersonsName as SubmittedBy
      , usr.[DocumentationFolderLink]
      , usr.[JoinGUID]
      , usr.[SecurityRevaluationCreationDate]
      , usr.[SecurityRevaluationLastModifiedDate]
  FROM [Unquoted].[SecurityRevaluation] usr
  INNER JOIN [dbo].[T_MASTER_SEC] ms
  ON usr.SecurityBloombergId = ms.UNIQUE_BLOOMBERG_ID
  INNER JOIN [Core].[Persons] sp
  ON usr.SubmittedByPersonId = sp.PersonId

  
  ;
