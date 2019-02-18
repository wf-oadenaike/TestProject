CREATE VIEW [Access.ManyWho].[RiskAppetiteEventsReadOnlyVw]
	AS 
SELECT
	R.RiskAppetiteEventId,
	R.RiskAppetiteRegisterId,
	R.RiskEventTypeID,
	RAE.RiskEventType,
	R.SubmittedByPersonId,
	CP1.PersonsName SubmittedByName,
	R.RiskEventDate,
	R.RiskEventDetails,
	R.JiraIssueKey,
	R.JoinGUID
FROM [Risk].[RiskAppetiteEvents]  R

INNER JOIN [Core].[Persons] CP1 
ON R.SubmittedByPersonId = CP1.PersonId

INNER JOIN [Risk].[RiskRegisterEventTypes] RAE 
ON R.RiskEventTypeID = RAE.RiskEventTypeID

