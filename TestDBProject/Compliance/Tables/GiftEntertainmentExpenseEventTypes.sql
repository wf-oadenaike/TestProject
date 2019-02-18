CREATE TABLE [Compliance].[GiftEntertainmentExpenseEventTypes] (
    [ExpenseEventTypeId] SMALLINT     IDENTITY (1, 1) NOT NULL,
    [ExpenseEventType]   VARCHAR (50) NOT NULL,
    CONSTRAINT [PKGiftEntertainmentExpenseEventTypes] PRIMARY KEY CLUSTERED ([ExpenseEventTypeId] ASC)
);

