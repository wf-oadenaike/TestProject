	
CREATE VIEW [Access.ManyWho].[PersonsActiveVw]
	AS 

	WITH SubCategoryRoleOwners_CTE AS (
	   SELECT DISTINCT RoleId
	   FROM [Risk].[SubCategoryRoleOwners]
	   )
	
	SELECT
		p.PersonId,
		p.DepartmentId,
		d.DepartmentName,
		p.PersonsName,
		p.ControlId,
		p.DepartmentHead,
		p.EmployeeBK,
		p.FullEmployeeBK,
		p.SourceSystemId,
		p.ActiveFlag,
		p.ActiveFlagDateTime,
		p.ContactEmailAddress,
		p.UserBK,
		p.JobTitle,
		p.EmploymentState,
		p.EmployeeIdBK,
		IsNull( rp.RoleId, -1) as AssignedRoleId,
		IsNull( r.RoleName, 'Unknown') as AssignedRoleName,
		ISNULL( r.RoleBK, 'Unknown') AS AssignedRoleBK,
		djp.ProjectKey AS JiraBauProjectKey,
		ISNULL(pjp.ProjectKey, djp.ProjectKey) As PreferredJiraProjectKey,
		jiraUser.Username AS JiraUsername,
		gtaUser.Username AS GTAUsername,
		SLACKUSER.Username AS SlackUsername
		,CASE WHEN dp.PersonId IS NULL THEN (SELECT PersonId FROM [Core].[Persons] WHERE PersonId IN (SELECT DefaultPAPersonId FROM [Organisation].[DepartmentalDefaultPA] WHERE DepartmentId=-1)) ELSE dp.PersonId END as DefaultPAId
		,CASE WHEN dp.PersonId IS NULL THEN (SELECT PersonsName FROM [Core].[Persons] WHERE PersonId IN (SELECT DefaultPAPersonId FROM [Organisation].[DepartmentalDefaultPA] WHERE DepartmentId=-1)) ELSE dp.PersonsName END as DefaultPAName
        ,p.IsTeamLeader
		,CASE WHEN scro.RoleId IS NULL THEN CAST(0 as bit) ELSE CAST(1 as bit) END as IsRiskOwner
		FROM Core.Persons p
	LEFT OUTER JOIN Core.Departments d
	ON p.DepartmentId = d.DepartmentId
	LEFT OUTER JOIN Core.RolePersonRelationship rp
		ON p.PersonId = RP.PersonId
		AND rp.ActiveFlag = 1
	LEFT OUTER JOIN Core.Roles r
		ON rp.RoleId = r.RoleId
		AND r.ActiveFlag = 1
	LEFT OUTER JOIN Organisation.DepartmentalJiraProjects djp
		ON p.DepartmentId = djp.DepartmentId AND djp.DepartmentalJiraProjectTypeId = 1 --BAU Project
	LEFT OUTER JOIN Core.SystemUsernames jiraUser
		ON p.PersonId = jiraUser.PersonId AND  jiraUser.SourceSystemId = (Select TOP 1 SourceSystemId from Audit.SourceSystems where SourceSystemCode = 'JIRA')
	LEFT OUTER JOIN Core.SystemUsernames GTAUser
		ON p.PersonId = GTAUser.PersonId AND  GTAUser.SourceSystemId = (Select TOP 1 SourceSystemId from Audit.SourceSystems where SourceSystemCode = 'GTA')
	LEFT OUTER JOIN Core.SystemUsernames SLACKUSER
		ON p.PersonId = SLACKUSER.PersonId AND  SLACKUSER.SourceSystemId = (Select TOP 1 SourceSystemId from Audit.SourceSystems where SourceSystemCode = 'SLCK')
	LEFT OUTER JOIN Organisation.PersonJiraProjects pjp
		ON p.PersonId = pjp.PersonId AND pjp.PreferredProject = 1
	LEFT OUTER JOIN [Organisation].[DepartmentalDefaultPA] ddp
	    ON p.DepartmentId = ddp.DepartmentId
	LEFT OUTER JOIN [Core].[Persons] dp
		ON ddp.DefaultPAPersonId = dp.PersonId
	LEFT OUTER JOIN SubCategoryRoleOwners_CTE scro
		ON r.RoleId = scro.RoleId
	WHERE p.ActiveFlag = 1
	;
