﻿CREATE TABLE [CADIS_PROC].[DC_UPSJPGFF_INFO_RUNID] (
    [ROW_NUMBER__RUNID]      INT           NOT NULL,
    [TYPE__RUNID]            INT           NOT NULL,
    [FUND_SHORT_NAME]        VARCHAR (15)  NOT NULL,
    [TRANSACTION_DATE]       DATETIME      NOT NULL,
    [CURRENCY]               VARCHAR (20)  NOT NULL,
    [FUND_FLOW_TYPE]         VARCHAR (20)  NOT NULL,
    [FLOW_TYPE]              VARCHAR (100) NOT NULL,
    [SETTLEMENT_DATE__RUNID] INT           NOT NULL,
    [MARKET_VALUE__RUNID]    INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [TRANSACTION_DATE] ASC, [CURRENCY] ASC, [FUND_FLOW_TYPE] ASC, [FLOW_TYPE] ASC)
);

