CREATE TABLE [Compliance].[PADealingRequestEvents] (
    [PADealingRequestEventId]               INT              IDENTITY (1, 1) NOT NULL,
    [PADealingRequestRegisterId]            INT              NOT NULL,
    [PADealingRequestEventType]             VARCHAR (128)    NOT NULL,
    [EventPersonId]                         SMALLINT         NOT NULL,
    [EventRoleId]                           SMALLINT         NOT NULL,
    [EventTrueFalse]                        BIT              NULL,
    [EventDetails]                          VARCHAR (2048)   NULL,
    [EventDate]                             DATETIME         NULL,
    [DocumentationFolderLink]               VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]                   UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                              UNIQUEIDENTIFIER NOT NULL,
    [PADealingRequestEventCreationDate]     DATETIME         CONSTRAINT [DF_PADRE_PADRECD] DEFAULT (getdate()) NOT NULL,
    [PADealingRequestEventLastModifiedDate] DATETIME         CONSTRAINT [DF_PADRE_PADRELMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKPADealingRequestEvents] PRIMARY KEY CLUSTERED ([PADealingRequestRegisterId] ASC, [PADealingRequestEventType] ASC),
    CONSTRAINT [PADealingRequestEventsPersonId] FOREIGN KEY ([EventPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [PADealingRequestEventsRoleId] FOREIGN KEY ([EventRoleId]) REFERENCES [Core].[Roles] ([RoleId]),
    CONSTRAINT [PADealingRequestRegisterId] FOREIGN KEY ([PADealingRequestRegisterId]) REFERENCES [Compliance].[PADealingRequestRegister] ([PADealingRequestRegisterId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [XUKPADealingRequestEvents]
    ON [Compliance].[PADealingRequestEvents]([PADealingRequestEventId] ASC);

