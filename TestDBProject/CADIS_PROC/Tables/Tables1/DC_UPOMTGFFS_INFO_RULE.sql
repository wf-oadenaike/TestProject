CREATE TABLE [CADIS_PROC].[DC_UPOMTGFFS_INFO_RULE] (
    [ROW_NUMBER]               INT          NOT NULL,
    [TYPE]                     VARCHAR (20) NOT NULL,
    [FUND__RULEID]             INT          NULL,
    [TRANSACTION_DATE__RULEID] INT          NULL,
    [CURRENCY__RULEID]         INT          NULL,
    [FUND_FLOW_TYPE__RULEID]   INT          NULL,
    [FLOW_TYPE__RULEID]        INT          NULL,
    [SETTLEMENT_DATE__RULEID]  INT          NULL,
    [MARKET_VALUE__RULEID]     INT          NULL,
    [SOURCE_TYPE__RULEID]      INT          NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC)
);

