CREATE VIEW [Access.ManyWho].[BCPCriticalProcessRegisterVw]
	AS 
SELECT
	  cpr.BCPCriticalProcessId
	, cpr.CriticalProcess
	, cpr.Summary
	, cpr.RecoveryTimeFrame
	, cpr.Status
	, cpr.IsActive
	, cpr.OwnerPersonId
    , cpr.RecordedByPersonId
    , cpr.DepartmentId
	, cpr.DocumentationFolderLink
    , cpr.JoinGUID
    , cpr.BCPCriticalProcessCreationDatetime
    , cpr.BCPCriticalProcessLastModifiedDatetime
  FROM [BAU].[BCPCriticalProcessRegister] cpr
  ;
