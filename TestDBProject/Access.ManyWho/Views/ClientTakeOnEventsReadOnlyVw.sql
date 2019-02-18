CREATE VIEW [Access.ManyWho].[ClientTakeOnEventsReadOnlyVw]
	AS 
SELECT
		cte.ClientTakeOnEventId
      , cte.ClientTakeOnId
	  , ctr.ClientTakeOnName
	  , cte.RFPId
      , cte.EventTypeId
	  , ctet.ClientTakeOnEventType
	  , cte.SubmittedByPersonId
	  , sp.PersonsName as SubmittedBy
	  , cte.SubmittedDate
      , cte.EventDetails
      , cte.EventDate
      , cte.ReviewComments
      , cte.EventTrueFalse
	  , cte.DepartmentId
	  , d.DepartmentName
	  , cte.JiraSubTaskKey
	  , cte.JiraEpicKey
      , cte.DocumentationFolderLink
      , cte.JoinGUID
      , cte.ClientTakeOnEventCreationDate
      , cte.ClientTakeOnEventLastModifiedDatetime
  FROM [Sales].[ClientTakeOnEvents] cte
  INNER JOIN [Sales].[ClientTakeOnEventTypes] ctet
  ON cte.EventTypeId = ctet.ClientTakeOnEventTypeId
  INNER JOIN [Sales].[ClientTakeOnRegister] ctr
  ON ctr.ClientTakeOnId = cte.ClientTakeOnId 
  LEFT OUTER JOIN [Core].[Persons] sp
  ON cte.SubmittedByPersonId = sp.PersonId
  LEFT OUTER JOIN [Core].[Departments] d
  ON cte.DepartmentId = d.DepartmentId
  ;
