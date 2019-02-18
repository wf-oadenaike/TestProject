




CREATE VIEW [Investment].[V_UnquotedCompanyReferrals] AS
	SELECT
		UCR.ID AS ID
		,Name
		,UCRS.ID AS StatusID
		,UCRS.[Status] AS [Status]
		,ICB.Industry AS Industry
		,ICB.Supersector AS Supersector
		,ICB.Sector AS Sector
		,ICB.Subsector AS Subsector
		,ICB.FundManagerPersonID AS FundManagerPersonID
		,ICB.FundManagerName AS FundManagerName
		,ICB.InvestmentAnalystPersonID AS InvestmentAnalystPersonID
		,ICB.InvestmentAnalystName AS InvestmentAnalystName
		,[Description]
		,InternalNotes
		,SFAccountID
		,ReferrerSFContactID
		,BoxFolderID
		,SubmittedBy
	FROM [Investment].[T_UnquotedCompanyReferrals] UCR
		LEFT JOIN [Investment].[V_REF_IndustryClassificationBenchmark] ICB ON UCR.SubsectorID = ICB.SubsectorID
		LEFT JOIN [Investment].[T_REF_UnquotedCompanyReferralStatus] UCRS ON UCR.StatusID = UCRS.ID





