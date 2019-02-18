CREATE VIEW [Access.ManyWho].[UnquotedPipelineReadOnlyVw]
	AS
WITH Decisions_CTE AS (
	SELECT 
      [UnquotedCompanyStage]
      ,[UnquotedCompanyId]
      ,MAX([DecisionCreatedDate]) AS LatestDate
  FROM [Organisation].[UnquotedCompanyDecisions]
  GROUP BY UnquotedCompanyId, UnquotedCompanyStage
),
Commentaries_CTE AS (
	SELECT 
      [UnquotedCompanyStage]
      ,[UnquotedCompanyId]
      ,MAX([CommentaryCreatedDate]) AS LatestDate
  FROM [Organisation].[UnquotedCompanyCommentaries]
  GROUP BY UnquotedCompanyId, UnquotedCompanyStage
)

SELECT uc.[UnquotedCompanyId]
      ,uc.[UnquotedCompanyName]
      ,uc.[UnquotedCompanySalesforceId]
      ,uc.[PrimaryContactSalesforceId]
	  ,uc.[InvestmentAnalystPersonId]
	  ,p2.PersonsName AS [InvestmentAnalystName]
	  ,p2.EmployeeBK AS [InvestmentAnalystSalesforceUserId]	  
      ,uc.[InvestmentManagerOwnerPersonId]
	  ,p1.PersonsName [InvestmentManagerOwnerName]
	  ,p1.EmployeeBK AS [InvestmentManagerOwnerSalesforceUserId]
      ,uc.[InvestmentManagerOwnerRoleId]
	  ,uc.[CurrentUnquotedCompanyStage]
	  ,ucs.[UnquotedCompanyStageDescription] AS [CurrentUnquotedCompanyStageDescription]
      ,uc.[InitialMeetingDate]
      ,uc.[Attendees]
	  ,uc.[NextReviewDate]
      ,uc.[CompanyOverview]
      ,uc.[NotesForSalesTeam]
      ,uc.[CurrentPrice]
      ,uc.[CurrencyCode]
      ,uc.[UnquotedCompanyRootFolderURL]
	  ,CASE WHEN CHARINDEX('/',uc.[UnquotedCompanyRootFolderURL]) > 0 THEN 
	        SUBSTRING(RIGHT(uc.[UnquotedCompanyRootFolderURL], CHARINDEX('/', REVERSE(uc.[UnquotedCompanyRootFolderURL]))),2,100)
            ELSE uc.[UnquotedCompanyRootFolderURL] END as [UnquotedCompanyRootFolderId]
      ,uc.[InitialInformationFolderURL]
      ,uc.[InitialDueDiligenceFolderURL]
      ,uc.[FinalInvestmentFolderURL]
      ,uc.[InitialInvestmentRulesAssessment]
	  ,uc.[JiraEpicKey]
	  ,uc.[JiraIssueKey]
      ,uc.[WorkflowVersionGUID]
      ,uc.[JoinGUID]
      ,uc.[UnquotedCompaniesCreationDate]
      ,uc.[UnquotedCompaniesLastModifiedDate]

	  ,imc.[Commentary] AS [IMCommentary]
	  ,imc.[CommentaryBy] AS [IMCommentaryBy]
	  ,imc.[CommentaryDate] AS [IMCommentaryDate]

	  ,imd.[InvestmentDecision] AS [IMDecision]
	  ,imd.[DeferDecisionDate] AS [IMDeferDecisionDate]
	  ,imd.[DecisionBy] AS [IMDecisionBy]
	  ,imd.[DecisionDate] AS [IMDecisionDate]

	  ,iddc.[Commentary] AS [IDDCommentary]
	  ,iddc.[CommentaryBy] AS [IDDCommentaryBy]
	  ,iddc.[CommentaryDate] AS [IDDCommentaryDate]

	  ,iddd.[InvestmentDecision] AS [IDDDecision]
	  ,iddd.[DeferDecisionDate] AS [IDDDeferDecisionDate]
	  ,iddd.[DecisionBy] AS [IDDDecisionBy]
	  ,iddd.[DecisionDate] AS [IDDDecisionDate]

	  ,tsc.[Commentary] AS [TSCommentary]
	  ,tsc.[CommentaryBy] AS [TSCommentaryBy]
	  ,tsc.[CommentaryDate] AS [TSCommentaryDate]

	  ,tsd.[InvestmentDecision] AS [TSDecision]
	  ,tsd.[DeferDecisionDate] AS [TSDeferDecisionDate]
	  ,tsd.[DecisionBy] AS [TSDecisionBy]
	  ,tsd.[DecisionDate] AS [TSDecisionDate]

	  ,dddc.[Commentary] AS [DDDCommentary]
	  ,dddc.[CommentaryBy] AS [DDDCommentaryBy]
	  ,dddc.[CommentaryDate] AS [DDDCommentaryDate]

	  ,dddd.[InvestmentDecision] AS [DDDDecision]
	  ,dddd.[DeferDecisionDate] AS [DDDDeferDecisionDate]
	  ,dddd.[DecisionBy] AS [DDDDecisionBy]
	  ,dddd.[DecisionDate] AS [DDDDecisionDate]

	  ,uccc.[ComplianceChecksComplete]
	  ,uccc.[InvestmentTrustBoardReporting]
	  ,uccc.[InitialInvestmentDate]

	  ,cc.[Commentary] AS [CCommentary]
	  ,cc.[CommentaryBy] AS [CCommentaryBy]
	  ,cc.[CommentaryDate] AS [CCommentaryDate]

	  ,cd.[DecisionBy] AS [CDecisionBy]
	  ,cd.[DecisionDate] AS [CDecisionDate]
  FROM [Organisation].[UnquotedCompanies] uc
  INNER JOIN [Core].[Persons] p1 ON uc.InvestmentManagerOwnerPersonId = p1.PersonId
  LEFT OUTER JOIN [Core].[Persons] p2 ON uc.InvestmentAnalystPersonId = p2.PersonId
  LEFT JOIN [Organisation].[UnquotedCompanyCompletionChecklist] uccc ON uccc.[UnquotedCompanyId] = uc.[UnquotedCompanyId]
  INNER JOIN [Organisation].[UnquotedCompanyStages] ucs ON ucs.UnquotedCompanyStage = uc.CurrentUnquotedCompanyStage
  LEFT JOIN 
(
SELECT 
	  [p2].[PersonsName] AS [DecisionBy]
      ,ucd1.[DecisionCreatedDate] AS [DecisionDate]
      ,ucd1.[DeferDecisionDate] AS [DeferDecisionDate]
	  ,ucd1.[UnquotedCompanyId]  AS [UnquotedCompanyId]
	  ,idt1.[InvestmentDecision] AS [InvestmentDecision]
  FROM [Organisation].[UnquotedCompanyDecisions] ucd1 INNER JOIN [Core].[Persons] p2 ON p2.PersonId = ucd1.DecisionByPersonId
  INNER JOIN Decisions_CTE im ON im.[UnquotedCompanyId] = ucd1.[UnquotedCompanyId] 
  AND im.[UnquotedCompanyStage] = 'IM' AND ucd1.[DecisionCreatedDate] = im.LatestDate AND ucd1.UnquotedCompanyStage = 'IM'
  INNER JOIN [organisation].[InvestmentDecisionTypes] idt1 ON idt1.InvestmentDecisionType = ucd1.InvestmentDecisionType
) imd ON imd.[UnquotedCompanyId] = uc.[UnquotedCompanyId]

  LEFT JOIN 
(
SELECT 
	  [p2].[PersonsName] AS [DecisionBy]
      ,ucd1.[DecisionCreatedDate] AS [DecisionDate]
      ,ucd1.[DeferDecisionDate] AS [DeferDecisionDate]
	  ,ucd1.[UnquotedCompanyId]  AS [UnquotedCompanyId]
	  ,idt1.[InvestmentDecision] AS [InvestmentDecision]
  FROM [Organisation].[UnquotedCompanyDecisions] ucd1 INNER JOIN [Core].[Persons] p2 ON p2.PersonId = ucd1.DecisionByPersonId
  INNER JOIN Decisions_CTE idd ON idd.[UnquotedCompanyId] = ucd1.[UnquotedCompanyId] 
  AND idd.[UnquotedCompanyStage] = 'IDD' AND ucd1.[DecisionCreatedDate] = idd.LatestDate AND ucd1.UnquotedCompanyStage = 'IDD'
  INNER JOIN [organisation].[InvestmentDecisionTypes] idt1 ON idt1.InvestmentDecisionType = ucd1.InvestmentDecisionType
) iddd ON iddd.[UnquotedCompanyId] = uc.[UnquotedCompanyId]
  
    LEFT JOIN 
(
SELECT 
	  [p2].[PersonsName] AS [DecisionBy]
      ,ucd1.[DecisionCreatedDate] AS [DecisionDate]
      ,ucd1.[DeferDecisionDate] AS [DeferDecisionDate]
	  ,ucd1.[UnquotedCompanyId]  AS [UnquotedCompanyId]
	  ,idt1.[InvestmentDecision] AS [InvestmentDecision]
  FROM [Organisation].[UnquotedCompanyDecisions] ucd1 INNER JOIN [Core].[Persons] p2 ON p2.PersonId = ucd1.DecisionByPersonId
  INNER JOIN Decisions_CTE ts ON ts.[UnquotedCompanyId] = ucd1.[UnquotedCompanyId] 
  AND ts.[UnquotedCompanyStage] = 'TS' AND ucd1.[DecisionCreatedDate] = ts.LatestDate AND ucd1.UnquotedCompanyStage = 'TS'
  INNER JOIN [organisation].[InvestmentDecisionTypes] idt1 ON idt1.InvestmentDecisionType = ucd1.InvestmentDecisionType
) tsd ON tsd.[UnquotedCompanyId] = uc.[UnquotedCompanyId]

    LEFT JOIN 
(
SELECT 
	  [p2].[PersonsName] AS [DecisionBy]
      ,ucd1.[DecisionCreatedDate] AS [DecisionDate]
      ,ucd1.[DeferDecisionDate] AS [DeferDecisionDate]
	  ,ucd1.[UnquotedCompanyId]  AS [UnquotedCompanyId]
	  ,idt1.[InvestmentDecision] AS [InvestmentDecision]
  FROM [Organisation].[UnquotedCompanyDecisions] ucd1 INNER JOIN [Core].[Persons] p2 ON p2.PersonId = ucd1.DecisionByPersonId
  INNER JOIN Decisions_CTE ddd ON ddd.[UnquotedCompanyId] = ucd1.[UnquotedCompanyId] 
  AND ddd.[UnquotedCompanyStage] = 'DDD' AND ucd1.[DecisionCreatedDate] = ddd.LatestDate AND ucd1.UnquotedCompanyStage = 'DDD'
  INNER JOIN [organisation].[InvestmentDecisionTypes] idt1 ON idt1.InvestmentDecisionType = ucd1.InvestmentDecisionType
) dddd ON dddd.[UnquotedCompanyId] = uc.[UnquotedCompanyId]

    LEFT JOIN 
(
SELECT 
	  [p2].[PersonsName] AS [DecisionBy]
      ,ucd1.[DecisionCreatedDate] AS [DecisionDate]
      ,ucd1.[DeferDecisionDate] AS [DeferDecisionDate]
	  ,ucd1.[UnquotedCompanyId]  AS [UnquotedCompanyId]
	  ,idt1.[InvestmentDecision] AS [InvestmentDecision]
  FROM [Organisation].[UnquotedCompanyDecisions] ucd1 INNER JOIN [Core].[Persons] p2 ON p2.PersonId = ucd1.DecisionByPersonId
  INNER JOIN Decisions_CTE c ON c.[UnquotedCompanyId] = ucd1.[UnquotedCompanyId] 
  AND c.[UnquotedCompanyStage] = 'C' AND ucd1.[DecisionCreatedDate] = c.LatestDate AND ucd1.UnquotedCompanyStage = 'C'
  INNER JOIN [organisation].[InvestmentDecisionTypes] idt1 ON idt1.InvestmentDecisionType = ucd1.InvestmentDecisionType
) cd ON cd.[UnquotedCompanyId] = uc.[UnquotedCompanyId]


LEFT JOIN 
(
SELECT 
	  [p2].[PersonsName] AS [CommentaryBy]
      ,ucd1.[Commentary] AS [Commentary]
      ,ucd1.[CommentaryCreatedDate] AS [CommentaryDate]
	  ,ucd1.[UnquotedCompanyId]
  FROM [Organisation].[UnquotedCompanyCommentaries] ucd1 INNER JOIN [Core].[Persons] p2 ON p2.PersonId = ucd1.CommentaryByPersonId
  INNER JOIN Commentaries_CTE im ON im.[UnquotedCompanyId] = ucd1.[UnquotedCompanyId] 
  AND im.[UnquotedCompanyStage] = 'IM' AND ucd1.[CommentaryCreatedDate] = im.LatestDate AND ucd1.UnquotedCompanyStage = 'IM'
) imc ON imc.[UnquotedCompanyId] = uc.[UnquotedCompanyId]

LEFT JOIN 
(
SELECT 
	  [p2].[PersonsName] AS [CommentaryBy]
      ,ucd1.[Commentary] AS [Commentary]
      ,ucd1.[CommentaryCreatedDate] AS [CommentaryDate]
	  ,ucd1.[UnquotedCompanyId]
  FROM [Organisation].[UnquotedCompanyCommentaries] ucd1 INNER JOIN [Core].[Persons] p2 ON p2.PersonId = ucd1.CommentaryByPersonId
  INNER JOIN Commentaries_CTE im ON im.[UnquotedCompanyId] = ucd1.[UnquotedCompanyId] 
  AND im.[UnquotedCompanyStage] = 'IDD' AND ucd1.[CommentaryCreatedDate] = im.LatestDate AND ucd1.UnquotedCompanyStage = 'IDD'
) iddc ON iddc.[UnquotedCompanyId] = uc.[UnquotedCompanyId]

LEFT JOIN 
(
SELECT 
	  [p2].[PersonsName] AS [CommentaryBy]
      ,ucd1.[Commentary] AS [Commentary]
      ,ucd1.[CommentaryCreatedDate] AS [CommentaryDate]
	  ,ucd1.[UnquotedCompanyId]
  FROM [Organisation].[UnquotedCompanyCommentaries] ucd1 INNER JOIN [Core].[Persons] p2 ON p2.PersonId = ucd1.CommentaryByPersonId
  INNER JOIN Commentaries_CTE im ON im.[UnquotedCompanyId] = ucd1.[UnquotedCompanyId] 
  AND im.[UnquotedCompanyStage] = 'TS' AND ucd1.[CommentaryCreatedDate] = im.LatestDate AND ucd1.UnquotedCompanyStage = 'TS'
) tsc ON tsc.[UnquotedCompanyId] = uc.[UnquotedCompanyId]

LEFT JOIN 
(
SELECT 
	  [p2].[PersonsName] AS [CommentaryBy]
      ,ucd1.[Commentary] AS [Commentary]
      ,ucd1.[CommentaryCreatedDate] AS [CommentaryDate]
	  ,ucd1.[UnquotedCompanyId]
  FROM [Organisation].[UnquotedCompanyCommentaries] ucd1 INNER JOIN [Core].[Persons] p2 ON p2.PersonId = ucd1.CommentaryByPersonId
  INNER JOIN Commentaries_CTE im ON im.[UnquotedCompanyId] = ucd1.[UnquotedCompanyId] 
  AND im.[UnquotedCompanyStage] = 'DDD' AND ucd1.[CommentaryCreatedDate] = im.LatestDate AND ucd1.UnquotedCompanyStage = 'DDD'
) dddc ON dddc.[UnquotedCompanyId] = uc.[UnquotedCompanyId]

LEFT JOIN 
(
SELECT 
	  [p2].[PersonsName] AS [CommentaryBy]
      ,ucd1.[Commentary] AS [Commentary]
      ,ucd1.[CommentaryCreatedDate] AS [CommentaryDate]
	  ,ucd1.[UnquotedCompanyId]
  FROM [Organisation].[UnquotedCompanyCommentaries] ucd1 INNER JOIN [Core].[Persons] p2 ON p2.PersonId = ucd1.CommentaryByPersonId
  INNER JOIN Commentaries_CTE im ON im.[UnquotedCompanyId] = ucd1.[UnquotedCompanyId] 
  AND im.[UnquotedCompanyStage] = 'C' AND ucd1.[CommentaryCreatedDate] = im.LatestDate AND ucd1.UnquotedCompanyStage = 'C'
) cc ON cc.[UnquotedCompanyId] = uc.[UnquotedCompanyId]
