﻿CREATE TABLE [CADIS_PROC].[DC_UPMSTFX_INFO_RULE] (
    [FXRATE_ID]                      VARCHAR (16) NOT NULL,
    [DATE]                           DATETIME     NOT NULL,
    [FROM_ISO_CURRENCY_CODE__RULEID] INT          NULL,
    [TO_ISO_CURRENCY_CODE__RULEID]   INT          NULL,
    [SPOT_RATE__RULEID]              INT          NULL,
    [1_MONTH_FORWARD_RATE__RULEID]   INT          NULL,
    [2_MONTH_FORWARD_RATE__RULEID]   INT          NULL,
    [3_MONTH_FORWARD_RATE__RULEID]   INT          NULL,
    [6_MONTH_FORWARD_RATE__RULEID]   INT          NULL,
    [1_YEAR_FORWARD_RATE__RULEID]    INT          NULL,
    [DATA_QUALITY__RULEID]           INT          NULL,
    [EX_RATE_CHG_PCT__RULEID]        INT          NULL,
    PRIMARY KEY CLUSTERED ([FXRATE_ID] ASC, [DATE] ASC)
);

