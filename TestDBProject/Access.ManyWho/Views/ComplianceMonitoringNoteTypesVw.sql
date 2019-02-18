CREATE VIEW [Access.ManyWho].[ComplianceMonitoringNoteTypesVw]
AS
    SELECT  MonitoringNoteTypeId
	      , MonitoringNoteType
	      , MonitoringNoteTypeCreationDate
	FROM [Compliance].[MonitoringNoteTypes]

;
