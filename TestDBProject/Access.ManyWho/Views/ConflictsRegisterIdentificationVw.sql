/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [Access.ManyWho].[ConflictsRegisterIdentificationVw]
AS
SELECT [ConflictId]
      ,[ConflictsRegisterGenericId]
      ,COALESCE(ConflictIdentifierOverride, ConflictIdentifier) AS [ConflictIdentifier]
	  ,[ConflictsRegisterCategoryId1]
	  ,[ConflictsRegisterCategoryId2]
      ,[DocumentationFolderUrl]
      ,[CreatedByPersionId]
      ,[CreationDate]
  FROM [Compliance].[ConflictsRegisterIdentification]
