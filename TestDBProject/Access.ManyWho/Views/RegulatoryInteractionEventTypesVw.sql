CREATE VIEW [Access.ManyWho].[RegulatoryInteractionEventTypesVw]
	AS 
SELECT
	   RegulatoryInteractionEventTypeId
	 , RegulatoryInteractionEventType
  FROM [Compliance].[RegulatoryInteractionEventTypes]

  ;
