﻿CREATE TABLE [Staging].[WP_Joined] (
    [JournalID]            VARCHAR (50)    NULL,
    [JournalNumber]        INT             NULL,
    [JournalDate]          DATE            NULL,
    [Reference]            VARCHAR (50)    NULL,
    [JournalLineID]        VARCHAR (50)    NULL,
    [SourceType]           VARCHAR (50)    NULL,
    [SourceId]             VARCHAR (50)    NULL,
    [AccountID]            VARCHAR (50)    NULL,
    [AccountCode]          INT             NULL,
    [AccountType]          VARCHAR (50)    NULL,
    [AccountName]          VARCHAR (MAX)   NULL,
    [Description]          VARCHAR (MAX)   NULL,
    [NetAmount]            MONEY           NULL,
    [GrossAmount]          MONEY           NULL,
    [TaxAmount]            MONEY           NULL,
    [TaxType]              VARCHAR (50)    NULL,
    [TaxName]              VARCHAR (50)    NULL,
    [Organisational]       VARCHAR (50)    NULL,
    [Projects]             VARCHAR (MAX)   NULL,
    [InvoiceID]            VARCHAR (50)    NULL,
    [Type]                 VARCHAR (50)    NULL,
    [InvoiceNumber]        VARCHAR (50)    NULL,
    [ContactID]            VARCHAR (50)    NULL,
    [ContactName]          VARCHAR (MAX)   NULL,
    [ContactFirstName]     VARCHAR (50)    NULL,
    [ContactLastName]      VARCHAR (50)    NULL,
    [Date]                 DATE            NULL,
    [DueDate]              DATE            NULL,
    [FullyPaidOnDate]      DATE            NULL,
    [ExpectedPaymentDate]  DATE            NULL,
    [PlannedPaymentDate]   DATE            NULL,
    [LineAmountTypes]      VARCHAR (50)    NULL,
    [Status]               VARCHAR (50)    NULL,
    [HasAttachments]       VARCHAR (50)    NULL,
    [SentToContact]        VARCHAR (50)    NULL,
    [BrandingThemeID]      VARCHAR (50)    NULL,
    [BrandingThemeName]    VARCHAR (50)    NULL,
    [AmountDue]            MONEY           NULL,
    [AmountPaid]           MONEY           NULL,
    [AmountCredited]       MONEY           NULL,
    [AmountPaidToDate]     MONEY           NULL,
    [AmountDueToDate]      MONEY           NULL,
    [AmountCreditedToDate] MONEY           NULL,
    [CurrencyCode]         VARCHAR (50)    NULL,
    [CurrencyRate]         DECIMAL (19, 5) NULL,
    [SubTotal]             MONEY           NULL,
    [TotalDiscount]        DECIMAL (19, 5) NULL,
    [TotalTax]             MONEY           NULL,
    [Total]                MONEY           NULL
);

