CREATE TABLE [CADIS_PROC].[DI_VLNTPOSID_PRELIM_RESULTS] (
    [Valid Sedol?]                           BIT            NULL,
    [Valid ISIN?]                            BIT            NULL,
    [TRADE_DATE Populated?]                  BIT            NULL,
    [POSITION Populated?]                    BIT            NULL,
    [ACCOUNT Populated?]                     BIT            NULL,
    [PRICE Populated?]                       BIT            NULL,
    [UNIQUE_BLOOMBERG_ID Populated?]         BIT            NULL,
    [ROW_NUMBER]                             INT            NOT NULL,
    [CADIS_SYSTEM_CHANGEDBY]                 NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_INSERTED]                  DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                   DATETIME       DEFAULT (getdate()) NULL,
    [Valid Sedol?__RULEID]                   INT            DEFAULT ((0)) NOT NULL,
    [Valid ISIN?__RULEID]                    INT            DEFAULT ((0)) NOT NULL,
    [TRADE_DATE Populated?__RULEID]          INT            DEFAULT ((0)) NOT NULL,
    [POSITION Populated?__RULEID]            INT            DEFAULT ((0)) NOT NULL,
    [ACCOUNT Populated?__RULEID]             INT            DEFAULT ((0)) NOT NULL,
    [PRICE Populated?__RULEID]               INT            DEFAULT ((0)) NOT NULL,
    [UNIQUE_BLOOMBERG_ID Populated?__RULEID] INT            DEFAULT ((0)) NOT NULL,
    [CADIS_SYSTEM_ROWKEY]                    NVARCHAR (MAX) NOT NULL,
    [POS EXISTS]                             BIT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC)
);

