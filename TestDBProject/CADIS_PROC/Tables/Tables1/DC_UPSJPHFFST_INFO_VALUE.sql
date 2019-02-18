CREATE TABLE [CADIS_PROC].[DC_UPSJPHFFST_INFO_VALUE] (
    [ROW_NUMBER]                INT             NOT NULL,
    [TYPE]                      VARCHAR (20)    NOT NULL,
    [FUND]                      VARCHAR (50)    NULL,
    [TRANSACTION_DATE]          DATETIME        NULL,
    [FUND_FLOW_TYPE]            VARCHAR (20)    NULL,
    [FLOW_TYPE]                 VARCHAR (100)   NULL,
    [SETTLEMENT_DATE]           DATETIME        NULL,
    [MARKET_VALUE]              DECIMAL (18, 2) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC)
);

