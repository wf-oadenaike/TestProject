CREATE VIEW Audit.ControlVw
	AS
	SELECT
		[ControlId],
		[RunInitiationDate],
		[CurrentRunStartDate],
		[RunStateId],
		[ExtractPointStartDate],
		[ExtractPointEndDate]
	FROM Audit.Control
	;
