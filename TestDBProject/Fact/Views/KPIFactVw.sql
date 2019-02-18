CREATE VIEW Fact.KPIFactVw
	AS
	SELECT	f.KPIFactId
	      , f.MeasureDateId
	      , f.KPIId
	      , f.MeasureValue
	      , f.ControlId
	      , f.SourceSystemId
	      , ss.SourceSystemName
	FROM Fact.KPIFact f
		INNER JOIN Audit.SourceSystems ss
			ON f.SourceSystemId = ss.SourceSystemId
;
