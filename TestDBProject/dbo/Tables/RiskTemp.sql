CREATE TABLE [dbo].[RiskTemp] (
    [MeasureDateId]       NVARCHAR (8)    NULL,
    [KPIId]               SMALLINT        NOT NULL,
    [MeasureValue]        NUMERIC (19, 5) NULL,
    [LastUpdatedDatetime] DATETIME        NOT NULL,
    [ControlId]           VARCHAR (8000)  NULL,
    [kpiname]             VARCHAR (128)   NOT NULL
);

