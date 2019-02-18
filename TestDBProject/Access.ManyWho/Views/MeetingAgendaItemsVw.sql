
CREATE VIEW  [Access.ManyWho].[MeetingAgendaItemsVw]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Access.ManyWho].[MeetingAgendaItemsVw]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- B.Katsadoros: 15/05/2017 JIRA: PRP-7160 Added mai.Purpose, mai.Outcome
-------------------------------------------------------------------------------------- 
SELECT mai.MeetingRegisterId, mr.MeetingNameBK, mai.AgendaItemNameBK, mai.AgendaItemDetails,mai.Purpose,mai.Outcome, mai.IssueType
		, mai.ReporterRoleId, rr.RoleName as ReporterRoleName
		, ISNULL( pr.PersonId, up.PersonId) as ReporterPersonId, ISNULL( pr.PersonsName, up.PersonsName) as ReporterName, ISNULL( pr.EmployeeBK, up.EmployeeBK) as ReporterSalesforceUserId
		, mai.AssigneeRoleId, ar.RoleName as AssigneeRoleName
		, ISNULL( apr.PersonId, aup.PersonId) as AssigneePersonId, ISNULL( apr.PersonsName, aup.PersonsName) as AssigneeName, ISNULL( apr.EmployeeBK, aup.EmployeeBK) as AssigneeSalesforceUserId
		, mai.ActiveFlag,mai.Frequency,mai.LagLead, mai.DocumentationFolderLink, mai.WorkflowVersionGUID, mai.JoinGUID
		, mai.MeetingAgendaItemCreationDatetime, mai.MeetingAgendaItemLastModifiedDatetime
FROM Organisation.MeetingAgendaItems mai
	INNER JOIN Organisation.MeetingsRegister mr
		ON mai.MeetingRegisterId = mr.MeetingRegisterId
	INNER JOIN Core.Roles rr
		ON mai.ReporterRoleId = rr.RoleId
		LEFT OUTER JOIN Core.RolePersonRelationship rpr
			ON rr.RoleId = rpr.RoleId
			AND rpr.ActiveFlag = 1
			LEFT OUTER JOIN Core.Persons pr
				ON rpr.PersonId = pr.PersonId
				AND pr.ActiveFlag = 1
			LEFT OUTER JOIN Core.Persons up
				ON -1 = up.PersonId
				AND up.ActiveFlag = 1
	INNER JOIN Core.Roles ar
		ON mai.AssigneeRoleId = ar.RoleId
		LEFT OUTER JOIN Core.RolePersonRelationship arpr
			ON ar.RoleId = arpr.RoleId
			AND arpr.ActiveFlag = 1
			LEFT OUTER JOIN Core.Persons apr
				ON arpr.PersonId = apr.PersonId
				AND apr.ActiveFlag = 1
			LEFT OUTER JOIN Core.Persons aup
				ON -1 = aup.PersonId
				AND aup.ActiveFlag = 1;

