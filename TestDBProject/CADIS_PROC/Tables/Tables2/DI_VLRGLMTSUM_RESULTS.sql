CREATE TABLE [CADIS_PROC].[DI_VLRGLMTSUM_RESULTS] (
    [ROW_ID]                      BIGINT        NOT NULL,
    [Is Valid EFFECTIVE_DATE?]    BIT           NULL,
    [Is Valid REPORT_DATE?]       BIT           NULL,
    [Is FUND_CODE NOT NULL?]      BIT           NULL,
    [Is RULE_ID NOT NULL?]        BIT           NULL,
    [Is Valid RULE_NAME?]         BIT           NULL,
    [Is Valid RULE_CCY?]          BIT           NULL,
    [Is RULE_LIMIT not null?]     BIT           NULL,
    [Is VALUE Not Null?]          BIT           NULL,
    [Is ROOM Not Null?]           BIT           NULL,
    [Is IN_VIOLATION Flag Valid?] BIT           NULL,
    [All Tests Passed?]           BIT           NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ROW_ID] ASC) WITH (FILLFACTOR = 80)
);

