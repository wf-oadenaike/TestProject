CREATE VIEW [Access.ManyWho].[AssetRegisterReadOnlyVw]
	AS 
SELECT
    ar.AssetId,
	ar.AssetTypeId,
	at.AssetType,
	at.AssetCode,
--	at.DepreciationType,
	ar.Supplier,
	ar.Reference,
	ar.TransactionNo,
	ar.Description,
	ar.AssetCost,
	ar.PurchaseDate,
	ar.WrittenOffDate,
	ar.Status,
	ar.DepreciationType,
	ar.WritedownPeriod,
	ar.SubmittedByPersonId,
	sp.PersonsName as SubmittedBy,
	ar.DocumentationFolderLink,
	ar.JoinGUID,
	ar.AssetRegisterCreationDatetime,
	ar.AssetRegisterLastModifiedDatetime
  FROM [Organisation].[AssetRegister] ar
  INNER JOIN [Organisation].[AssetTypes] at
  ON ar.AssetTypeId = at.AssetTypeId
  INNER JOIN [Core].[Persons] sp
  ON ar.SubmittedByPersonId = sp.PersonId

  ;
