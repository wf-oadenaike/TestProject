﻿CREATE TABLE [dbo].[T_MASTER_SHARECLASS] (
    [EDM_SHARECLASS_ID]         INT           IDENTITY (1, 1) NOT NULL,
    [SHARECLASS]                VARCHAR (255) NOT NULL,
    [DESCRIPTION]               VARCHAR (511) NOT NULL,
    [FUND_SHORT_NAME]           VARCHAR (20)  NOT NULL,
    [ISIN]                      VARCHAR (12)  NULL,
    [SEDOL]                     VARCHAR (7)   NULL,
    [TICKER]                    VARCHAR (31)  NULL,
    [UNIQUE_BLOOMBERG_ID]       VARCHAR (31)  NULL,
    [SHARECLASS_CURRENCY]       VARCHAR (3)   NULL,
    [INCEPTION_DATE]            DATE          NULL,
    [IS_ACCUMULATION]           BIT           NULL,
    [IS_INCOME]                 BIT           NULL,
    [IS_ACTIVE]                 BIT           NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([EDM_SHARECLASS_ID] ASC) WITH (FILLFACTOR = 80)
);

