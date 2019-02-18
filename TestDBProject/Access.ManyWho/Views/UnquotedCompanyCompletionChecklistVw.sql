CREATE VIEW [Access.ManyWho].[UnquotedCompanyCompletionChecklistVw]
	AS
SELECT [UnquotedCompanyId]
      ,[ComplianceChecksComplete]
      ,[InvestmentTrustBoardReporting]
      ,[InitialInvestmentDate]
  FROM [Organisation].[UnquotedCompanyCompletionChecklist]
