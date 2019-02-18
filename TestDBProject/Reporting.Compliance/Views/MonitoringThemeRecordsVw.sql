CREATE VIEW [Reporting.Compliance].[MonitoringThemeRecordsVw]
AS
  SELECT  MonitoringThemeId
        , RecordId
		, CreationDate
		, Text
  FROM [Compliance].[GetMonitoringThemeRecords_uf] ()
;
