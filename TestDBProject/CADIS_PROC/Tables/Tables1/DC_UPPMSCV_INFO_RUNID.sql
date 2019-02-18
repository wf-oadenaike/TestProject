﻿CREATE TABLE [CADIS_PROC].[DC_UPPMSCV_INFO_RUNID] (
    [EDM_SHARECLASS_ID]                 INT      NOT NULL,
    [VALUATION_DATE]                    DATETIME NOT NULL,
    [EXIT_CHARGE_PERCENT__RUNID]        INT      NOT NULL,
    [INITIAL_CHARGE_PERCENT__RUNID]     INT      NOT NULL,
    [MID_PRICE__RUNID]                  INT      NOT NULL,
    [PRICE_CHANGE__RUNID]               INT      NOT NULL,
    [PRICE_MOVE_PERCENT__RUNID]         INT      NOT NULL,
    [INITIAL_CHARGE__RUNID]             INT      NOT NULL,
    [HISTORIC_YIELD_PERCENT__RUNID]     INT      NOT NULL,
    [DISTRIBUTION_YIELD_PERCENT__RUNID] INT      NOT NULL,
    [UNDERLYING_YIELD_PERCENT__RUNID]   INT      NOT NULL,
    [EQUALISATION_RATE__RUNID]          INT      NOT NULL,
    [UNITS_IN_ISSUE__RUNID]             INT      NOT NULL,
    [FUND_VALUE__RUNID]                 INT      NOT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SHARECLASS_ID] ASC, [VALUATION_DATE] ASC) WITH (FILLFACTOR = 80)
);

