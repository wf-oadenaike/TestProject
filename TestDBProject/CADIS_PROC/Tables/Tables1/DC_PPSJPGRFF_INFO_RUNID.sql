CREATE TABLE [CADIS_PROC].[DC_PPSJPGRFF_INFO_RUNID] (
    [ROW_NUMBER]                   INT          NOT NULL,
    [TYPE]                         VARCHAR (20) NOT NULL,
    [FUND_CODE_A__RUNID]           INT          NOT NULL,
    [FUND_CODE_B__RUNID]           INT          NOT NULL,
    [FUND_NAME__RUNID]             INT          NOT NULL,
    [STATIC_DATA__RUNID]           INT          NOT NULL,
    [TRADE_DATE__RUNID]            INT          NOT NULL,
    [CREATION_CASH_GBP__RUNID]     INT          NOT NULL,
    [CREATION_CASH_USD__RUNID]     INT          NOT NULL,
    [CREATION_CASH_EUR__RUNID]     INT          NOT NULL,
    [CANCELLATION_CASH_GBP__RUNID] INT          NOT NULL,
    [CANCELLATION_CASH_USD__RUNID] INT          NOT NULL,
    [CANCELLATION_CASH_EUR__RUNID] INT          NOT NULL,
    [SETTLE_DATE__RUNID]           INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC)
);

