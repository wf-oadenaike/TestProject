CREATE TABLE [Compliance].[ConflictsRegisterUserInteractionTypes] (
    [UserInteractionTypeId] SMALLINT     NOT NULL,
    [UserInteractionType]   VARCHAR (63) NOT NULL,
    [CreationDate]          DATETIME     CONSTRAINT [DF_CRUIT_CDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKConflictsRegisterUserInteractionTypes] PRIMARY KEY CLUSTERED ([UserInteractionTypeId] ASC)
);

