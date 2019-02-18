CREATE TABLE [CADIS_PROC].[DC_UPDRGLMSUM_INFO_RULE] (
    [ROW_ID]                           BIGINT NOT NULL,
    [FUND_CODE__RULEID]                INT    NULL,
    [RULE_ID__RULEID]                  INT    NULL,
    [RULE_NAME__RULEID]                INT    NULL,
    [RULE_CCY__RULEID]                 INT    NULL,
    [SCOPE_CONTEXT__RULEID]            INT    NULL,
    [RISK_LABEL__RULEID]               INT    NULL,
    [RULE_LIMIT__RULEID]               INT    NULL,
    [VALUE__RULEID]                    INT    NULL,
    [ROOM__RULEID]                     INT    NULL,
    [IN_VIOLATION__RULEID]             INT    NULL,
    [EFFECTIVE_DATE__RULEID]           INT    NULL,
    [REPORT_DATE__RULEID]              INT    NULL,
    [CONVERTED_EFFECTIVE_DATE__RULEID] INT    NULL,
    [CONVERTED_REPORT_DATE__RULEID]    INT    NULL,
    PRIMARY KEY CLUSTERED ([ROW_ID] ASC) WITH (FILLFACTOR = 80)
);

