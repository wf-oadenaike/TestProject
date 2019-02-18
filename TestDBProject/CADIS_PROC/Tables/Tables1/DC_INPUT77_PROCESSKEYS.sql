﻿CREATE TABLE [CADIS_PROC].[DC_INPUT77_PROCESSKEYS] (
    [ACCOUNT_NUMBER]      VARCHAR (20)  NOT NULL,
    [VALUATION_DATE]      DATETIME      NOT NULL,
    [ASSET_SUB_CATEGORY]  VARCHAR (100) NOT NULL,
    [LOCAL_CURRENCY_CODE] VARCHAR (3)   NOT NULL,
    PRIMARY KEY CLUSTERED ([ACCOUNT_NUMBER] ASC, [VALUATION_DATE] ASC, [ASSET_SUB_CATEGORY] ASC, [LOCAL_CURRENCY_CODE] ASC)
);
