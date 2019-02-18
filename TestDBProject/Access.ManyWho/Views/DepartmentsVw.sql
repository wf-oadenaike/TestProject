CREATE VIEW [Access.ManyWho].[DepartmentsVw]
	AS 
SELECT  d.[DepartmentId]
      , d.[DepartmentName]
      , d.[DepartmentNumber]
      , d.[ControlId]
      , d.[ActiveFlag]
      , d.[ActiveFlagDateTime]
      , d.[DepartmentSrcId]
      , d.[SourceSystemId]
	  , BAU.ProjectKey as [BAUJiraKey]
	  , ISNULL(PROJ.ProjectKey, BAU.ProjectKey) as [ProjectJiraKey]
      , d.[DepartmentCreationDatetime]
      , d.[DepartmentLastModifiedDatetime]
  FROM [Core].[Departments] d
  LEFT OUTER JOIN [Organisation].[DepartmentalJiraProjects] BAU
  ON d.DepartmentId = BAU.DepartmentId
  AND BAU.DepartmentalJiraProjectTypeId = 1
  LEFT OUTER JOIN [Organisation].[DepartmentalJiraProjects] PROJ
  ON d.DepartmentId = PROJ.DepartmentId
  AND PROJ.DepartmentalJiraProjectTypeId = 2
  ;
