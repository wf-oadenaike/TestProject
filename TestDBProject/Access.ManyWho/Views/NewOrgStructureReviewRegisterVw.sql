CREATE VIEW [Access.ManyWho].[NewOrgStructureReviewRegisterVw]
		AS 
     SELECT
		CSRR.ReviewID,
		CSRR.RequestID,
		CRR.EntityName,
		CRR.ChangeType,
		CSRR.StatusID,
		SN.FlowStatusName as StatusName,
		CSRR.ReviewTypeID,
		RT.ReviewTypeName,
		CSRR.Details,
		CSRR.SubmittedDate,
		CSRR.ReviewerPersonID,
		PN.PersonsName as ReviewerPersonName,
		CSRR.JiraIssueKey,
		CSRR.IsActive,
		CSRR.JoinGUID,
		CSRR.CADIS_SYSTEM_INSERTED,
        CSRR.CADIS_SYSTEM_UPDATED,
        CSRR.CADIS_SYSTEM_CHANGEDBY
	FROM [dbo].[NewOrgStructureReviewRegister]  CSRR

	INNER JOIN [Core].[Persons] PN
	ON CSRR.ReviewerPersonID = PN.PersonId

	INNER JOIN [Core].[FlowStatus] SN 
	ON CSRR.StatusID = SN.FlowStatusId

		INNER JOIN [dbo].[NewOrgStructureReviewType] RT
	ON CSRR.ReviewTypeID = RT.ReviewTypeID

	INNER JOIN [Access.ManyWho].[NewOrgStructureChangeRequestRegisterVw] CRR
	ON CSRR.RequestID = CRR.RequestID

