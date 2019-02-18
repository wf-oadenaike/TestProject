CREATE TABLE [CADIS_PROC].[DC_PPSJPGRFF_INFO_RULE] (
    [ROW_NUMBER]                    INT          NOT NULL,
    [TYPE]                          VARCHAR (20) NOT NULL,
    [FUND_CODE_A__RULEID]           INT          NULL,
    [FUND_CODE_B__RULEID]           INT          NULL,
    [FUND_NAME__RULEID]             INT          NULL,
    [STATIC_DATA__RULEID]           INT          NULL,
    [TRADE_DATE__RULEID]            INT          NULL,
    [CREATION_CASH_GBP__RULEID]     INT          NULL,
    [CREATION_CASH_USD__RULEID]     INT          NULL,
    [CREATION_CASH_EUR__RULEID]     INT          NULL,
    [CANCELLATION_CASH_GBP__RULEID] INT          NULL,
    [CANCELLATION_CASH_USD__RULEID] INT          NULL,
    [CANCELLATION_CASH_EUR__RULEID] INT          NULL,
    [SETTLE_DATE__RULEID]           INT          NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC)
);

