CREATE VIEW [Access.ManyWho].[ConflictsRegisterGenericsVw]
AS
SELECT [ConflictsRegisterGenericId]
      ,[GenericConflictTitle]
      ,[GenericConflictDetails]
      ,[CreatedByPersonId]
      ,[CreationDate]
  FROM [Compliance].[ConflictsRegisterGenerics]
