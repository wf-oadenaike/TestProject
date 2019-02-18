CREATE VIEW [Access.ManyWho].[ResearchBrokerBudgetChangesVw]
	AS 
SELECT
	  rbbc.BudgetChangeId
	, rbbc.ResearchBrokerId
	, rbbc.PerformanceChange
	, rbbc.ResourceChange
	, rbbc.SectorChange
	, rbbc.BudgetChangeComments
	, rbbc.ChangeAmount
    , rbbc.BudgetAmendmentDate
	, rbbc.AmendedByPersonId
	, rbbc.DocumentationFolderLink
	, rbbc.JoinGUID
	, rbbc.BudgetChangeCreationDatetime
	, rbbc.BudgetChangeLastModifiedDatetime
  FROM [Investment].[ResearchBrokerBudgetChanges] rbbc
