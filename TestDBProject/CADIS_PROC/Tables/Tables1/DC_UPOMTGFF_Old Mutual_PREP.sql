CREATE TABLE [CADIS_PROC].[DC_UPOMTGFF_Old Mutual_PREP] (
    [ROW_NUMBER]                INT             NOT NULL,
    [TYPE]                      VARCHAR (20)    NOT NULL,
    [FUND]                      VARCHAR (50)    NULL,
    [TRANSACTION_DATE]          DATETIME        NULL,
    [CURRENCY]                  VARCHAR (20)    NULL,
    [FUND_FLOW_TYPE]            VARCHAR (20)    NULL,
    [FLOW_TYPE]                 VARCHAR (100)   NULL,
    [SETTLEMENT_DATE]           DATETIME        NULL,
    [MARKET_VALUE]              DECIMAL (18, 2) NULL,
    [SOURCE_TYPE]               VARCHAR (20)    NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC) WITH (FILLFACTOR = 80)
);

