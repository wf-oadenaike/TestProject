CREATE TABLE [CADIS_PROC].[DC_UPPREPRC_BPS_PRICE_PREP] (
    [FILE_NAME]            VARCHAR (50)     NULL,
    [DATE]                 DATETIME         NULL,
    [IDENTIFIER]           VARCHAR (50)     NULL,
    [PRICE_TYPE]           VARCHAR (50)     NOT NULL,
    [PRICE_SOURCE]         VARCHAR (50)     NULL,
    [PRICE_DATE]           DATETIME         NOT NULL,
    [PRICE_TIME]           VARCHAR (50)     NULL,
    [AVERAGE_COST]         VARCHAR (20)     NULL,
    [PRICE_SOURCE_RANKING] INT              NULL,
    [PRICE_ISO_CCY]        VARCHAR (3)      NULL,
    [MASTER_PRICE]         DECIMAL (24, 10) NULL,
    [ASK_PRICE]            DECIMAL (24, 10) NULL,
    [MID_PRICE]            DECIMAL (24, 10) NULL,
    [BID_PRICE]            DECIMAL (24, 10) NULL,
    [LAST_UPDATE_DATE]     DATETIME         NULL,
    [FX_RATE]              DECIMAL (18, 4)  NULL,
    [MARKET_VALUE]         DECIMAL (18, 2)  NULL,
    [TICKER]               VARCHAR (26)     NULL,
    [CADIS_SYSTEM_UPDATED] DATETIME         NULL,
    [EDM_SEC_ID]           INT              NOT NULL,
    PRIMARY KEY CLUSTERED ([PRICE_TYPE] ASC, [PRICE_DATE] ASC, [EDM_SEC_ID] ASC) WITH (FILLFACTOR = 80)
);

