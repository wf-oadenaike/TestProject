﻿CREATE TABLE [CADIS_PROC].[DC_UPNTDVDIRR_EIARPT_STK_PREP] (
    [CUR_DATE]               DATE          NOT NULL,
    [DATE]                   DATETIME      NULL,
    [ACCOUNT_NUMBER]         VARCHAR (50)  NOT NULL,
    [SEC_DESCRIPTION]        VARCHAR (50)  NOT NULL,
    [CUSIP]                  VARCHAR (20)  NULL,
    [SEDOL]                  VARCHAR (20)  NULL,
    [CTRY_OF_TAXATION]       VARCHAR (5)   NULL,
    [TOTAL_INC_AMORT_EARNED] VARCHAR (100) NULL,
    [UNITS]                  VARCHAR (100) NULL,
    [FUND_NET_INCOME]        VARCHAR (100) NULL,
    [RATE]                   VARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([CUR_DATE] ASC, [ACCOUNT_NUMBER] ASC, [SEC_DESCRIPTION] ASC) WITH (FILLFACTOR = 80)
);

