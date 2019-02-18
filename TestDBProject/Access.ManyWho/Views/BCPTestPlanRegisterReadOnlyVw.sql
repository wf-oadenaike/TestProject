CREATE VIEW [Access.ManyWho].[BCPTestPlanRegisterReadOnlyVw]
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
	, tpr.TestStatus
	, tpr.RecordedByPersonId
	, rp.PersonsName as RecordedBy
	, tpr.IsActive
	, tpr.DocumentationFolderLink
    , tpr.JoinGUID
    , tpr.BCPTestPlanRegisterCreationDatetime
    , tpr.BCPTestPlanRegisterLastModifiedDatetime
  FROM [BAU].[BCPTestPlanRegister] tpr
  INNER JOIN [Core].[Departments] d
  ON tpr.DepartmentId = d.DepartmentId
  INNER JOIN [Core].[Persons] op
  ON tpr.TestPlanOwnerPersonId = op.PersonId
  INNER JOIN [Core].[Persons] rp
  ON tpr.RecordedByPersonId = rp.PersonId
  ;
