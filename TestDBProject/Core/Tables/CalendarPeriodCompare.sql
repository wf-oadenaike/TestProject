CREATE TABLE [Core].[CalendarPeriodCompare] (
    [CalendarId]           BIGINT NOT NULL,
    [FirstOfMinus1Month]   BIGINT NOT NULL,
    [FisrtOfMinus3Months]  BIGINT NOT NULL,
    [FisrtOfMinus6Months]  BIGINT NOT NULL,
    [FisrtOfMinus12Months] BIGINT NOT NULL,
    [Minus1Month]          BIGINT NOT NULL,
    [Minus3Months]         BIGINT NOT NULL,
    [Minus6Months]         BIGINT NOT NULL,
    [Minus12Months]        BIGINT NOT NULL,
    CONSTRAINT [XPKCalendarPeriodCompare] PRIMARY KEY CLUSTERED ([CalendarId] ASC, [FirstOfMinus1Month] ASC, [Minus1Month] ASC)
);

