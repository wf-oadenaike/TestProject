CREATE VIEW [Access.ManyWho].[BCPTestPlanEventsVw]
	AS 
SELECT
	  tpe.BCPTestPlanEventId
    , tpe.BCPTestPlanRegisterId
	, tpe.TestPlanStatus
	, tpe.RecordedByPersonId
    , tpe.EventDetails
    , tpe.EventDate
    , tpe.TestPlanResult
	, tpe.CalendarYear
	, tpe.IsReTest
    , tpe.DocumentationFolderLink
    , tpe.JoinGUID
    , tpe.BCPTestPlanEventCreationDate
    , tpe.BCPTestPlanEventLastModifiedDatetime
  FROM [BAU].[BCPTestPlanEvents] tpe
  ;
