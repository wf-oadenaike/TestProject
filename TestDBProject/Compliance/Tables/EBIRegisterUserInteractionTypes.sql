CREATE TABLE [Compliance].[EBIRegisterUserInteractionTypes] (
    [UserInteractionTypeId] SMALLINT     NOT NULL,
    [UserInteractionType]   VARCHAR (63) NOT NULL,
    [CreationDate]          DATETIME     CONSTRAINT [DF_EBIR_CDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKEBIRegisterUserInteractionTypes] PRIMARY KEY CLUSTERED ([UserInteractionTypeId] ASC)
);

