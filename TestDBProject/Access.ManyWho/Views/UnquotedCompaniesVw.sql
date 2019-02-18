﻿CREATE VIEW [Access.ManyWho].[UnquotedCompaniesVw]
	AS
SELECT [UnquotedCompanyId]
      ,[UnquotedCompanyName]
      ,[UnquotedCompanySalesforceId]
      ,[PrimaryContactSalesforceId]
	  ,[InvestmentAnalystPersonId]
      ,[InvestmentManagerOwnerPersonId]
      ,[InvestmentManagerOwnerRoleId]
	  ,[CurrentUnquotedCompanyStage]
      ,[InitialMeetingDate]
      ,[Attendees]
	  ,[NextReviewDate]
      ,[CompanyOverview]
      ,[NotesForSalesTeam]
      ,[CurrentPrice]
      ,[CurrencyCode]
      ,[UnquotedCompanyRootFolderURL]
      ,[InitialInformationFolderURL]
      ,[InitialDueDiligenceFolderURL]
      ,[FinalInvestmentFolderURL]
      ,[InitialInvestmentRulesAssessment]
	  ,[JiraEpicKey]
	  ,[JiraIssueKey]
	  ,[IsFCARegulated]
	  ,[IsSRARegulated]
      ,[WorkflowVersionGUID]
      ,[JoinGUID]
      ,[UnquotedCompaniesCreationDate]
      ,[UnquotedCompaniesLastModifiedDate]
  FROM [Organisation].[UnquotedCompanies] uc