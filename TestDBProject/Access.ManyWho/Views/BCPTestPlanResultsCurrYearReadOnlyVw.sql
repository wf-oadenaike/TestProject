CREATE VIEW [Access.ManyWho].[BCPTestPlanResultsCurrYearReadOnlyVw]
	AS 
SELECT
	  tpr.BCPTestPlanRegisterId
    , tpr.TestPlanOwnerPersonId
	, op.PersonsName as TestPlanOwner
    , tpr.DepartmentId
	, d.DepartmentName
	, tpr.TestRequirement
	, tpr.TestSuccessCriteria
	, tpr.TestStartTime
	, tpr.TestEndTime
	, tpe.TestPlanStatus
	, tpe.TestPlanResult
	, tpe.EventDetails as TestComments
	, tpe.CalendarYear
	, tpe.EventDate
  FROM [BAU].[BCPTestPlanRegister] tpr
  INNER JOIN [Core].[Departments] d
  ON tpr.DepartmentId = d.DepartmentId
  INNER JOIN [Core].[Persons] op
  ON tpr.TestPlanOwnerPersonId = op.PersonId
  LEFT OUTER JOIN [BAU].[BCPTestPlanEvents] tpe
  ON tpr.BCPTestPlanRegisterId = tpe.BCPTestPlanRegisterId
  AND tpe.CalendarYear = DATEPART(year,GetDate())
  WHERE tpr.IsActive = 1

  ;
