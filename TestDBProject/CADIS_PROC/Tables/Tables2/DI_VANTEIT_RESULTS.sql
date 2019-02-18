CREATE TABLE [CADIS_PROC].[DI_VANTEIT_RESULTS] (
    [ID]                             INT           NOT NULL,
    [Primary Key Unique?]            BIT           NULL,
    [All Tests Passed?]              BIT           NULL,
    [CADIS_SYSTEM_CHANGEDBY]         NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]          DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]           DATETIME      DEFAULT (getdate()) NULL,
    [FUND_SHORT_NAME Populated?]     BIT           NULL,
    [EDM_SEC_ID Populated?]          BIT           NULL,
    [VALUATION_DATE Populated?]      BIT           NULL,
    [EX_DATE Populated?]             BIT           NULL,
    [FUND_FISCAL_YEAR Populated?]    BIT           NULL,
    [FUND_FISCAL_QUARTER Populated?] BIT           NULL,
    [UNITS Populated?]               BIT           NULL,
    [FUND_NET_INCOME Populated?]     BIT           NULL,
    [RATE Populated?]                BIT           NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

