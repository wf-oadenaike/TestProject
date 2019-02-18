CREATE TABLE [CADIS_PROC].[DC_UPDSCOPE_INFO_RUNID] (
    [ROW_ID]                          BIGINT NOT NULL,
    [FUND_CODE__RUNID]                INT    NOT NULL,
    [RULE_ID__RUNID]                  INT    NOT NULL,
    [TICKER__RUNID]                   INT    NOT NULL,
    [IDENTIFIER__RUNID]               INT    NOT NULL,
    [QUANTITY__RUNID]                 INT    NOT NULL,
    [PRICE__RUNID]                    INT    NOT NULL,
    [SECURITY_CURRENCY__RUNID]        INT    NOT NULL,
    [MARKET_VALUE__RUNID]             INT    NOT NULL,
    [ATTRIBUTE_1__RUNID]              INT    NOT NULL,
    [ATTRIBUTE_2__RUNID]              INT    NOT NULL,
    [IN_VIOLATION__RUNID]             INT    NOT NULL,
    [EFFECTIVE_DATE__RUNID]           INT    NOT NULL,
    [REPORT_DATE__RUNID]              INT    NOT NULL,
    [IS_SUBTITLE__RUNID]              INT    NOT NULL,
    [CONVERTED_EFFECTIVE_DATE__RUNID] INT    NOT NULL,
    [CONVERTED_REPORT_DATE__RUNID]    INT    NOT NULL,
    PRIMARY KEY CLUSTERED ([ROW_ID] ASC) WITH (FILLFACTOR = 80)
);

