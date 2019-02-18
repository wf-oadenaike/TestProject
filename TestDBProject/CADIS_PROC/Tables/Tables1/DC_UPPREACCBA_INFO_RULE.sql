﻿CREATE TABLE [CADIS_PROC].[DC_UPPREACCBA_INFO_RULE] (
    [FUND_SHORT_NAME]     VARCHAR (15)  NOT NULL,
    [POSITION_DATE]       DATETIME      NOT NULL,
    [ASSET_SUB_CATEGORY]  VARCHAR (100) NOT NULL,
    [CCY]                 VARCHAR (3)   NOT NULL,
    [LOCAL_VALUE__RULEID] INT           NULL,
    [BASE_VALUE__RULEID]  INT           NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [POSITION_DATE] ASC, [ASSET_SUB_CATEGORY] ASC, [CCY] ASC)
);

