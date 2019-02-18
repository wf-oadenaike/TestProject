﻿CREATE TABLE [CADIS_PROC].[DC_OWNTEATYP_INFO_VALUE] (
    [ACCOUNT_NUMBER]             VARCHAR (255)    NOT NULL,
    [SECURITY_NUMBER]            VARCHAR (255)    NOT NULL,
    [SECURITY_DESCRIPTION]       VARCHAR (255)    NULL,
    [SEDOL]                      VARCHAR (7)      NULL,
    [CUSIP]                      VARCHAR (9)      NULL,
    [COUNTRY_OF_TAXATION]        VARCHAR (2)      NULL,
    [STATE_CODE]                 VARCHAR (255)    NULL,
    [ASSET_GROUP]                VARCHAR (255)    NULL,
    [EX_DATE_SHARES]             DECIMAL (18, 4)  NULL,
    [EX_DATE]                    DATETIME         NULL,
    [ACCRUED_INCOME]             DECIMAL (18, 4)  NULL,
    [INCOME_RECEIVED]            DECIMAL (18, 4)  NULL,
    [PRIOR_INC_ACCRUED]          DECIMAL (18, 4)  NULL,
    [INCOME_EARNED]              DECIMAL (18, 4)  NULL,
    [AMORT_ACCRUED]              DECIMAL (18, 4)  NULL,
    [AMORT_SOLD]                 DECIMAL (18, 4)  NULL,
    [PRIOR_AMORT_ACCRUED]        DECIMAL (18, 4)  NULL,
    [AMORT_EARNED]               DECIMAL (18, 4)  NULL,
    [TOTAL_INC_AND_AMORT_EARNED] DECIMAL (18, 4)  NULL,
    [UNITS]                      DECIMAL (18, 4)  NULL,
    [FUND_NET_INCOME]            DECIMAL (18, 4)  NULL,
    [RATE]                       DECIMAL (23, 15) NULL,
    [FUND_FISCAL_YEAR]           INT              NULL,
    [FUND_FISCAL_QUARTER]        INT              NULL,
    [CADIS_SYSTEM_INSERTED]      DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]       DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]     NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_RUNID]         INT              DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]      INT              DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [SECURITY_NUMBER] ASC) WITH (FILLFACTOR = 80)
);
