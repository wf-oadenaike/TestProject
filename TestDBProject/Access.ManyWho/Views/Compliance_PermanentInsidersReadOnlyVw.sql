


CREATE VIEW [Access.ManyWho].[Compliance_PermanentInsidersReadOnlyVw]
		AS 
	SELECT
		P.PermanentInsiderID,
		PA.PersonsName as FullName,
		PA.ContactEmailAddress as Email,
		PA.DepartmentName,
		PA.AssignedRoleName,
		P.AdditionDateTime,
		P.CeasedDateTime,
		P.ActiveFlag as IsActive,
		P.CADIS_SYSTEM_INSERTED,
        P.CADIS_SYSTEM_UPDATED,
        P.CADIS_SYSTEM_CHANGEDBY
	FROM [dbo].[Compliance_PermanentInsiders]  P

	INNER JOIN [Access.ManyWho].[PersonsActiveVw] PA
	ON P.PersonID = PA.PersonId

