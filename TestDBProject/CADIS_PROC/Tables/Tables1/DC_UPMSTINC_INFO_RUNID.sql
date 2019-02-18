﻿CREATE TABLE [CADIS_PROC].[DC_UPMSTINC_INFO_RUNID] (
    [FUND_SHORT_NAME]        VARCHAR (50) NOT NULL,
    [EDM_SEC_ID]             INT          NOT NULL,
    [FUND_FISCAL_YEAR]       INT          NOT NULL,
    [FUND_FISCAL_QUARTER]    INT          NOT NULL,
    [DVD_CCY__RUNID]         INT          NOT NULL,
    [WITHHOLDING_TAX__RUNID] INT          NOT NULL,
    [DECLARED_DATE__RUNID]   INT          NOT NULL,
    [POSITION_DATE__RUNID]   INT          NOT NULL,
    [POSITION__RUNID]        INT          NOT NULL,
    [BID_PRICE__RUNID]       INT          NOT NULL,
    [SPOT_RATE__RUNID]       INT          NOT NULL,
    [MARKET_VALUE__RUNID]    INT          NOT NULL,
    [EX_DATE__RUNID]         INT          NOT NULL,
    [RATE__RUNID]            INT          NOT NULL,
    [NET_INCOME__RUNID]      INT          NOT NULL,
    [TO_PAY__RUNID]          INT          NOT NULL,
    [NOTES__RUNID]           INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [EDM_SEC_ID] ASC, [FUND_FISCAL_YEAR] ASC, [FUND_FISCAL_QUARTER] ASC) WITH (FILLFACTOR = 80)
);

