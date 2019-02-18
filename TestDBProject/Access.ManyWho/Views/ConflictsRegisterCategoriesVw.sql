/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [Access.ManyWho].[ConflictsRegisterCategoriesVw]
AS
SELECT [ConflictsRegisterCategoryId]
      ,[ConflictsRegisterCategory]
      ,[ConflictsRegisterCategoryDescription]
      ,[CreationDate]
  FROM [Compliance].[ConflictsRegisterCategories]
