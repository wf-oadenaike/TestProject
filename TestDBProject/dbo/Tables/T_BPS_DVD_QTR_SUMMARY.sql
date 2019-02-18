﻿CREATE TABLE [dbo].[T_BPS_DVD_QTR_SUMMARY] (
    [FUND_SHORT_NAME]        VARCHAR (20)    NOT NULL,
    [INCOME_PERIOD_QTR]      INT             NOT NULL,
    [INCOME_PERIOD_YR]       INT             NOT NULL,
    [AS_AT_DATE]             DATETIME        NOT NULL,
    [GROSS_DVD_VAL]          DECIMAL (38, 6) NULL,
    [NET_DVD_VAL]            DECIMAL (38, 6) NULL,
    [UNITS]                  DECIMAL (38, 6) NULL,
    [GROSS_DVD_VAL_ORIG]     DECIMAL (38, 6) NOT NULL,
    [NET_DVD_VAL_ORIG]       DECIMAL (38, 6) NULL,
    [UNITS_ORIG]             DECIMAL (38, 6) NULL,
    [DVD_RATE]               DECIMAL (38, 6) NULL,
    [FUND_DVD_RATE_PER_YEAR] DECIMAL (38, 6) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [INCOME_PERIOD_QTR] ASC, [INCOME_PERIOD_YR] ASC, [AS_AT_DATE] ASC) WITH (FILLFACTOR = 80)
);
