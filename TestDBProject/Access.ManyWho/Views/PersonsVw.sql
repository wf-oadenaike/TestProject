CREATE VIEW [Access.ManyWho].[PersonsVw]
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
	;
