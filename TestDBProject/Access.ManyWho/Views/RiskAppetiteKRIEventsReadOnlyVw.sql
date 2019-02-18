
CREATE VIEW [Access.ManyWho].[RiskAppetiteKRIEventsReadOnlyVw]
	AS 
SELECT
	R.RiskAppetiteKRIEventId,
	R.RiskAppetiteKRIRegisterId,
	R.RiskKRIEventTypeID,
	RAE.RiskEventType,
	R.SubmittedByPersonId,
	CP1.PersonsName SubmittedByName,
	R.RiskKRIEventDate,
	R.RiskKRIEventDetails,
	R.JiraIssueKey,
	R.JoinGUID
FROM [Risk].[RiskAppetiteKRIEvents]  R

INNER JOIN [Core].[Persons] CP1 
ON R.SubmittedByPersonId = CP1.PersonId

INNER JOIN [Risk].[RiskRegisterEventTypes] RAE 
ON R.RiskKRIEventTypeID = RAE.RiskEventTypeID

