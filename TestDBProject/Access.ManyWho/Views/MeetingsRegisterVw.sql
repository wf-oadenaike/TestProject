
CREATE VIEW  [Access.ManyWho].[MeetingsRegisterVw]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Access.ManyWho].[MeetingsRegisterVw]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- B.Katsadoros: 15/05/2017 JIRA: PRP-7160 Added mr.MeetingDay
-------------------------------------------------------------------------------------- 
	SELECT mr.MeetingRegisterId, mr.MeetingTypeId, mt.MeetingTypeBK, mr.MeetingNameBK, mr.MeetingSummary
		, mr.MeetingOwnerRoleId, mor.RoleName as MeetingOwnerRoleName
		, mr.AssigneeRoleId, ar.RoleName as AssigneeRoleName
		, mr.JIRAProjectKey
		, mr.ActiveFlag
		, mr.MeetingDay
		, mr.DocumentationFolderLink, mr.WorkflowVersionGUID, mr.JoinGUID
		, mr.MeetingRegisterCreationDatetime, mr.MeetingRegisterLastModifiedDatetime
	FROM Organisation.MeetingsRegister mr
		INNER JOIN Organisation.MeetingTypes mt
			ON (mr.MeetingTypeId = mt.MeetingTypeId)
		INNER JOIN Core.Roles mor
			ON mr.MeetingOwnerRoleId = mor.RoleId
			AND mor.ActiveFlag = 1
		INNER JOIN Core.Roles ar
			ON mr.AssigneeRoleId = ar.RoleId
			AND ar.ActiveFlag = 1
	;

