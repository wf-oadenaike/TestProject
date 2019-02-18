CREATE VIEW [Access.ManyWho].[UnquotedCompanyDecisionsReadonlyVw]
	AS

SELECT [UnquotedCompanyDecisionId]
      ,[UnquotedCompanyStage]
      ,[InvestmentDecisionType]
      ,[UnquotedCompanyId]
      ,[DecisionByPersonId]
	  , p.[EmployeeBK] AS [DecisionBySalesforceUserId]
	  , p.PersonsName as DecisionBy
      ,[DecisionByRoleId]
	  ,[JoinGUID]
      ,[DecisionCreatedDate]
	  ,[DecisionLastModifiedDate]
      ,[DeferDecisionDate]
  FROM [Organisation].[UnquotedCompanyDecisions] uc
  INNER JOIN [Core].[Persons] p ON uc.[DecisionByPersonId] = p.PersonId
