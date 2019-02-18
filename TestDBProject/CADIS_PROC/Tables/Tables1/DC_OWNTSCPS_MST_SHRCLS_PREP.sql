CREATE TABLE [CADIS_PROC].[DC_OWNTSCPS_MST_SHRCLS_PREP] (
    [EDM_SHARECLASS_ID]         INT           NOT NULL,
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
    [CADIS_SYSTEM_INSERTED]     DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      NULL
);

