﻿CREATE TABLE [dbo].[T_BBG_IssuerSec_CTR] (
    [EDM_SEC_ID]             BIGINT           NULL,
    [PortfolioGroup]         VARCHAR (250)    NULL,
    [ReportDate]             DATETIME         NULL,
    [Issuer]                 VARCHAR (250)    NULL,
    [Security]               VARCHAR (250)    NULL,
    [AvgWgt]                 DECIMAL (38, 12) NULL,
    [CTR]                    DECIMAL (38, 12) NULL,
    [TotRtn]                 DECIMAL (38, 12) NULL,
    [TotAttr]                DECIMAL (38, 12) NULL,
    [Alloc]                  DECIMAL (38, 12) NULL,
    [Selec]                  DECIMAL (38, 12) NULL,
    [Curr]                   VARCHAR (250)    NULL,
    [ID059]                  VARCHAR (250)    NOT NULL,
    [Ticker]                 VARCHAR (250)    NULL,
    [CUSIP]                  VARCHAR (250)    NULL,
    [ISIN]                   VARCHAR (250)    NULL,
    [SEDOL1]                 VARCHAR (250)    NULL,
    [FILENAME]               VARCHAR (250)    NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_RUNID]     INT              DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]  INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ISSUER] PRIMARY KEY CLUSTERED ([ID059] ASC) WITH (FILLFACTOR = 80)
);
