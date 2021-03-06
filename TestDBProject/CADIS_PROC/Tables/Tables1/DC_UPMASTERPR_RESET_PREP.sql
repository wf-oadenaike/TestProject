﻿CREATE TABLE [CADIS_PROC].[DC_UPMASTERPR_RESET_PREP] (
    [EDM_SEC_ID]                INT           NOT NULL,
    [PRICE_TYPE]                VARCHAR (50)  NOT NULL,
    [PRICE_SOURCE]              BIT           NULL,
    [PRICE_DATE]                DATETIME      NOT NULL,
    [PRICE_TIME]                BIT           NULL,
    [AVERAGE_COST]              BIT           NULL,
    [PRICE_SOURCE_RANKING]      BIT           NULL,
    [PRICE_ISO_CCY]             BIT           NULL,
    [MASTER_PRICE]              BIT           NULL,
    [ASK_PRICE]                 BIT           NULL,
    [MID_PRICE]                 BIT           NULL,
    [BID_PRICE]                 BIT           NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      NULL,
    [LAST_UPDATE_DATE]          BIT           NULL,
    [FX_RATE]                   BIT           NULL,
    [MARKET_VALUE]              BIT           NULL,
    [TICKER]                    BIT           NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC, [PRICE_TYPE] ASC, [PRICE_DATE] ASC) WITH (FILLFACTOR = 80)
);

