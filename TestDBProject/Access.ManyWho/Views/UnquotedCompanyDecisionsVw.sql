CREATE VIEW [Access.ManyWho].[UnquotedCompanyDecisionsVw]
	AS

SELECT [UnquotedCompanyDecisionId]
      ,[UnquotedCompanyStage]
      ,[InvestmentDecisionType]
      ,[UnquotedCompanyId]
      ,[DecisionByPersonId]
	  ,[p].[EmployeeBK] AS [DecisionBySalesforceUserId]
      ,[DecisionByRoleId]
	  ,[JoinGUID]
      ,[DecisionCreatedDate]
	  ,[DecisionLastModifiedDate]
      ,[DeferDecisionDate]
  FROM [Organisation].[UnquotedCompanyDecisions] uc
  INNER JOIN [Core].[Persons] p ON uc.[DecisionByPersonId] = p.PersonId
