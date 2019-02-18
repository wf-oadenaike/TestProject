CREATE VIEW [Access.ManyWho].[ResearchBrokerBudgetChangesReadOnlyVw]
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
	, rp.PersonsName as AmendedBy
	, rbbc.DocumentationFolderLink
	, rbbc.JoinGUID
	, rbbc.BudgetChangeCreationDatetime
	, rbbc.BudgetChangeLastModifiedDatetime
  FROM [Investment].[ResearchBrokerBudgetChanges] rbbc
  INNER JOIN [Core].[Persons] rp
  ON rbbc.AmendedByPersonId = rp.PersonId
