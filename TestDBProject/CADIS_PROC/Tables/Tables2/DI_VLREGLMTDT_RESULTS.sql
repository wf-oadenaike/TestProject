CREATE TABLE [CADIS_PROC].[DI_VLREGLMTDT_RESULTS] (
    [ROW_ID]                                 BIGINT        NOT NULL,
    [Is Valid EFFECTIVE_DATE?]               BIT           NULL,
    [Is Valid REPORT_DATE ?]                 BIT           NULL,
    [Is FUND_CODE NOT NULL?]                 BIT           NULL,
    [Is RULE_ID NOT NULL?]                   BIT           NULL,
    [Is TICKER NOT NULL?]                    BIT           NULL,
    [Is IDENTIFIER NOT NULL?]                BIT           NULL,
    [Is QUANTITY Valid?]                     BIT           NULL,
    [Is PRICE Valid?]                        BIT           NULL,
    [Is IN_VIOLATION flag Valid?]            BIT           NULL,
    [Is CONVERTED_EFFECTIVE_DATE Valid int?] BIT           NULL,
    [Is CONVERTED_REPORT_DATE Valid int?]    BIT           NULL,
    [All Tests Passed?]                      BIT           NULL,
    [CADIS_SYSTEM_CHANGEDBY]                 NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]                  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                   DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ROW_ID] ASC) WITH (FILLFACTOR = 80)
);

