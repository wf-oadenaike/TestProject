﻿CREATE TABLE [Staging].[ExpenseSrc] (
    [Id]                        VARCHAR (512)   NULL,
    [IsDeleted]                 VARCHAR (512)   NULL,
    [Name]                      VARCHAR (512)   NULL,
    [CurrencyIsoCode]           VARCHAR (5)     NULL,
    [CreatedDate]               DATETIME        NULL,
    [CreatedById]               VARCHAR (512)   NULL,
    [LastModifiedDate]          DATETIME        NULL,
    [LastModifiedById]          VARCHAR (512)   NULL,
    [Contact]                   VARCHAR (512)   NULL,
    [Amount]                    NUMERIC (19, 2) NULL,
    [Category]                  VARCHAR (512)   NULL,
    [Current_Year]              VARCHAR (512)   NULL,
    [Date_Incurred]             DATETIME        NULL,
    [Description]               VARCHAR (MAX)   NULL,
    [Created_by_ETL]            VARCHAR (512)   NULL,
    [Reportable]                VARCHAR (512)   NULL,
    [Expense_Relates_To]        VARCHAR (512)   NULL,
    [Given_Received]            VARCHAR (512)   NULL,
    [Gift_Entertainment2]       VARCHAR (512)   NULL,
    [Approved]                  VARCHAR (512)   NULL,
    [search_hash]               VARCHAR (512)   NULL,
    [Exchange_Rate]             VARCHAR (512)   NULL,
    [Reporting_Value_Converted] VARCHAR (512)   NULL,
    [Compliance_Comments]       VARCHAR (MAX)   NULL,
    [Approved_By]               VARCHAR (512)   NULL,
    [Approved_YesNo]            VARCHAR (512)   NULL,
    [OwnerId]                   VARCHAR (512)   NULL,
    [LastName]                  VARCHAR (512)   NULL,
    [FirstName]                 VARCHAR (512)   NULL,
    [Title]                     VARCHAR (512)   NULL,
    [Salutation]                VARCHAR (512)   NULL,
    [Account_Name_Lookthrough]  VARCHAR (512)   NULL
);
