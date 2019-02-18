CREATE TABLE [Organisation].[ProjectMeasureUnits] (
    [MeasureUnitBK]      VARCHAR (25)   NOT NULL,
    [MeasureDescription] VARCHAR (2048) NOT NULL,
    [DaysEquivalent]     SMALLINT       CONSTRAINT [DF_PMU_DE] DEFAULT ((1)) NOT NULL,
    [SortSequence]       SMALLINT       NOT NULL,
    CONSTRAINT [PKProjectMeasureUnits] PRIMARY KEY CLUSTERED ([SortSequence] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIProjectMeasureUnits]
    ON [Organisation].[ProjectMeasureUnits]([MeasureUnitBK] ASC);

