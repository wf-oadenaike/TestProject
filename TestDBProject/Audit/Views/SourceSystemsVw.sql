CREATE VIEW Audit.SourceSystemsVw
	AS
	SELECT
		SourceSystemId,
		SourceSystemName,
		SourceSystemCode
	FROM Audit.SourceSystems
	;
