﻿CREATE TABLE [CADIS_PROC].[DC_UMLGFF_INFO_RULE] (
    [FILE_NAME__RULEID]       INT          NULL,
    [FILE_TYPE__RULEID]       INT          NULL,
    [FILE_DATE__RULEID]       INT          NULL,
    [FUND_SHORT_NAME]         VARCHAR (15) NOT NULL,
    [PORTFOLIO_NAME__RULEID]  INT          NULL,
    [CURRENCY__RULEID]        INT          NULL,
    [FUND_FLOW_TYPE__RULEID]  INT          NULL,
    [FLOW_TYPE__RULEID]       INT          NULL,
    [AMOUNT__RULEID]          INT          NULL,
    [TRADE_DATE]              DATETIME     NOT NULL,
    [VALUE_DATE__RULEID]      INT          NULL,
    [NT_ACCOUNT_CODE__RULEID] INT          NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [TRADE_DATE] ASC) WITH (FILLFACTOR = 80)
);
