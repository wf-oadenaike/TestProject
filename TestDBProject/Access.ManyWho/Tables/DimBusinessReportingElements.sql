CREATE TABLE [Access.ManyWho].[DimBusinessReportingElements] (
    [ElementId]   UNIQUEIDENTIFIER NOT NULL,
    [ElementName] NVARCHAR (255)   NOT NULL,
    [Created]     DATETIME         NOT NULL,
    CONSTRAINT [PKDimBusinessReportingElements] PRIMARY KEY CLUSTERED ([ElementId] ASC)
);

