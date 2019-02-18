

CREATE VIEW [Access.ManyWho].[ComplaintsRegisterEventsVw]
AS
SELECT cra.ComplaintsRegisterEventId
	 , cra.ComplaintRegisterId
	 , cra.ComplaintEventTypeId
	 , crat.ComplaintEventType
	 , cra.EventDate
	 , cra.EventDetails
	 , cra.RecordedByPersonId
	 , cra.EventTrueFalse
	 , cra.DocumentationFolderLink
	 , cra.JoinGUID
	 , cra.ComplaintEventCreationDate
	 , cra.ComplaintEventLastModifiedDate
  FROM [Compliance].[ComplaintsRegisterEvents] cra
  LEFT JOIN [Compliance].[ComplaintEventTypes] crat
  ON cra.[ComplaintEventTypeId] = crat.[ComplaintEventTypeId]
