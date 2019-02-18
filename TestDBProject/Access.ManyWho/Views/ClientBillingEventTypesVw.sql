CREATE VIEW [Access.ManyWho].[ClientBillingEventTypesVw]
AS
    SELECT  ClientBillingEventTypeId
	      , ClientBillingEventType
	FROM [Sales].[ClientBillingEventTypes]

;
