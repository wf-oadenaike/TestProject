﻿CREATE TABLE [dbo].[outputtable] (
    [FinancialFactId]      BIGINT         NULL,
    [FiscalYear]           INT            NULL,
    [FiscalFirstDayOfYear] DATE           NULL,
    [FiscalLastDayOfYear]  DATE           NULL,
    [DepartmentNumber]     SMALLINT       NULL,
    [DepartmentName]       VARCHAR (128)  NULL,
    [TransactionDate]      DATETIME       NULL,
    [Details]              VARCHAR (255)  NULL,
    [Amount]               MONEY          NULL,
    [Forecast]             MONEY          NULL,
    [TransactionNo]        INT            NULL,
    [AccountName]          VARCHAR (128)  NULL,
    [AccountCategory]      NVARCHAR (128) NULL,
    [TransactionTypeBK]    CHAR (2)       NULL,
    [Supplier]             NVARCHAR (255) NULL,
    [NominalCode]          INT            NULL,
    [FinancialLineCode]    VARCHAR (20)   NULL,
    [ProjectName]          VARCHAR (255)  NULL,
    [IsDiscretionary]      INT            NULL,
    [IsNonDiscretionary]   INT            NULL,
    [AmountRaw]            MONEY          NULL,
    [ControlDate]          DATETIME       NULL,
    [LastUpdatedDate]      DATETIME       NULL
);
