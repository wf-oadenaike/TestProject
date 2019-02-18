
CREATE VIEW [Access.ManyWho].[PlacingEventsVw]
	AS SELECT pe.PlacingEventId
		, pe.PlacingRegisterId
		, pe.PlacingEventType
		, pe.EventPersonId
		, p.EmployeeBK as PersonSalesforceUserId
		, p.PersonsName as PersonsName
		, pe.EventDetails
		, pe.EventDate
		, pe.EventTrueFalse
		, pe.JoinGUID
		, pe.PlacingEventCreationDatetime
		, pe.PlacingEventLastModifiedDatetime
	FROM [Operation].[PlacingEvents] pe
			LEFT OUTER JOIN Core.Persons p
				ON pe.EventPersonId = p.PersonId
;
