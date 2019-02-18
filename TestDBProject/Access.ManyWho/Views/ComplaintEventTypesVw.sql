

CREATE VIEW [Access.ManyWho].[ComplaintEventTypesVw]
	AS
	SELECT ComplaintEventTypeId, ComplaintEventType
	FROM [Compliance].[ComplaintEventTypes];
