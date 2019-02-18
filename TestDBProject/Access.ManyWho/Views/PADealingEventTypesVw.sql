
CREATE VIEW [Access.ManyWho].[PADealingEventTypesVw]
	AS
	SELECT   pet.PADealingEventTypeId
	       , pet.PADealingEventType
	FROM [Compliance].[PADealingEventTypes] pet
	
		;
