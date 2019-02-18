
CREATE VIEW [Access.ManyWho].[ConflictsRegisterClients]
AS
SELECT CRC.[ConflictsRegisterClientId]
      ,CRC.[ConflictId]
      ,CRC.[ClientSalesforceId]
      ,CRC.[ClientName]
      ,CRC.[CreatedByPersonId]
	  ,p1.[PersonsName] as 'CreatedByPersonName'
      ,CRC.[CreationDate]
	  ,CRC.[IsActive]
  FROM [Compliance].[ConflictsRegisterClients] CRC
  INNER JOIN [Core].[Persons] p1
	ON CRC.CreatedByPersonId = p1.PersonId
