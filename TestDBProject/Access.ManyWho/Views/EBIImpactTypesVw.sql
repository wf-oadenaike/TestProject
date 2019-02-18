CREATE VIEW [Access.ManyWho].[EBIImpactTypesVw]
AS
SELECT
      [EBIImpactTypeId]
    , [EBIImpactName]
FROM [Compliance].[EBIImpactTypes];
