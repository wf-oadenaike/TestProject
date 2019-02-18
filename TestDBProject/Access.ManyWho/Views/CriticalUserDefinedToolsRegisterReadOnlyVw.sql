


CREATE VIEW [Access.ManyWho].[CriticalUserDefinedToolsRegisterReadOnlyVw]
	AS 
SELECT
	ToolId,
	ToolName,
	ToolPurpose,
	ToolOwnerId,
	cp.PersonsName as ToolOwnerName,
	dep.DepartmentName,
	StatusId,
	cfs.FlowStatusName as StatusName,
	LastReviewDate,
	CASE WHEN TargetRetirementDate > DATEADD(year, 1, LastReviewDate) or TargetRetirementDate is null
    THEN  DATEADD(year, 1, LastReviewDate)
    ELSE TargetRetirementDate END AS NextReviewDate,
	TargetRetirementDate,
	IncludedInBIAAssessment,
	JoinGUID,
	JiraIssueKey
  FROM [Organisation].[CriticalUserDefinedToolsRegister] cud
  INNER JOIN [Core].[Persons] cp
  ON cud.ToolOwnerId = cp.PersonId
  INNER JOIN [Core].[Departments] dep
  ON cp.DepartmentId = dep.DepartmentId
  INNER JOIN [Core].[FlowStatus] cfs
  ON cud.StatusId = cfs.FlowStatusId



