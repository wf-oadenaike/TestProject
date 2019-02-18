CREATE VIEW [Access.ManyWho].[ICAAPRegisterVw]
	AS 
SELECT
       ICAAPRegisterId
	 , SubmittedByPersonId
	 , FinancialYear
	 , ICAAPSubmittedDate
     , RiskBasedICAAPAmount
	 , ICAAPAmount
	 , DocumentationFolderLink
	 , JoinGUID
	 , ICAAPRegisterCreationDatetime
	 , ICAAPRegisterLastModifiedDatetime
  FROM [Investment].[ICAAPRegister]
