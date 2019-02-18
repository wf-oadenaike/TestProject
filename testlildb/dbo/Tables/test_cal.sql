﻿CREATE TABLE [dbo].[test_cal] (
    [CalendarId]              INT          NOT NULL,
    [CalendarDate]            DATETIME     NOT NULL,
    [FullDateUK]              CHAR (10)    NULL,
    [FullDateUSA]             CHAR (10)    NULL,
    [CalDayOfMonth]           TINYINT      NULL,
    [CalDaySuffix]            VARCHAR (4)  NULL,
    [CalDayName]              VARCHAR (9)  NULL,
    [DayOfWeekUSA]            TINYINT      NULL,
    [DayOfWeekUK]             TINYINT      NULL,
    [DayOfWeekInMonth]        TINYINT      NULL,
    [DayOfWeekInYear]         TINYINT      NULL,
    [DayOfQuarter]            TINYINT      NULL,
    [CalDayOfYear]            SMALLINT     NULL,
    [CalWeekOfMonth]          TINYINT      NULL,
    [CalWeekOfQuarter]        TINYINT      NULL,
    [CalWeekOfYear]           TINYINT      NULL,
    [CalMonth]                TINYINT      NULL,
    [CalMonthName]            VARCHAR (9)  NULL,
    [CalMonthOfQuarter]       TINYINT      NULL,
    [CalQuarter]              TINYINT      NULL,
    [CalQuarterName]          VARCHAR (9)  NULL,
    [CalYear]                 SMALLINT     NULL,
    [CalYearName]             CHAR (7)     NULL,
    [CalMonthYear]            CHAR (10)    NULL,
    [CalMMYYYY]               CHAR (6)     NULL,
    [FirstDayOfMonth]         DATE         NULL,
    [LastDayOfMonth]          DATE         NULL,
    [FirstDayOfQuarter]       DATE         NULL,
    [LastDayOfQuarter]        DATE         NULL,
    [FirstDayOfYear]          DATE         NULL,
    [LastDayOfYear]           DATE         NULL,
    [IsHolidayUSA]            BIT          NULL,
    [IsWeekday]               BIT          NULL,
    [HolidayUSA]              VARCHAR (50) NULL,
    [IsHolidayUK]             BIT          NULL,
    [HolidayUK]               VARCHAR (50) NULL,
    [FiscalDayOfYear]         SMALLINT     NULL,
    [FiscalWeekOfYear]        TINYINT      NULL,
    [FiscalMonth]             TINYINT      NULL,
    [FiscalQuarter]           TINYINT      NULL,
    [FiscalQuarterName]       VARCHAR (9)  NULL,
    [FiscalYear]              INT          NULL,
    [FiscalYearName]          VARCHAR (11) NULL,
    [FiscalMonthYear]         CHAR (12)    NULL,
    [FiscalMMYYYY]            CHAR (10)    NULL,
    [FiscalFirstDayOfMonth]   DATE         NULL,
    [FiscalLastDayOfMonth]    DATE         NULL,
    [FiscalFirstDayOfQuarter] DATE         NULL,
    [FiscalLastDayOfQuarter]  DATE         NULL,
    [FiscalFirstDayOfYear]    DATE         NULL,
    [FiscalLastDayOfYear]     DATE         NULL,
    [FiscalYYYYMM]            INT          NULL,
    [CalYYYYMM]               INT          NULL
);

