
CREATE VIEW [Access.ManyWho].[RegulatoryInteractionRegisterReadOnlyVw]
	AS 
SELECT
	   rir.RegulatoryInteractionId
	 , rir.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
	 , rir.InteractionDate
	 , rir.Status
	 , rir.SummaryDescription
	 , rir.Comments
	 , rir.ContactedBy
	 , rir.ContactTitle
	 , rir.RegulatoryBody
	 , rir.InteractionTitle
	 , rir.BoxFolderId
	 , rir.DocumentationFolderLink
	 , rir.JoinGUID
	 , rir.RegulatoryInteractionRegisterCreationDatetime
	 , rir.RegulatoryInteractionRegisterLastModifiedDatetime
  FROM [Compliance].[RegulatoryInteractionRegister] rir
  INNER JOIN [Core].[Persons] sp
  ON rir.SubmittedByPersonId = sp.PersonId

  ;
