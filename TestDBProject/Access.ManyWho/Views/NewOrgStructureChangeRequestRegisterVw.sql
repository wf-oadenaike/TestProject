


CREATE VIEW [Access.ManyWho].[NewOrgStructureChangeRequestRegisterVw]
		AS 
	SELECT
		SCS.RequestID,
		SCS.SubmittedByPersonID,
		CP.PersonsName as SubmittedByName,
		SCS.StatusID,
		FS.FlowStatusName as StatusName,
		SCS.EntityID,
		SCS.EntityName,
		SCS.Reason,
		SCS.ChangeTypeID,
		CT.ChangeTypeName as ChangeType,
		SCS.JiraIssueKey,
		SCS.IsActive,
		SCS.JoinGUID,
		SCS.CADIS_SYSTEM_INSERTED,
        SCS.CADIS_SYSTEM_UPDATED,
        SCS.CADIS_SYSTEM_CHANGEDBY
	FROM [dbo].[NewOrgStructureChangeRequestRegister]  SCS

	INNER JOIN [Core].[Persons] CP
	ON SCS.SubmittedByPersonID = CP.PersonId

	INNER JOIN [dbo].[NewOrgStructureChangeType] CT
	ON SCS.ChangeTypeID = CT.ChangeTypeId

	INNER JOIN [Core].[FlowStatus] FS 
ON SCS.StatusID = FS.FlowStatusId


