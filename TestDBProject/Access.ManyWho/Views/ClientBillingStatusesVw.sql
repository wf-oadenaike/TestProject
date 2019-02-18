CREATE VIEW [Access.ManyWho].[ClientBillingStatusesVw]
AS
    SELECT  ClientBillingStatusId
	      , ClientBillingStatus
	FROM [Sales].[ClientBillingStatuses]

;
