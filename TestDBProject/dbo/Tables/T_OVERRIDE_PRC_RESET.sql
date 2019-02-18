﻿CREATE TABLE [dbo].[T_OVERRIDE_PRC_RESET] (
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
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__73CDDA38] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__74C1FE71] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF__T_OVERRID__CADIS__75B622AA] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF__T_OVERRID__CADIS__76AA46E3] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__779E6B1C] DEFAULT (getdate()) NULL,
    [LAST_UPDATE_DATE]          BIT           NULL,
    [FX_RATE]                   BIT           NULL,
    [MARKET_VALUE]              BIT           NULL,
    [TICKER]                    BIT           NULL,
    CONSTRAINT [PK__T_OVERRI__F412CC12268329E8] PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC, [PRICE_TYPE] ASC, [PRICE_DATE] ASC) WITH (FILLFACTOR = 90)
);

