﻿CREATE TABLE [dbo].[T_NT_FUND_PERFORMANCE_ATTRIBUTION] (
    [FILE_NAME]              VARCHAR (100)    NULL,
    [FILE_DATE]              DATETIME         NULL,
    [AS_AT_DATE]             DATETIME         NOT NULL,
    [SEDOL]                  VARCHAR (7)      NOT NULL,
    [SECURITY_NAME]          VARCHAR (100)    NULL,
    [PREFERRED_NAME]         VARCHAR (50)     NULL,
    [ISIN]                   VARCHAR (12)     NULL,
    [SECTOR]                 VARCHAR (50)     NULL,
    [COUNTRY]                VARCHAR (50)     NULL,
    [MATURITY_STAGE]         VARCHAR (20)     NULL,
    [MKT_CAP]                VARCHAR (20)     NULL,
    [LISTING_STATUS]         VARCHAR (20)     NULL,
    [CTR_TO_WI0001]          DECIMAL (20, 10) NULL,
    [CTR_TO_WI0002]          DECIMAL (20, 10) NULL,
    [CTR_TO_WI0003]          DECIMAL (20, 10) NULL,
    [CTR_TO_WI0004]          DECIMAL (20, 10) NULL,
    [CTR_TO_WI0005]          DECIMAL (20, 10) NULL,
    [CTR_TO_WI0006]          DECIMAL (20, 10) NULL,
    [CTR_TO_WI0007]          DECIMAL (20, 10) NULL,
    [CTR_TO_WI0013]          DECIMAL (20, 10) NULL,
    [CTR_TO_WI0014]          DECIMAL (20, 10) NULL,
    [CTR_TO_WI0018]          DECIMAL (20, 10) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([AS_AT_DATE] ASC, [SEDOL] ASC) WITH (FILLFACTOR = 80)
);

