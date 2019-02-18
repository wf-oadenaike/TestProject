CREATE VIEW [Access.ManyWho].[RolesVw]
	AS 
	SELECT r.RoleId, r.RoleName, r.ActiveFlag, r.[RoleCreationDatetime] as RoleCreationDate, r.[RoleLastModifiedDatetime] as RoleLastModifiedDate
			, r.ControlId, r.RoleBK, r.SourceSystemId, ss.SourceSystemName
	FROM Core.Roles r
		INNER JOIN Audit.SourceSystemsVw ss
		ON r.SourceSystemId = ss.SourceSystemId
