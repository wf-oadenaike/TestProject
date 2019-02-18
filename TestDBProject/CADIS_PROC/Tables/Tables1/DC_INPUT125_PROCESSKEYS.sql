﻿CREATE TABLE [CADIS_PROC].[DC_INPUT125_PROCESSKEYS] (
    [VALUATION_POINT_DATE] DATETIME     NOT NULL,
    [EXTERNAL_FUND_CODE]   VARCHAR (50) NOT NULL,
    [FUND_REFERENCE]       VARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([VALUATION_POINT_DATE] ASC, [EXTERNAL_FUND_CODE] ASC, [FUND_REFERENCE] ASC)
);

