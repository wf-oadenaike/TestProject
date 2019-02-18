
CREATE VIEW [Access.ManyWho].[CircleProcessScheduledTasksToday] AS

SELECT
	 CPST.[Id]
	,CPST.[CircleProcessId]
	,CP.[Name] AS CircleProcessName
    ,CPST.[Frequency]
	,CPST.[FrequencyDay]
	,CPST.[FrequencyStart]
    ,CPST.[ProjectKey]
    ,CPST.[EpicKey]
    ,CPST.[IssueType]
    ,CPST.[ReporterPersonId]
	,P1.[PersonsName] AS ReporterPersonsName
	,P1.[JiraUsername] AS ReporterPersonsJiraUsername
    ,CPST.[AssigneePersonId]
	,P2.PersonsName AS AssigneePersonsName
	,P2.[JiraUsername] AS AssigneePersonsJiraUsername
	,CPST.[DueDateOffset]
    ,CPST.[Summary]
    ,CPST.[Purpose]
    ,CPST.[Outcome]
    ,CPST.[Description]
    ,CPST.[IsActive]
	,CPST.[CADIS_SYSTEM_INSERTED]
	,CPST.[CADIS_SYSTEM_UPDATED]
	,CPST.[CADIS_SYSTEM_CHANGEDBY]
FROM [dbo].[CircleProcessScheduledTasks] CPST
LEFT JOIN [dbo].[CircleProcesses] CP ON CP.Id = CPST.CircleProcessId
LEFT JOIN [Access.ManyWho].[PersonsActiveVw] P1 ON P1.PersonId = CPST.ReporterPersonId
LEFT JOIN [Access.ManyWho].[PersonsActiveVw] P2 ON P2.PersonId = CPST.AssigneePersonId
WHERE IsActive = 1
AND 
(
       Frequency = 'Daily'
  OR ( Frequency = 'Weekdays' AND DATEPART(WEEKDAY, GetDate()) in (2,3,4,5,6) )
  OR ( Frequency = 'Weekends' AND DATEPART(WEEKDAY, GetDate()) in (1,7) )
  OR ( Frequency = 'Weekly' AND FrequencyDay = DATEPART(WEEKDAY, GetDate()) )
  OR ( Frequency = 'Fortnightly' AND FrequencyDay = DATEPART(WEEKDAY, GetDate()) AND ( (FrequencyStart = 1 AND ( CAST( (DATEPART(WEEK, GetDate() ) ) AS DECIMAL(3,1))/2 != ceiling(CAST( (DATEPART(WEEK, GetDate() ) ) AS DECIMAL(3,1))/2) ) ) OR (FrequencyStart = 2 AND ( CAST( (DATEPART(WEEK, GetDate() ) ) AS DECIMAL(3,1))/2  = ceiling(CAST( (DATEPART(WEEK, GetDate() ) ) AS DECIMAL(3,1))/2) ) ) ) )
  OR ( Frequency = 'Monthly'AND FrequencyDay = DATEPART(DAY, GetDate()) )
  OR ( Frequency = 'Bi-Monthly' AND FrequencyDay = DATEPART(DAY, GetDate()) AND FrequencyStart in ( DATEPART(MONTH, GETDATE()), (DATEPART(MONTH, GETDATE()) - 2), (DATEPART(MONTH, GETDATE()) - 4), (DATEPART(MONTH, GETDATE()) - 6), (DATEPART(MONTH, GETDATE()) - 8), (DATEPART(MONTH, GETDATE()) - 10) ) )
  OR ( Frequency = 'Quarterly' AND FrequencyDay = DATEPART(DAY, GetDate()) AND FrequencyStart in ( DATEPART(MONTH, GETDATE()), (DATEPART(MONTH, GETDATE()) - 3), (DATEPART(MONTH, GETDATE()) - 6), (DATEPART(MONTH, GETDATE()) - 9) ) )
  OR ( Frequency = 'Semi-Annually' AND FrequencyDay = DATEPART(DAY, GetDate()) AND FrequencyStart in ( DATEPART(MONTH, GETDATE()), (DATEPART(MONTH, GETDATE()) - 6) ) )
  OR ( Frequency = 'Annually' AND FrequencyDay = DATEPART(DAY, GetDate()) AND FrequencyStart = DATEPART(MONTH, GETDATE()) )
)
