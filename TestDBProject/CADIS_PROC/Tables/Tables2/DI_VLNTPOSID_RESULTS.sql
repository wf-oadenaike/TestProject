CREATE TABLE [CADIS_PROC].[DI_VLNTPOSID_RESULTS] (
    [Valid Sedol?]                   BIT           NULL,
    [Valid ISIN?]                    BIT           NULL,
    [TRADE_DATE Populated?]          BIT           NULL,
    [POSITION Populated?]            BIT           NULL,
    [ACCOUNT Populated?]             BIT           NULL,
    [PRICE Populated?]               BIT           NULL,
    [UNIQUE_BLOOMBERG_ID Populated?] BIT           NULL,
    [ROW_NUMBER]                     INT           NOT NULL,
    [CADIS_SYSTEM_CHANGEDBY]         NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]          DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]           DATETIME      DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC)
);

