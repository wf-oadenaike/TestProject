



CREATE VIEW [Access.ManyWho].[Compliance_KYCEventsReadOnlyVw]
		AS 
	SELECT
		K.EventID,
		K.ChecklistID,
		E.EventType,  
		C.Name as ChecklistName,
		K.EventDate,
		K.SubmittedByPersonID,
		CP.PersonsName as SubmittedBy,
		K.JiraIssueKey,  
		K.JoinGUID,
		K.CADIS_SYSTEM_INSERTED,
        K.CADIS_SYSTEM_UPDATED,
        K.CADIS_SYSTEM_CHANGEDBY
	FROM [dbo].[Compliance_KYCEvents]  K

	INNER JOIN [Core].[Persons] CP
	ON K.SubmittedByPersonID = CP.PersonId

	INNER JOIN [dbo].[Compliance_KYCChecklist] C
	ON K.ChecklistID = C.ChecklistID

	INNER JOIN [dbo].[Compliance_KYCEventTypes] E
	ON K.EventTypeID = E.EventTypeID



