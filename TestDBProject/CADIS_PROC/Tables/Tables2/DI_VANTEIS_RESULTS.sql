CREATE TABLE [CADIS_PROC].[DI_VANTEIS_RESULTS] (
    [Primary Key Unique?]             BIT           NULL,
    [Fund Short Name Mapping Exists?] BIT           NULL,
    [EDM_SEC_ID Mapping Exists?]      BIT           NULL,
    [ID]                              INT           NOT NULL,
    [FUND_FISCAL_YEAR Populated?]     BIT           NULL,
    [FUND_FISCAL_QUARTER Populated?]  BIT           NULL,
    [All Tests Passed?]               BIT           NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

