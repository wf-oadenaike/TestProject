CREATE VIEW [Access.ManyWho].[EBIRegisterEventsVw]
	AS
	SELECT 	  ebire.EBIRegisterId
			, ebire.EBIRegisterEventId
            , ebire.EBIEventTypeId
			, ebiret.EBIEventTypeBK
			, ebire.EventDetails
			, ebire.EventDate
			, ebire.EventTrueFalse
			, ebire.RecordedByPersonId
		    , rp.PersonsName as ReportedBy
			, rp.EmployeeBK as ReportedSalesforceUserId
			, ebire.DocumentationFolderLink
            , ebire.WorkflowVersionGUID
            , ebire.JoinGUID
			, ebire.EBIEventCreationDatetime
			, ebire.EBIEventLastModifiedDatetime
	FROM [Compliance].[EBIRegisterEvents] ebire
		INNER JOIN [Compliance].[EBIRegisterEventTypes] ebiret
		ON ebire.EBIEventTypeId = ebiret.EBIEventTypeId
		INNER JOIN Core.Persons rp
		ON (ebire.RecordedByPersonId = rp.PersonId)
	;
