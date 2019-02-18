﻿CREATE TABLE [CADIS_PROC].[DC_UPMASDIPS_RESET_PREP] (
    [ASSET]                       VARCHAR (10)  NOT NULL,
    [ASSET_NAME]                  BIT           NULL,
    [I/A]                         BIT           NULL,
    [SUB_FUND]                    BIT           NULL,
    [SUB_FUND_NAME]               BIT           NULL,
    [DEALING_PERIOD_ID]           BIT           NULL,
    [ORDER_DATE]                  BIT           NULL,
    [ORDER_REF]                   INT           NOT NULL,
    [MAIN_OWNER]                  BIT           NULL,
    [MAIN_OWNER_NAME]             BIT           NULL,
    [TYPE]                        BIT           NULL,
    [STATUS]                      VARCHAR (40)  NULL,
    [DEAL_CLASS]                  BIT           NULL,
    [UNITS/SHARES]                BIT           NULL,
    [CCY]                         BIT           NULL,
    [VALUE]                       BIT           NULL,
    [PLAN_ID]                     BIT           NULL,
    [DESIGNATION]                 BIT           NULL,
    [PRODUCT_NAME]                BIT           NULL,
    [DESCRIPTION]                 BIT           NULL,
    [AGENT]                       BIT           NULL,
    [AGENT_NAME]                  BIT           NULL,
    [ADMIN_FEE_%]                 BIT           NULL,
    [CREATION_PLUS_%]             BIT           NULL,
    [INITIAL_CHARGE_%]            BIT           NULL,
    [FEE_DISCOUNT_%]              BIT           NULL,
    [PRICE_DISCOUNT_%]            BIT           NULL,
    [COMMISSION_%]                BIT           NULL,
    [COMMISSION_VALUE]            BIT           NULL,
    [COMMISSION_WAIVER_%]         BIT           NULL,
    [RENEWAL_COMMISSION_%]        BIT           NULL,
    [PRICE_TYPE]                  BIT           NULL,
    [VALUATION_POINT]             DATETIME      NOT NULL,
    [PRICING_DEALING_PERIOD_ID]   BIT           NULL,
    [DEAL_TYPE]                   BIT           NULL,
    [CONTRACT_NOTE_COMMENTS]      BIT           NULL,
    [FX_REQD?]                    BIT           NULL,
    [FX_CONFIRMED?]               BIT           NULL,
    [FX_INSTRUCTION]              BIT           NULL,
    [INDICATIVE_FX_RATE]          BIT           NULL,
    [CONFIRMED/SPOT_RATE]         BIT           NULL,
    [SETTLEMENT_CCY]              BIT           NULL,
    [SETTLEMENT_AMT]              BIT           NULL,
    [DL_%]                        BIT           NULL,
    [DL_AMOUNT]                   BIT           NULL,
    [EXEMPT?]                     BIT           NULL,
    [ESTIMATED?]                  BIT           NOT NULL,
    [EXTERNAL?]                   BIT           NULL,
    [IN_SPECIE]                   BIT           NULL,
    [US_WITHHOLDING_TAX]          BIT           NULL,
    [QUOTED_PRICE]                BIT           NULL,
    [DEAL_PRICE]                  BIT           NULL,
    [PRICE_ADJUSTMENT]            BIT           NULL,
    [%_OF_FUND_VALUE]             BIT           NULL,
    [COUNT]                       BIT           NULL,
    [DEALING_PERIOD_CLOSE_DATE]   BIT           NULL,
    [DEALING_PERIOD_CUT_OFF_DATE] BIT           NULL,
    [CUT_OFF_OVERRIDDEN]          BIT           NULL,
    [EXTERNAL_SOURCE]             BIT           NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50) NULL,
    [CADIS_SYSTEM_PRIORITY]       INT           NULL,
    [CADIS_SYSTEM_LASTMODIFIED]   DATETIME      NULL,
    [CADIS_SYSTEM_TIMESTAMP]      ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([ASSET] ASC, [ORDER_REF] ASC, [VALUATION_POINT] ASC, [ESTIMATED?] ASC) WITH (FILLFACTOR = 80)
);

