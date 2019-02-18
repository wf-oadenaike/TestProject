CREATE TABLE [CADIS_PROC].[DC_UPDSCOPE_INFO_RULE] (
    [ROW_ID]                           BIGINT NOT NULL,
    [FUND_CODE__RULEID]                INT    NULL,
    [RULE_ID__RULEID]                  INT    NULL,
    [TICKER__RULEID]                   INT    NULL,
    [IDENTIFIER__RULEID]               INT    NULL,
    [QUANTITY__RULEID]                 INT    NULL,
    [PRICE__RULEID]                    INT    NULL,
    [SECURITY_CURRENCY__RULEID]        INT    NULL,
    [MARKET_VALUE__RULEID]             INT    NULL,
    [ATTRIBUTE_1__RULEID]              INT    NULL,
    [ATTRIBUTE_2__RULEID]              INT    NULL,
    [IN_VIOLATION__RULEID]             INT    NULL,
    [EFFECTIVE_DATE__RULEID]           INT    NULL,
    [REPORT_DATE__RULEID]              INT    NULL,
    [IS_SUBTITLE__RULEID]              INT    NULL,
    [CONVERTED_EFFECTIVE_DATE__RULEID] INT    NULL,
    [CONVERTED_REPORT_DATE__RULEID]    INT    NULL,
    PRIMARY KEY CLUSTERED ([ROW_ID] ASC) WITH (FILLFACTOR = 80)
);

