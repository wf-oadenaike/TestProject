﻿CREATE TABLE [CADIS_PROC].[DC_OWNTSCPS_TYPED_PREP] (
    [ID]                         INT              NOT NULL,
    [VALUATION_DATE]             DATETIME         NOT NULL,
    [SHARE_CLASS_NAME]           VARCHAR (100)    NULL,
    [ISIN]                       VARCHAR (12)     NOT NULL,
    [XD]                         VARCHAR (1)      NULL,
    [EXIT_CHARGE_PERCENT]        DECIMAL (28, 10) NULL,
    [INITIAL_CHARGE_PERCENT]     DECIMAL (28, 10) NULL,
    [MID_PRICE]                  DECIMAL (28, 10) NOT NULL,
    [PRICE_CHANGE]               DECIMAL (28, 10) NULL,
    [PRICE_MOVE_PERCENT]         DECIMAL (28, 10) NULL,
    [INITIAL_CHARGE]             DECIMAL (28, 10) NULL,
    [HISTORIC_YIELD_PERCENT]     DECIMAL (28, 10) NULL,
    [DISTRIBUTION_YIELD_PERCENT] DECIMAL (28, 10) NULL,
    [UNDERLYING_YIELD_PERCENT]   DECIMAL (28, 10) NULL,
    [EQUALISATION_RATE]          DECIMAL (28, 10) NULL,
    [UNITS_IN_ISSUE]             DECIMAL (28, 10) NOT NULL,
    [FUND_VALUE]                 DECIMAL (28, 10) NOT NULL,
    [CURRENCY]                   VARCHAR (4)      NULL,
    [CADIS_SYSTEM_INSERTED]      DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]       DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY]     NVARCHAR (50)    NOT NULL,
    [CADIS_SYSTEM_RUNID]         INT              NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]      INT              NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

