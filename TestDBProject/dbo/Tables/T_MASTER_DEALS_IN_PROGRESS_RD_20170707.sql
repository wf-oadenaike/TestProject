﻿CREATE TABLE [dbo].[T_MASTER_DEALS_IN_PROGRESS_RD_20170707] (
    [ASSET]                       VARCHAR (10)    NOT NULL,
    [ASSET_NAME]                  VARCHAR (100)   NULL,
    [I/A]                         VARCHAR (5)     NULL,
    [SUB_FUND]                    VARCHAR (10)    NULL,
    [SUB_FUND_NAME]               VARCHAR (50)    NULL,
    [DEALING_PERIOD_ID]           INT             NULL,
    [ORDER_DATE]                  DATETIME        NULL,
    [ORDER_REF]                   INT             NOT NULL,
    [MAIN_OWNER]                  INT             NULL,
    [MAIN_OWNER_NAME]             VARCHAR (100)   NULL,
    [TYPE]                        VARCHAR (40)    NULL,
    [STATUS]                      VARCHAR (40)    NULL,
    [DEAL_CLASS]                  VARCHAR (20)    NULL,
    [UNITS/SHARES]                DECIMAL (16, 3) NULL,
    [CCY]                         VARCHAR (3)     NULL,
    [VALUE]                       DECIMAL (16, 2) NULL,
    [PLAN_ID]                     INT             NULL,
    [DESIGNATION]                 VARCHAR (20)    NULL,
    [PRODUCT_NAME]                VARCHAR (20)    NULL,
    [DESCRIPTION]                 VARCHAR (40)    NULL,
    [AGENT]                       INT             NULL,
    [AGENT_NAME]                  VARCHAR (100)   NULL,
    [ADMIN_FEE_%]                 DECIMAL (16, 3) NULL,
    [CREATION_PLUS_%]             DECIMAL (16, 3) NULL,
    [INITIAL_CHARGE_%]            DECIMAL (16, 3) NULL,
    [FEE_DISCOUNT_%]              DECIMAL (16, 3) NULL,
    [PRICE_DISCOUNT_%]            DECIMAL (16, 3) NULL,
    [COMMISSION_%]                DECIMAL (16, 3) NULL,
    [COMMISSION_VALUE]            DECIMAL (16, 3) NULL,
    [COMMISSION_WAIVER_%]         DECIMAL (16, 3) NULL,
    [RENEWAL_COMMISSION_%]        DECIMAL (16, 3) NULL,
    [PRICE_TYPE]                  VARCHAR (10)    NULL,
    [VALUATION_POINT]             DATETIME        NOT NULL,
    [PRICING_DEALING_PERIOD_ID]   INT             NULL,
    [DEAL_TYPE]                   VARCHAR (10)    NULL,
    [CONTRACT_NOTE_COMMENTS]      VARCHAR (100)   NULL,
    [FX_REQD?]                    VARCHAR (40)    NULL,
    [FX_CONFIRMED?]               VARCHAR (40)    NULL,
    [FX_INSTRUCTION]              VARCHAR (40)    NULL,
    [INDICATIVE_FX_RATE]          DECIMAL (16, 3) NULL,
    [CONFIRMED/SPOT_RATE]         DECIMAL (16, 3) NULL,
    [SETTLEMENT_CCY]              VARCHAR (3)     NULL,
    [SETTLEMENT_AMT]              DECIMAL (16, 2) NULL,
    [DL_%]                        VARCHAR (20)    NULL,
    [DL_AMOUNT]                   VARCHAR (20)    NULL,
    [EXEMPT?]                     BIT             NULL,
    [ESTIMATED?]                  BIT             NULL,
    [EXTERNAL?]                   BIT             NULL,
    [IN_SPECIE]                   VARCHAR (20)    NULL,
    [US_WITHHOLDING_TAX]          VARCHAR (20)    NULL,
    [QUOTED_PRICE]                VARCHAR (20)    NULL,
    [DEAL_PRICE]                  VARCHAR (20)    NULL,
    [PRICE_ADJUSTMENT]            VARCHAR (20)    NULL,
    [%_OF_FUND_VALUE]             VARCHAR (20)    NULL,
    [COUNT]                       VARCHAR (20)    NULL,
    [DEALING_PERIOD_CLOSE_DATE]   DATETIME        NULL,
    [DEALING_PERIOD_CUT_OFF_DATE] DATETIME        NULL,
    [CUT_OFF_OVERRIDDEN]          VARCHAR (20)    NULL,
    [EXTERNAL_SOURCE]             VARCHAR (20)    NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]       INT             NULL,
    [CADIS_SYSTEM_LASTMODIFIED]   DATETIME        NULL
);

