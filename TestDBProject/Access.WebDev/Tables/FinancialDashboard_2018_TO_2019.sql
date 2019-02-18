﻿CREATE TABLE [Access.WebDev].[FinancialDashboard_2018_TO_2019] (
    [FinancialFactId]      BIGINT         NOT NULL,
    [FiscalYear]           INT            NULL,
    [FiscalFirstDayOfYear] DATE           NULL,
    [FiscalLastDayOfYear]  DATE           NULL,
    [DepartmentNumber]     SMALLINT       NOT NULL,
    [DepartmentName]       [sysname]      NOT NULL,
    [TransactionDate]      DATETIME       NOT NULL,
    [Details]              VARCHAR (255)  NULL,
    [Amount]               MONEY          NULL,
    [Forecast]             MONEY          NULL,
    [TransactionNo]        INT            NOT NULL,
    [AccountName]          VARCHAR (128)  NULL,
    [AccountCategory]      [sysname]      NULL,
    [TransactionTypeBK]    CHAR (2)       NULL,
    [Supplier]             NVARCHAR (255) NULL,
    [NominalCode]          INT            NOT NULL,
    [FinancialLineCode]    VARCHAR (20)   NOT NULL,
    [ProjectName]          VARCHAR (255)  NULL,
    [IsDiscretionary]      INT            NOT NULL,
    [IsNonDiscretionary]   INT            NULL,
    [AmountRaw]            MONEY          NULL,
    [ControlDate]          DATETIME       NULL,
    [LastUpdatedDate]      DATETIME       NULL,
    CONSTRAINT [pk_FinancialDashboard_2018_TO_2019] PRIMARY KEY CLUSTERED ([FinancialFactId] ASC) WITH (FILLFACTOR = 80)
);

