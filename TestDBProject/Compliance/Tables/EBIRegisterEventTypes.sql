CREATE TABLE [Compliance].[EBIRegisterEventTypes] (
    [EBIEventTypeId]      SMALLINT      IDENTITY (1, 1) NOT NULL,
    [EBIEventTypeBK]      VARCHAR (25)  NOT NULL,
    [EBIEventDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [PKEBIRegisterEventTypes] PRIMARY KEY CLUSTERED ([EBIEventTypeBK] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IXUEBIRegisterEventTypes]
    ON [Compliance].[EBIRegisterEventTypes]([EBIEventTypeId] ASC);

