CREATE VIEW [Access.ManyWho].[BrokerReviewEventTypesVw]
	AS 
SELECT
	   BrokerReviewEventTypeId
	 , BrokerReviewEventType
  FROM [Organisation].[BrokerReviewEventTypes]

  ;
