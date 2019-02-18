CREATE VIEW [Access.WebDev].[StopListRegisterVw]
	AS 
	WITH LatestReason as (
						SELECT sle.StopListId
						      , sle.StopListEventTypeId
							,  MAX(sle.EventDate) as LatestEventDate
						FROM  [Compliance].[StopListEvents] sle
		                INNER JOIN [Compliance].[StopListEventTypes] slet
		                ON sle.StopListEventTypeId = slet.StopListEventTypeId
                        WHERE slet.StopListEventType = 'Reason'
					    GROUP BY sle.StopListId
						       , sle.StopListEventTypeId
						),
	     LatestCleanseReason as (
						SELECT sle.StopListId
						    ,  sle.StopListEventTypeId 
							,  MAX(sle.EventDate) as LatestEventDate
						FROM  [Compliance].[StopListEvents] sle
		                INNER JOIN [Compliance].[StopListEventTypes] slet
		                ON sle.StopListEventTypeId = slet.StopListEventTypeId
                        WHERE slet.StopListEventType = 'Cleanse Reason'
					    GROUP BY sle.StopListId
						       , sle.StopListEventTypeId 
						)	
SELECT
	   slr.StopListId
	 , slr.StoppedCompanyName
	 , slr.Ticker
	 , slr.BloombergId
	 , slr.InvestmentStopNumber
	 , slr.Status
	 , slr.AdvisedDate
	 , slr.RequestedDate
	 , CASE WHEN slr.IsStopRequested = 1 THEN 'Yes' WHEN slr.IsStopRequested = 0 THEN 'No' ELSE NULL END as IsStopRequested
	 , slr.StoppedDate
	 , CASE WHEN slr.IsStopped = 1 THEN 'Yes' WHEN slr.IsStopped = 0 THEN 'No' ELSE NULL END as IsStopped
	 , CASE WHEN slr.IsCleanseRequested = 1 THEN 'Yes' WHEN slr.IsCleanseRequested = 0 THEN 'No' ELSE NULL END as IsCleanseRequested
	 , CASE WHEN slr.IsCleansed = 1 THEN 'Yes' WHEN slr.IsCleansed = 0 THEN 'No' ELSE NULL END as IsCleansed
	 , slr.CleansedDate
	 , slr.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
	 , slr.CleanseRequestorPersonId
	 , cp.PersonsName as CleanseRequestedBy
	 , slr.CleanseRequestDate	
	 , slr.AnticipatedCleanseDate
	 , sle.EventDetails as LatestReason
	 , sle2.EventDetails as LatestCleanseReason
	 , slr.DocumentationFolderLink
	 , slr.JoinGUID
	 , slr.StopListRegisterCreationDatetime
	 , slr.StopListRegisterLastModifiedDatetime
  FROM [Compliance].[StopListRegister] slr
  INNER JOIN [Core].[Persons] sp
  ON slr.SubmittedByPersonId = sp.PersonId
  LEFT OUTER JOIN [Core].[Persons] cp
  ON slr.CleanseRequestorPersonId = cp.PersonId
  
  LEFT OUTER JOIN LatestReason lr
  on lr.StopListId = slr.StopListId
  LEFT OUTER JOIN [Compliance].[StopListEvents] sle
  ON lr.StopListId = sle.StopListId
  AND lr.StopListEventTypeId = sle.StopListEventTypeId
  AND lr.LatestEventDate = sle.EventDate

  LEFT OUTER JOIN LatestCleanseReason lcr
  on lcr.StopListId = slr.StopListId
  LEFT OUTER JOIN [Compliance].[StopListEvents] sle2
  ON lcr.StopListId = sle2.StopListId
  AND lcr.StopListEventTypeId = sle2.StopListEventTypeId
  AND lcr.LatestEventDate = sle2.EventDate

  ;
