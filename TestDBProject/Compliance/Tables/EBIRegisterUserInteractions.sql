CREATE TABLE [Compliance].[EBIRegisterUserInteractions] (
    [EBIRegisterUserInteractionId] INT              IDENTITY (1, 1) NOT NULL,
    [EBIRegisterId]                INT              NOT NULL,
    [UserInteractionTypeId]        SMALLINT         NOT NULL,
    [InteractionMessage]           NVARCHAR (MAX)   NOT NULL,
    [InteractionDate]              DATETIME         CONSTRAINT [DF_EBIRUI_IDT] DEFAULT (getdate()) NOT NULL,
    [WorkflowVersionGUID]          UNIQUEIDENTIFIER NULL,
    [JoinGUID]                     UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PKEBIRegisterUserInteractions] PRIMARY KEY CLUSTERED ([EBIRegisterUserInteractionId] ASC),
    CONSTRAINT [EBIRegisterUserInteractionsEBIRegisterId] FOREIGN KEY ([EBIRegisterId]) REFERENCES [Compliance].[EBIRegister] ([EBIRegisterId]),
    CONSTRAINT [EBIRegisterUserInterationTypeId] FOREIGN KEY ([UserInteractionTypeId]) REFERENCES [Compliance].[EBIRegisterUserInteractionTypes] ([UserInteractionTypeId])
);

