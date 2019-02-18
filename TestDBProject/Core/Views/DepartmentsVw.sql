CREATE VIEW Core.DepartmentsVw
	AS
	SELECT
		DepartmentId,
		DepartmentName,
		DepartmentNumber,
		ControlId,
		ActiveFlag,
		ActiveFlagDateTime,
		DepartmentName as DepartmentNameAlias
	FROM Core.Departments
	;
