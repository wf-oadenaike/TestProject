CREATE VIEW [Access.ManyWho].[MeetingAttendeesVw]
	AS
	SELECT ma.MeetingRegisterId, mr.MeetingNameBK, ma.AttendeeRoleId, r.RoleName as AttendeeRoleName
			, ISNULL( p.PersonId, up.PersonId) as AttendeePersonId, ISNULL( p.PersonsName, up.PersonsName) as AttendeeName, ISNULL( p.EmployeeBK, up.EmployeeBK) as AttendeeSalesforceUserId
			, ma.WorkflowVersionGUID, ma.JoinGUID
	FROM Organisation.MeetingAttendees ma
		INNER JOIN Organisation.MeetingsRegister mr
			ON ma.MeetingRegisterId = mr.MeetingRegisterId
		INNER JOIN Core.Roles r
			ON ma.AttendeeRoleId = r.RoleId
		LEFT OUTER JOIN Core.RolePersonRelationship rpr
			ON r.RoleId = rpr.RoleId
			AND rpr.ActiveFlag = 1
			LEFT OUTER JOIN Core.Persons p
				ON rpr.PersonId = p.PersonId
				AND p.ActiveFlag = 1
			LEFT OUTER JOIN Core.Persons up
				ON -1 = up.PersonId
				AND up.ActiveFlag = 1
		WHERE ISNULL( p.PersonsName, up.PersonsName) IS NOT NULL  --Removes rows when a user is not Active but assigned to a role, person relationship
