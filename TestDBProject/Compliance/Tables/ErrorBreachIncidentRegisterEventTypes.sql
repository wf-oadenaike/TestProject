CREATE TABLE [Compliance].[ErrorBreachIncidentRegisterEventTypes] (
    [EBIEventTypeId]      SMALLINT      IDENTITY (1, 1) NOT NULL,
    [EBIEventTypeBK]      VARCHAR (25)  NOT NULL,
    [EBIEventDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [XPKErrorBreachIncidentRegisterEventTypes] PRIMARY KEY CLUSTERED ([EBIEventTypeBK] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IXUErrorBreachIncidentRegisterEventTypes]
    ON [Compliance].[ErrorBreachIncidentRegisterEventTypes]([EBIEventTypeId] ASC);

