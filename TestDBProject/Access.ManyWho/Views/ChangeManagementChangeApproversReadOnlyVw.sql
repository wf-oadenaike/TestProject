
CREATE VIEW [Access.ManyWho].[ChangeManagementChangeApproversReadOnlyVw]
AS
SELECT	[ApproverID]
		,y.PersonsName as 'ApproverName'
		,[ServiceID]
		,[ApprovalTypeID]
		,[ApproverPersonID]
		,[JoinGUID]
		,[ChangeManagementRegisterCreationDatetime]
		,[ChangeManagementRegisterLastModifiedDatetime]
		,[CADIS_SYSTEM_INSERTED]
		,[CADIS_SYSTEM_UPDATED]
		,[CADIS_SYSTEM_CHANGEDBY]
		,[CADIS_SYSTEM_PRIORITY]
		,[CADIS_SYSTEM_TIMESTAMP]
		,[CADIS_SYSTEM_LASTMODIFIED]
FROM	[ChangeManagement].[ChangeApprovers] x
INNER	JOIN [Access.ManyWho].[PersonsActiveVw] y
		ON x.ApproverPersonID = y.PersonId
