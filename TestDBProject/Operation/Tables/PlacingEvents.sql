CREATE TABLE [Operation].[PlacingEvents] (
    [PlacingEventId]                   SMALLINT         IDENTITY (1, 1) NOT NULL,
    [PlacingRegisterId]                INT              NOT NULL,
    [PlacingEventType]                 VARCHAR (25)     NOT NULL,
    [EventPersonId]                    SMALLINT         NOT NULL,
    [EventDetails]                     VARCHAR (MAX)    NULL,
    [EventDate]                        DATETIME         NULL,
    [EventTrueFalse]                   BIT              NULL,
    [JoinGUID]                         UNIQUEIDENTIFIER NOT NULL,
    [PlacingEventCreationDatetime]     DATETIME         CONSTRAINT [DF_PE_PECDT] DEFAULT (getdate()) NOT NULL,
    [PlacingEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PE_PELMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]            DATETIME         CONSTRAINT [DF_PE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]             DATETIME         CONSTRAINT [DF_PE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]           NVARCHAR (50)    CONSTRAINT [DF_PE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]            INT              CONSTRAINT [DF_PE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]           ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]        DATETIME         CONSTRAINT [DF_PE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKPlacingEvents] PRIMARY KEY CLUSTERED ([PlacingEventId] ASC),
    CONSTRAINT [PlacingEventsPersonId] FOREIGN KEY ([EventPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [PlacingEventsRegisterId] FOREIGN KEY ([PlacingRegisterId]) REFERENCES [Operation].[PlacingsRegister] ([PlacingRegisterId])
);

