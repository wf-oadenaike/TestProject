


CREATE VIEW [Access.ManyWho].[NewOrgStructureChangesRegisterVw]
		AS 
	SELECT
		CR.ChangeID,
		CR.RequestID,
		CR.SubmittedByPersonID,
		PAV.PersonsName as SubmittedByPersonName,
		CR.CurrentValue,
		CR.ProposedValue,
		CR.ChangeTypeID,
		SCT.ChangeTypeName,
		CR.IsActive,
		CR.JoinGUID,
		CR.CADIS_SYSTEM_INSERTED,
        CR.CADIS_SYSTEM_UPDATED,
        CR.CADIS_SYSTEM_CHANGEDBY
	FROM [dbo].[NewOrgStructureChangesRegister]  CR

	INNER JOIN [Core].[Persons] PAV
	ON  CR.SubmittedByPersonID = PAV.PersonId

	INNER JOIN [dbo].[NewOrgStructureChangeType] SCT
	ON CR.ChangeTypeID = SCT.ChangeTypeID



