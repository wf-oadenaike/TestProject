CREATE TABLE [Compliance].[TrainingStatuses] (
    [TrainingStatusId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [TrainingStatus]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKTrainingStatuses] PRIMARY KEY CLUSTERED ([TrainingStatusId] ASC)
);

