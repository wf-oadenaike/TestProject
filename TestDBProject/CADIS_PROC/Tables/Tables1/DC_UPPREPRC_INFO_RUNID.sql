CREATE TABLE [CADIS_PROC].[DC_UPPREPRC_INFO_RUNID] (
    [EDM_SEC_ID]                   INT          NOT NULL,
    [PRICE_TYPE]                   VARCHAR (50) NOT NULL,
    [PRICE_SOURCE__RUNID]          INT          NOT NULL,
    [PRICE_DATE]                   DATETIME     NOT NULL,
    [PRICE_TIME__RUNID]            INT          NOT NULL,
    [AVERAGE_COST__RUNID]          INT          NOT NULL,
    [PRICE_SOURCE_RANKING__RUNID]  INT          NOT NULL,
    [PRICE_ISO_CCY__RUNID]         INT          NOT NULL,
    [MASTER_PRICE__RUNID]          INT          NOT NULL,
    [ASK_PRICE__RUNID]             INT          NOT NULL,
    [MID_PRICE__RUNID]             INT          NOT NULL,
    [BID_PRICE__RUNID]             INT          NOT NULL,
    [LAST_UPDATE_DATE__RUNID]      INT          NOT NULL,
    [ISSUE_COUNTRY_ISO__RUNID]     INT          NOT NULL,
    [LAST_MASTER_EOD_PRICE__RUNID] INT          NOT NULL,
    [FX_RATE__RUNID]               INT          NOT NULL,
    [MARKET_VALUE__RUNID]          INT          NOT NULL,
    [TICKER__RUNID]                INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC, [PRICE_TYPE] ASC, [PRICE_DATE] ASC)
);

