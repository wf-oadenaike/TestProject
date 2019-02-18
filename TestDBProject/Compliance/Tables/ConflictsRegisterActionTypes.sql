CREATE TABLE [Compliance].[ConflictsRegisterActionTypes] (
    [ActionTypeId] SMALLINT     NOT NULL,
    [ActionType]   VARCHAR (63) NOT NULL,
    [CreationDate] DATETIME     CONSTRAINT [DF_CRAT_CDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKConflictsRegisterActionTypes] PRIMARY KEY CLUSTERED ([ActionTypeId] ASC)
);

