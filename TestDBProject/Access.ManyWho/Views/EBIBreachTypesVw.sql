CREATE VIEW [Access.ManyWho].[EBIBreachTypesVw]
AS
SELECT [EBIBreachTypeId]
     , [EBIBreachName]
  FROM [Compliance].[EBIBreachTypes];
