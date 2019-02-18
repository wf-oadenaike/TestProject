CREATE VIEW [Access.ManyWho].[ClientTakeOnTasksReadOnlyVw]
	AS 
SELECT
	   ctt.ClientTakeOnTaskId
	 , ctt.Stage
	 , ctt.SummaryDetails
	 , ctt.ReporterRole
	 , ctt.AssigneeRole
	 , ctt.Description
	 , ctt.DueDate
	 , ctt.IsActive
	 , ctt.JiraEpicKey
     , ctt.Labels
	 , ctt.StoryPoints
	 , ctt.IssueType
	 , rr.JiraUsername as ReporterJiraUsername
     , ar.JiraUsername as AssigneeJiraUsername
     , ctt.ClientTakeOnTasksCreationDatetime
     , ctt.ClientTakeOnTasksLastModifiedDatetime
  FROM [Sales].[ClientTakeOnTasks] ctt
  LEFT OUTER JOIN [Access.ManyWho].[PersonsActiveVw] rr
  ON ctt.ReporterRole = rr.[AssignedRoleName]
  LEFT OUTER JOIN [Access.ManyWho].[PersonsActiveVw] ar
  ON ctt.AssigneeRole = ar.[AssignedRoleName]
  ;
