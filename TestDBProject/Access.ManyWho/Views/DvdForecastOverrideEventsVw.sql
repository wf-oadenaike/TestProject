CREATE VIEW [Access.ManyWho].[DvdForecastOverrideEventsVw]
	AS 
  SELECT DvdForecastOverrideEventId
       , DvdForecastCalcOverrideId
	   , SubmittedByPersonId
	   , p.PersonsName as SubmittedBy
	   , OverrideExDate
	   , OverrideDvdValue
	   , OverrideSpecialCumShares
	   , OverrideCommentary
	   , OverrideDvdChangeReasonId
	   , ocr.[DvdChangeReason] as OverrideDvdChangeReason	   
       , EventDate
       , JoinGUID
       , DvdForecastOverrideEventCreationDatetime
       , DvdForecastOverrideEventLastModifiedDatetime
  FROM [Investment].[DvdForecastOverrideEvents] oe
  LEFT OUTER JOIN [Investment].[DvdChangeReasons] ocr
  ON oe.OverrideDvdChangeReasonId = ocr.DvdChangeReasonId
  LEFT OUTER JOIN [Core].[Persons] p
  ON p.PersonId = oe.SubmittedByPersonId;
