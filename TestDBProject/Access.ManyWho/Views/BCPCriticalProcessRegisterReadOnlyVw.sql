CREATE VIEW [Access.ManyWho].[BCPCriticalProcessRegisterReadOnlyVw]
	AS 
SELECT
	  cpr.BCPCriticalProcessId
	, cpr.CriticalProcess
	, cpr.Summary
	, cpr.RecoveryTimeFrame
	, cpr.Status
	, cpr.IsActive
	, cpr.OwnerPersonId
	, op.PersonsName as CriticalProcessOwner
    , cpr.RecordedByPersonId
	, rp.PersonsName as RecordedBy
    , cpr.DepartmentId
	, d.DepartmentName	
	, cpr.DocumentationFolderLink
    , cpr.JoinGUID
    , cpr.BCPCriticalProcessCreationDatetime
    , cpr.BCPCriticalProcessLastModifiedDatetime
  FROM [BAU].[BCPCriticalProcessRegister] cpr
  INNER JOIN [Core].[Persons] rp
  ON cpr.RecordedByPersonId = rp.PersonId
  INNER JOIN [Core].[Persons] op
  ON cpr.RecordedByPersonId = op.PersonId
  LEFT OUTER JOIN [Core].[Departments] d
  ON cpr.DepartmentId = d.DepartmentId 
  ;
