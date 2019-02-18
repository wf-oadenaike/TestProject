CREATE VIEW [Access.ManyWho].[UnquotedCompanyEventsReadOnlyVw]
	AS
SELECT uce.[CompanyEventId]
     , uce.[CompanyId]
	 , uc.[CompanyName]
	 , uce.[CompanyStage]
	 , cs.CompanyStageDescription
     , uce.[CompanyEventTypeId]
	 , ucet.[CompanyEventType]
	 , uce.[SubmittedByPersonId]
	 , sp.PersonsName
     , uce.[EventDetails]
     , uce.[EventDate]
     , uce.[EventTrueFalse]
     , uce.[DocumentationFolderLink]
     , uce.[JoinGUID]
     , uce.[CompanyEventCreationDatetime]
     , uce.[CompanyEventLastModifiedDatetime]
  FROM [Unquoted].[CompanyEvents] uce
  INNER JOIN [Investment].[Companies] uc
  ON uce.CompanyId = uc.CompanyId
  INNER JOIN [Unquoted].[CompanyEventTypes] ucet
  ON uce.CompanyEventTypeId = ucet.CompanyEventTypeId
  LEFT OUTER JOIN [Core].[Persons] sp
  ON uce.SubmittedByPersonId = sp.PersonId 
  LEFT OUTER JOIN [Unquoted].[CompanyStages] cs
  ON uce.CompanyStage = cs.CompanyStage
  WHERE uc.IsQuotedCompany=0
