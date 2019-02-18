CREATE TABLE [Compliance].[GiftEntertainmentExpenseEvents] (
    [ExpenseEventId]               INT              IDENTITY (1, 1) NOT NULL,
    [ExpenseId]                    INT              NOT NULL,
    [ExpenseEventTypeId]           SMALLINT         NOT NULL,
    [RecordedByPersonId]           SMALLINT         NOT NULL,
    [EventTrueFalse]               BIT              NULL,
    [EventDetails]                 VARCHAR (2048)   NULL,
    [EventDate]                    DATETIME         NULL,
    [DocumentationFolderLink]      VARCHAR (2000)   NULL,
    [JoinGUID]                     UNIQUEIDENTIFIER NOT NULL,
    [ExpenseEventCreationDate]     DATETIME         CONSTRAINT [DF_GEEE_CDT] DEFAULT (getdate()) NOT NULL,
    [ExpenseEventLastModifiedDate] DATETIME         CONSTRAINT [DF_GEEE_LMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKGiftEntertainmentExpenseEvents] PRIMARY KEY CLUSTERED ([ExpenseEventId] ASC),
    CONSTRAINT [GiftEntertainmentExpenseEventsEventTypeId] FOREIGN KEY ([ExpenseEventTypeId]) REFERENCES [Compliance].[GiftEntertainmentExpenseEventTypes] ([ExpenseEventTypeId]),
    CONSTRAINT [GiftEntertainmentExpenseEventsExpenseId] FOREIGN KEY ([ExpenseId]) REFERENCES [Compliance].[GiftEntertainmentExpenses] ([ExpenseId]),
    CONSTRAINT [GiftEntertainmentExpenseEventsPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

