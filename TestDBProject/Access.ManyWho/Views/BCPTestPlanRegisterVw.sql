CREATE VIEW [Access.ManyWho].[BCPTestPlanRegisterVw]
	AS 
SELECT
	  tpr.BCPTestPlanRegisterId
    , tpr.TestPlanOwnerPersonId
    , tpr.DepartmentId
	, tpr.TestRequirement
	, tpr.TestSuccessCriteria
	, tpr.TestStartTime
	, tpr.TestEndTime
	, tpr.TestStatus
	, tpr.RecordedByPersonId
	, tpr.IsActive
	, tpr.DocumentationFolderLink
    , tpr.JoinGUID
    , tpr.BCPTestPlanRegisterCreationDatetime
    , tpr.BCPTestPlanRegisterLastModifiedDatetime
  FROM [BAU].[BCPTestPlanRegister] tpr
  ;
