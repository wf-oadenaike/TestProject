CREATE TABLE [dbo].[test_prc] (
    [EDM_SEC_ID]                INT              NOT NULL,
    [PRICE_TYPE]                VARCHAR (50)     NOT NULL,
    [PRICE_SOURCE]              VARCHAR (50)     NULL,
    [PRICE_DATE]                DATETIME         NOT NULL,
    [PRICE_TIME]                VARCHAR (50)     NULL,
    [AVERAGE_COST]              VARCHAR (20)     NULL,
    [PRICE_SOURCE_RANKING]      INT              NULL,
    [PRICE_ISO_CCY]             VARCHAR (3)      NULL,
    [MASTER_PRICE]              NUMERIC (24, 10) NULL,
    [ASK_PRICE]                 NUMERIC (24, 10) NULL,
    [MID_PRICE]                 NUMERIC (24, 10) NULL,
    [BID_PRICE]                 NUMERIC (24, 10) NULL,
    [LAST_UPDATE_DATE]          DATETIME         NULL,
    [FX_RATE]                   NUMERIC (18, 4)  NULL,
    [MARKET_VALUE]              NUMERIC (18, 2)  NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         NULL,
    [TICKER]                    VARCHAR (26)     NULL
);


GO
CREATE NONCLUSTERED INDEX [Idx_Price_type]
    ON [dbo].[test_prc]([PRICE_TYPE] ASC)
    INCLUDE([MASTER_PRICE], [PRICE_DATE]);

