CREATE TABLE [Organisation].[BrokerRestrictions] (
    [BrokerRestrictionId]                   INT              IDENTITY (1, 1) NOT NULL,
    [BloombergId]                           VARCHAR (25)     NOT NULL,
    [RequestedByPersonId]                   SMALLINT         NOT NULL,
    [AddedByPersonId]                       SMALLINT         NULL,
    [RequestedDate]                         DATE             NOT NULL,
    [RestrictionReason]                     VARCHAR (MAX)    NOT NULL,
    [RestrictionActive]                     BIT              NULL,
    [RestrictionStartDate]                  DATE             NULL,
    [RestrictionEndDate]                    DATE             NULL,
    [RemovalRequestedByPersonId]            SMALLINT         NULL,
    [RemovedByPersonId]                     SMALLINT         NULL,
    [EndRestrictionReason]                  VARCHAR (MAX)    NULL,
    [JoinGUID]                              UNIQUEIDENTIFIER NOT NULL,
    [BrokerRestrictionCreationDatetime]     DATETIME         CONSTRAINT [DF_BR_BRCDT] DEFAULT (getdate()) NOT NULL,
    [BrokerRestrictionLastModifiedDatetime] DATETIME         CONSTRAINT [DF_BR_BRLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKBrokerRestrictions] PRIMARY KEY CLUSTERED ([BrokerRestrictionId] ASC),
    CONSTRAINT [BrokerRestrictionsAddedByPersonId] FOREIGN KEY ([AddedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [BrokerRestrictionsRemovalRequestedByPersonId] FOREIGN KEY ([RemovalRequestedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [BrokerRestrictionsRemovedByPersonId] FOREIGN KEY ([RemovedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [BrokerRestrictionsRequestedByPersonId] FOREIGN KEY ([RequestedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

