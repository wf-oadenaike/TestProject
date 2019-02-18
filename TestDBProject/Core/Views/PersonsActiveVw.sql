CREATE VIEW [Core].[PersonsActiveVw]
	AS 
	SELECT
		PersonId,
		DepartmentId,
		PersonsName,
		ControlId,
		DepartmentHead,
		EmployeeBK,
		SourceSystemId,
		ActiveFlag,
		ActiveFlagDateTime,
		ContactEmailAddress
	FROM Core.Persons
	WHERE ActiveFlag = 1
	;
