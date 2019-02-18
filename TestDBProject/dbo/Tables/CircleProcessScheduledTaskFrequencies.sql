CREATE TABLE [dbo].[CircleProcessScheduledTaskFrequencies] (
    [Id]                SMALLINT      IDENTITY (1, 1) NOT NULL,
    [Frequency]         VARCHAR (255) NULL,
    [FrequencyDayMin]   SMALLINT      NULL,
    [FrequencyDayMax]   SMALLINT      NULL,
    [FrequencyStartMin] SMALLINT      NULL,
    [FrequencyStartMax] SMALLINT      NULL
);

