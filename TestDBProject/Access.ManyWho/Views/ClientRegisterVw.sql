CREATE VIEW [Access.ManyWho].[ClientRegisterVw]
	AS 
SELECT  [ClientId]
      ,[ClientName]
      ,[RelationshipManagerId]
	  ,p.PersonsName AS [RelationshipManagerName]
      ,[AccountSalesforceId]
      ,[PrimaryContactName]
      ,[ContactSalesforceId]
      ,[IsActive]
      ,[RecordedByPersonId]
	  ,p2.PersonsName AS [RecordedByPerson]
	  ,[ReconciliationEmailAddress]
      ,[DocumentationFolderLink]
      ,[JoinGUID]
      ,[ClientRegisterCreationDatetime]
      ,[ClientRegisterLastModifiedDatetime]
      ,[BillingFrequency]
      ,[FrequencyStartMonth]
      ,[BoxFolderID]
  FROM [Sales].[ClientRegister] cr
  INNER JOIN [Core].[Persons] p ON cr.[RelationshipManagerId] = p.PersonId
  INNER JOIN [Core].[Persons] p2 ON cr.[RecordedByPersonId] = p2.PersonId
