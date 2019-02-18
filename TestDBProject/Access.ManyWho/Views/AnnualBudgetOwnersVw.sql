
CREATE VIEW [Access.ManyWho].[AnnualBudgetOwnersVw]
	AS 
SELECT
	  ab.DepartmentId
	, d.DepartmentNumber
	, d.DepartmentName
	, ab.BudgetOwnerPersonId
	, bp.PersonsName
	, ab.BoxFolderId
	, ab.BoxProjectFolderId
	, ab.BudgetOwnerCreationDate
  FROM [Organisation].[AnnualBudgetOwners] ab
  INNER JOIN [Core].[Departments] d
  ON d.DepartmentId = ab.DepartmentId
  INNER JOIN [Core].[Persons] bp
  ON ab.BudgetOwnerPersonId = bp.PersonId
  ;
