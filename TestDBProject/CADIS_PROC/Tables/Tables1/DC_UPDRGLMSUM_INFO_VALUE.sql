CREATE TABLE [CADIS_PROC].[DC_UPDRGLMSUM_INFO_VALUE] (
    [ROW_ID]                   BIGINT        NOT NULL,
    [FUND_CODE]                VARCHAR (255) NULL,
    [RULE_ID]                  VARCHAR (255) NULL,
    [RULE_NAME]                VARCHAR (255) NULL,
    [RULE_CCY]                 VARCHAR (255) NULL,
    [SCOPE_CONTEXT]            VARCHAR (255) NULL,
    [RISK_LABEL]               VARCHAR (255) NULL,
    [RULE_LIMIT]               VARCHAR (255) NULL,
    [VALUE]                    VARCHAR (255) NULL,
    [ROOM]                     VARCHAR (255) NULL,
    [IN_VIOLATION]             VARCHAR (255) NULL,
    [EFFECTIVE_DATE]           VARCHAR (255) NULL,
    [REPORT_DATE]              VARCHAR (255) NULL,
    [CONVERTED_EFFECTIVE_DATE] INT           NULL,
    [CONVERTED_REPORT_DATE]    INT           NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]    INT           DEFAULT ((1)) NULL,
    PRIMARY KEY CLUSTERED ([ROW_ID] ASC) WITH (FILLFACTOR = 80)
);

