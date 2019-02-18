CREATE TABLE [Core].[CalendarMonthPeriodCompare] (
    [CalMMYYYY]    INT NOT NULL,
    [Minus1Month]  INT NOT NULL,
    [Minus3Month]  INT NOT NULL,
    [Minus6Month]  INT NOT NULL,
    [Minus12Month] INT NOT NULL,
    CONSTRAINT [XPKCalendarMonthPeriodCompare] PRIMARY KEY CLUSTERED ([CalMMYYYY] ASC)
);

