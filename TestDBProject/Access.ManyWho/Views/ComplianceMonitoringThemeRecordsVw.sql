CREATE VIEW [Access.ManyWho].[ComplianceMonitoringThemeRecordsVw]
AS
  SELECT  MonitoringThemeId
        , RecordId
		, CreationDate
		, Text
  FROM [Compliance].[GetMonitoringThemeRecords_uf] ()
;
