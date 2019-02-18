CREATE TABLE [CADIS_PROC].[DC_UPDRGLMSUM_INFO_RUNID] (
    [ROW_ID]                          BIGINT NOT NULL,
    [FUND_CODE__RUNID]                INT    NOT NULL,
    [RULE_ID__RUNID]                  INT    NOT NULL,
    [RULE_NAME__RUNID]                INT    NOT NULL,
    [RULE_CCY__RUNID]                 INT    NOT NULL,
    [SCOPE_CONTEXT__RUNID]            INT    NOT NULL,
    [RISK_LABEL__RUNID]               INT    NOT NULL,
    [RULE_LIMIT__RUNID]               INT    NOT NULL,
    [VALUE__RUNID]                    INT    NOT NULL,
    [ROOM__RUNID]                     INT    NOT NULL,
    [IN_VIOLATION__RUNID]             INT    NOT NULL,
    [EFFECTIVE_DATE__RUNID]           INT    NOT NULL,
    [REPORT_DATE__RUNID]              INT    NOT NULL,
    [CONVERTED_EFFECTIVE_DATE__RUNID] INT    NOT NULL,
    [CONVERTED_REPORT_DATE__RUNID]    INT    NOT NULL,
    PRIMARY KEY CLUSTERED ([ROW_ID] ASC) WITH (FILLFACTOR = 80)
);

