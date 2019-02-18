﻿CREATE TABLE [CADIS_PROC].[DC_ENNTPOS_NTPOS_PREP] (
    [Valid Sedol?]                   BIT             NULL,
    [Valid ISIN?]                    BIT             NULL,
    [TRADE_DATE Populated?]          BIT             NULL,
    [POSITION Populated?]            BIT             NULL,
    [ACCOUNT Populated?]             BIT             NULL,
    [PRICE Populated?]               BIT             NULL,
    [UNIQUE_BLOOMBERG_ID Populated?] BIT             NULL,
    [CADIS_SYSTEM_CHANGEDBY]         NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_INSERTED]          DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]           DATETIME        NULL,
    [ROW_NUMBER]                     INT             NOT NULL,
    [EDM_SEC_ID]                     INT             NULL,
    [FILE_NAME]                      VARCHAR (100)   NOT NULL,
    [FILE_TYPE]                      VARCHAR (4)     NULL,
    [FILE_DATE]                      DATETIME        NULL,
    [NUMBER_OF_RECORDS]              VARCHAR (20)    NULL,
    [TICKET_NUMBER]                  INT             NULL,
    [TRADE_DATE]                     DATETIME        NOT NULL,
    [SECURITY_IDENTIFIER_FLAG]       VARCHAR (2)     NULL,
    [SECURITY_IDENTIFIER]            VARCHAR (12)    NULL,
    [SETTLEMENT_DATE]                DATETIME        NULL,
    [LONGSHORT_INDICATOR]            VARCHAR (8)     NULL,
    [POSITION]                       DECIMAL (15, 2) NOT NULL,
    [ACCOUNT]                        VARCHAR (15)    NOT NULL,
    [PRICE_FRACTIONAL_INDICATOR]     INT             NULL,
    [PRICE]                          DECIMAL (18, 2) NOT NULL,
    [EXCHANGE_CODE]                  VARCHAR (12)    NULL,
    [PRODUCT_CODE]                   VARCHAR (20)    NULL,
    [BRADY-STYLE_FACTOR]             VARCHAR (20)    NULL,
    [UNIQUE_BLOOMBERG_ID]            VARCHAR (20)    NOT NULL,
    [FX_FORWARD_POINTS]              INT             NULL,
    [SWAP_PAYRECEIVE_FLAG]           VARCHAR (20)    NULL,
    [SWAP_FEE]                       INT             NULL,
    [PAY_NOTIONAL_AMOUNT]            INT             NULL,
    [RECEIVE_NOTIONAL_AMOUNT]        INT             NULL,
    [FX_AVERAGE_COST]                DECIMAL (18, 8) NULL,
    [IS_SHORT]                       TEXT            NULL,
    [IS_CFD]                         TEXT            NULL,
    [PRIME_BROKER]                   VARCHAR (36)    NULL,
    [STRATEGY_NAME]                  VARCHAR (34)    NULL,
    [CADIS_SYSTEM_INSERTED0]         DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED0]          DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY0]        NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]          INT             NULL,
    [CADIS_SYSTEM_LASTMODIFIED]      DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([TRADE_DATE] ASC, [POSITION] ASC, [ACCOUNT] ASC, [PRICE] ASC, [UNIQUE_BLOOMBERG_ID] ASC) WITH (FILLFACTOR = 80)
);

