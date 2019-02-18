CREATE VIEW [Access.ManyWho].[EBIExternalBodiesVw]
AS
SELECT [EBIExternalBodyId]
     , [EBIExternalBodyDescription]
FROM [Compliance].[EBIExternalBodies];
