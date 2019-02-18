CREATE TABLE [CADIS_PROC].[DC_UPMASTERPR_INFO_RULE] (
    [EDM_SEC_ID]                   INT          NOT NULL,
    [PRICE_TYPE]                   VARCHAR (50) NOT NULL,
    [PRICE_SOURCE__RULEID]         INT          NULL,
    [PRICE_DATE]                   DATETIME     NOT NULL,
    [PRICE_TIME__RULEID]           INT          NULL,
    [AVERAGE_COST__RULEID]         INT          NULL,
    [PRICE_SOURCE_RANKING__RULEID] INT          NULL,
    [PRICE_ISO_CCY__RULEID]        INT          NULL,
    [MASTER_PRICE__RULEID]         INT          NULL,
    [ASK_PRICE__RULEID]            INT          NULL,
    [MID_PRICE__RULEID]            INT          NULL,
    [BID_PRICE__RULEID]            INT          NULL,
    [LAST_UPDATE_DATE__RULEID]     INT          NULL,
    [FX_RATE__RULEID]              INT          NULL,
    [MARKET_VALUE__RULEID]         INT          NULL,
    [TICKER__RULEID]               INT          NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC, [PRICE_TYPE] ASC, [PRICE_DATE] ASC)
);

