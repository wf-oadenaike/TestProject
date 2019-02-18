CREATE VIEW [Access.WebDev].[SignatoryReviewEventsReadOnlyVw]
	AS 
	SELECT sre.SignatoryReviewEventId
		 , ev.EventId
	     , pr.PolicyName as ReviewTitle
		 , 'Policy' as ReviewType
		 , ev.EventStatus
		 , ev.EventTrueFalse
	     , sre.SignatoryRoleId
		 , r.RoleName as SignatoryRoleName
	     , sre.SignatoryPersonId 
		 , sp.PersonsName as SignatoryName
	     , sre.EventDetails
	     , sre.EventDate
	     , sre.EventStatus as SignatoryEventStatus
	     , sre.EventTrueFalse as SignatoryEventTrueFalse
	     , sre.JiraTaskKey as SignatoryJiraTaskKey
		 , sre.SubmittedByPersonId 
		 , cp.PersonsName as SubmittedByPerson
		 , sre.LastModifiedByPersonId 
		 , mp.PersonsName as LastModifiedByPerson
	     , sre.DocumentationFolderLink
	     , sre.JoinGUID
	     , sre.SignatoryReviewEventCreationDatetime
	     , sre.SignatoryReviewEventLastModifiedDatetime
	FROM [PolicyProc].[SignatoryReviewEvents] sre
	INNER JOIN [PolicyProc].[Events] ev
	ON sre.EventId = ev.EventId
	INNER JOIN [PolicyProc].[PolicyRegister] pr
	ON ev.PolicyId = pr.PolicyId
	LEFT OUTER JOIN [Core].[Roles] r
	ON sre.SignatoryRoleId = r.RoleId
	LEFT OUTER JOIN [Core].[Persons] sp
	ON sre.SignatoryPersonId = sp.PersonId
	INNER JOIN [Core].[Persons] cp
	ON sre.SubmittedByPersonId = cp.PersonId
	LEFT OUTER JOIN [Core].[Persons] mp
	ON sre.LastModifiedByPersonId = mp.PersonId
	
	UNION
	SELECT sre.SignatoryReviewEventId
		 , ev.EventId
	     , pd.DocumentName as ReviewTitle
		 , 'Procedure' as ReviewType
		 , ev.EventStatus
		 , ev.EventTrueFalse
	     , sre.SignatoryRoleId
		 , r.RoleName as SignatoryRoleName
	     , sre.SignatoryPersonId 
		 , sp.PersonsName as SignatoryName
	     , sre.EventDetails
	     , sre.EventDate
	     , sre.EventStatus as SignatoryEventStatus
	     , sre.EventTrueFalse as SignatoryEventTrueFalse
	     , sre.JiraTaskKey as SignatoryJiraTaskKey
		 , sre.SubmittedByPersonId 
		 , cp.PersonsName as SubmittedByPerson
		 , sre.LastModifiedByPersonId 
		 , mp.PersonsName as LastModifiedByPerson
	     , sre.DocumentationFolderLink
	     , sre.JoinGUID
	     , sre.SignatoryReviewEventCreationDatetime
	     , sre.SignatoryReviewEventLastModifiedDatetime
	FROM [PolicyProc].[SignatoryReviewEvents] sre
	INNER JOIN  [PolicyProc].[Events] ev
	ON sre.EventId = ev.EventId
	INNER JOIN [PolicyProc].[ProceduresDocument] pd
	ON ev.ProcDocumentId = pd.ProcDocumentId
	LEFT OUTER JOIN [Core].[Roles] r
	ON sre.SignatoryRoleId = r.RoleId
	LEFT OUTER JOIN [Core].[Persons] sp
	ON sre.SignatoryPersonId = sp.PersonId	
	INNER JOIN [Core].[Persons] cp
	ON sre.SubmittedByPersonId = cp.PersonId
	LEFT OUTER JOIN [Core].[Persons] mp
	ON sre.LastModifiedByPersonId = mp.PersonId
;
