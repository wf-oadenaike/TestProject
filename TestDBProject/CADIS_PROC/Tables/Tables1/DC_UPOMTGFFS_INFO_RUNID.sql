CREATE TABLE [CADIS_PROC].[DC_UPOMTGFFS_INFO_RUNID] (
    [ROW_NUMBER]              INT          NOT NULL,
    [TYPE]                    VARCHAR (20) NOT NULL,
    [FUND__RUNID]             INT          NOT NULL,
    [TRANSACTION_DATE__RUNID] INT          NOT NULL,
    [CURRENCY__RUNID]         INT          NOT NULL,
    [FUND_FLOW_TYPE__RUNID]   INT          NOT NULL,
    [FLOW_TYPE__RUNID]        INT          NOT NULL,
    [SETTLEMENT_DATE__RUNID]  INT          NOT NULL,
    [MARKET_VALUE__RUNID]     INT          NOT NULL,
    [SOURCE_TYPE__RUNID]      INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC)
);

