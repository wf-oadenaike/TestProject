


CREATE VIEW [Access.ManyWho].[NewOrgStructureChangeRequestEventsVw]
	AS 
SELECT
	CRE.EventId,
	CRE.RequestId,
	CRE.EventTypeID,
	ET.EventType,
	CRE.SubmittedByPersonId,
	CP1.PersonsName SubmittedByPersonName,
	CRE.EventDate,
	CRE.EventDetails,
	CRE.IsActive,
	CRE.Jiraissuekey,
	CRE.JoinGUID,
	CRE.CADIS_SYSTEM_INSERTED,
    CRE.CADIS_SYSTEM_UPDATED,
    CRE.CADIS_SYSTEM_CHANGEDBY
FROM [dbo].[NewOrgStructureChangeRequestEvents]  CRE

INNER JOIN [Core].[Persons] CP1 
ON CRE.SubmittedByPersonId = CP1.PersonId

INNER JOIN [dbo].[NewOrgStructureChangeRequestEventTypes] ET
ON CRE.EventTypeID = ET.EventTypeID



