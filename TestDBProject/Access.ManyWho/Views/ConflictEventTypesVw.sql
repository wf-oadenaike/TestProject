CREATE VIEW [Access.ManyWho].[ConflictEventTypesVw]
	AS
	SELECT ConflictEventTypeId, ConflictEventTypeBK, ConflictEventDescription
	FROM [Compliance].[ConflictEventTypes];
