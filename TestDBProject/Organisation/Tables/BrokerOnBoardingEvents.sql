CREATE TABLE [Organisation].[BrokerOnBoardingEvents] (
    [BrokerOnBoardingEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [BrokerOnBoardingRegisterId]                INT              NOT NULL,
    [BrokerOnBoardingEventTypeId]               SMALLINT         NOT NULL,
    [ReviewCollection]                          INT              NOT NULL,
    [PersonId]                                  SMALLINT         NOT NULL,
    [RoleId]                                    SMALLINT         NOT NULL,
    [DepartmentId]                              SMALLINT         NOT NULL,
    [EventDetails]                              VARCHAR (2048)   NULL,
    [EventDate]                                 DATETIME         NULL,
    [EventTrueFalse]                            BIT              NULL,
    [DocumentationFolderLink]                   VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]                       UNIQUEIDENTIFIER NULL,
    [JoinGUID]                                  UNIQUEIDENTIFIER NULL,
    [BrokerOnBoardingEventCreationDatetime]     DATETIME         CONSTRAINT [DF_BOBE_BOBCDT] DEFAULT (getdate()) NOT NULL,
    [BrokerOnBoardingEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_BOBE_BOBLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKBrokerOnBoardingEvents] PRIMARY KEY CLUSTERED ([BrokerOnBoardingEventId] ASC),
    CONSTRAINT [BrokerOnBoardingEventsBrokerOnBoardingRegisterId] FOREIGN KEY ([BrokerOnBoardingRegisterId]) REFERENCES [Organisation].[BrokerOnBoardingRegister] ([BrokerOnBoardingRegisterId]),
    CONSTRAINT [BrokerOnBoardingEventsDepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId]),
    CONSTRAINT [BrokerOnBoardingEventsEventTypeId] FOREIGN KEY ([BrokerOnBoardingEventTypeId]) REFERENCES [Organisation].[BrokerOnBoardingEventTypes] ([BrokerOnBoardingEventTypeId]),
    CONSTRAINT [BrokerOnBoardingEventsPersonId] FOREIGN KEY ([PersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [BrokerOnBoardingEventsRoleId] FOREIGN KEY ([RoleId]) REFERENCES [Core].[Roles] ([RoleId])
);

