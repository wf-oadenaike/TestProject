CREATE VIEW [Access.ManyWho].[DvdNTHighLevelOverrideEventsVw]
	AS 
  SELECT DvdNTHighLevelOverrideEventId
       , Qtr
	   , SubmittedByPersonId
	   , p.PersonsName as SubmittedBy
	   , OverrideNetIncome
	   , OverrideUnitsInIssue
	   , DvdRate
	   , OverrideCommentary
	   , OverrideDvdChangeReasonId
	   , ocr.[DvdChangeReason] as OverrideDvdChangeReason		   
       , EventDate
       , JoinGUID
       , DvdNTHighLevelOverrideEventCreationDatetime
       , DvdNTHighLevelOverrideEventLastModifiedDatetime
  FROM [Investment].[DvdNTHighLevelOverrideEvents] oe
  LEFT OUTER JOIN [Investment].[DvdChangeReasons] ocr
  ON oe.OverrideDvdChangeReasonId = ocr.DvdChangeReasonId
  LEFT OUTER JOIN [Core].[Persons] p
  ON p.PersonId = oe.SubmittedByPersonId;
