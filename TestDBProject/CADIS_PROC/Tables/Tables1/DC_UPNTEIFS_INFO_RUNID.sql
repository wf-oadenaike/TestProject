﻿CREATE TABLE [CADIS_PROC].[DC_UPNTEIFS_INFO_RUNID] (
    [FUND_SHORT_NAME]        VARCHAR (20) NOT NULL,
    [VALUATION_DATE]         DATETIME     NOT NULL,
    [UNITS__RUNID]           INT          NOT NULL,
    [FUND_NET_INCOME__RUNID] INT          NOT NULL,
    [RATE__RUNID]            INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [VALUATION_DATE] ASC) WITH (FILLFACTOR = 80)
);

