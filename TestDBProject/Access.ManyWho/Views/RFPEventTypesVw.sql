-- IanMc DAP372 1/4/16
CREATE VIEW [Access.ManyWho].[RFPEventTypesVw]
AS
    SELECT  
		    RFPEventTypeId
	      , RFPEventType                                
	FROM [Sales].[RFPEventTypes]

;
