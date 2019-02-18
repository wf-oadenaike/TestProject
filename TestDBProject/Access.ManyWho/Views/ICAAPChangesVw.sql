CREATE VIEW [Access.ManyWho].[ICAAPChangesVw]
	AS 
SELECT
	  ic.ICAAPChangeId
	, ic.ICAAPRegisterId
	, ic.ChangeAmount
	, ic.PercentageChange
	, ic.ICAAPChangeDueTo
	, ic.ICAAPAmendmentDate
	, ic.ICAAPChangeStatus
	, ic.AmendedByPersonId
	, ic.DocumentationFolderLink
	, ic.JoinGUID
	, ic.ICAAPChangeCreationDatetime
	, ic.ICAAPChangeLastModifiedDatetime
  FROM [Investment].[ICAAPChanges] ic
