CREATE TABLE [dbo].[T_BBG_IssuerSec_CTR_IN] (
    [PortfolioGroup]        VARCHAR (250)    NULL,
    [ReportDate]            DATETIME         NULL,
    [Issuer]                VARCHAR (250)    NULL,
    [Security]              VARCHAR (250)    NULL,
    [AvgWgt]                DECIMAL (38, 12) NULL,
    [CTR]                   DECIMAL (38, 12) NULL,
    [TotRtn]                DECIMAL (38, 12) NULL,
    [TotAttr]               DECIMAL (38, 12) NULL,
    [Alloc]                 DECIMAL (38, 12) NULL,
    [Selec]                 DECIMAL (38, 12) NULL,
    [Curr]                  VARCHAR (250)    NULL,
    [ID059]                 VARCHAR (250)    NULL,
    [Ticker]                VARCHAR (250)    NULL,
    [CUSIP]                 VARCHAR (250)    NULL,
    [ISIN]                  VARCHAR (250)    NULL,
    [SEDOL1]                VARCHAR (250)    NULL,
    [FILENAME]              VARCHAR (250)    NULL,
    [FileType]              VARCHAR (250)    NULL,
    [CADIS_SYSTEM_INSERTED] DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]  DATETIME         NULL
);

