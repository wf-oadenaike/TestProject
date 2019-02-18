CREATE VIEW [Access.ManyWho].[ICAAPRegisterReadOnlyVw]
	AS 
SELECT
       ir.ICAAPRegisterId
	 , ir.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy	 
	 , ir.FinancialYear
	 , ir.ICAAPSubmittedDate
     , ir.RiskBasedICAAPAmount
	 , ir.ICAAPAmount
	 , ir.DocumentationFolderLink
	 , ir.JoinGUID
	 , ir.ICAAPRegisterCreationDatetime
	 , ir.ICAAPRegisterLastModifiedDatetime
  FROM [Investment].[ICAAPRegister] ir
  INNER JOIN [Core].[Persons] sp
  ON ir.SubmittedByPersonId = sp.PersonId
