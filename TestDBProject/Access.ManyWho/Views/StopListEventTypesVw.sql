CREATE VIEW [Access.ManyWho].[StopListEventTypesVw]
	AS 
SELECT
	   slet.StopListEventTypeId
	 , slet.StopListEventType
  FROM [Compliance].[StopListEventTypes] slet

  ;
