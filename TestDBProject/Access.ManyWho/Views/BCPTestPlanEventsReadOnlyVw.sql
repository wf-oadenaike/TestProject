CREATE VIEW [Access.ManyWho].[BCPTestPlanEventsReadOnlyVw]
	AS 
SELECT
	  tpe.BCPTestPlanEventId
    , tpe.BCPTestPlanRegisterId
	, tpr.DepartmentId
	, tpr.DepartmentName
	, tpr.IsActive
	, tpr.TestRequirement
	, tpr.TestSuccessCriteria
	, tpe.TestPlanStatus
	, tpe.RecordedByPersonId
	, rp.PersonsName as RecordedBy
	, tpe.EventDate
    , tpe.EventDetails
    , tpe.TestPlanResult
	, tpe.CalendarYear
	, tpe.IsReTest
    , tpe.DocumentationFolderLink
    , tpe.JoinGUID
    , tpe.BCPTestPlanEventCreationDate
    , tpe.BCPTestPlanEventLastModifiedDatetime
  FROM [BAU].[BCPTestPlanEvents] tpe
  INNER JOIN [Access.ManyWho].[BCPTestPlanRegisterReadOnlyVw] tpr
  ON tpe.BCPTestPlanRegisterId = tpr.BCPTestPlanRegisterId
  INNER JOIN [Core].[Persons] rp
  ON tpe.RecordedByPersonId = rp.PersonId
  
  ;
