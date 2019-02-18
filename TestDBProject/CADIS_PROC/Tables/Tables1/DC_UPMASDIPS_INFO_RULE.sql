﻿CREATE TABLE [CADIS_PROC].[DC_UPMASDIPS_INFO_RULE] (
    [ASSET]                               VARCHAR (10) NOT NULL,
    [ASSET_NAME__RULEID]                  INT          NULL,
    [I/A__RULEID]                         INT          NULL,
    [SUB_FUND__RULEID]                    INT          NULL,
    [SUB_FUND_NAME__RULEID]               INT          NULL,
    [DEALING_PERIOD_ID__RULEID]           INT          NULL,
    [ORDER_DATE__RULEID]                  INT          NULL,
    [ORDER_REF]                           INT          NOT NULL,
    [MAIN_OWNER__RULEID]                  INT          NULL,
    [MAIN_OWNER_NAME__RULEID]             INT          NULL,
    [TYPE__RULEID]                        INT          NULL,
    [STATUS__RULEID]                      INT          NULL,
    [DEAL_CLASS__RULEID]                  INT          NULL,
    [UNITS/SHARES__RULEID]                INT          NULL,
    [CCY__RULEID]                         INT          NULL,
    [VALUE__RULEID]                       INT          NULL,
    [PLAN_ID__RULEID]                     INT          NULL,
    [DESIGNATION__RULEID]                 INT          NULL,
    [PRODUCT_NAME__RULEID]                INT          NULL,
    [DESCRIPTION__RULEID]                 INT          NULL,
    [AGENT__RULEID]                       INT          NULL,
    [AGENT_NAME__RULEID]                  INT          NULL,
    [ADMIN_FEE_%__RULEID]                 INT          NULL,
    [CREATION_PLUS_%__RULEID]             INT          NULL,
    [INITIAL_CHARGE_%__RULEID]            INT          NULL,
    [FEE_DISCOUNT_%__RULEID]              INT          NULL,
    [PRICE_DISCOUNT_%__RULEID]            INT          NULL,
    [COMMISSION_%__RULEID]                INT          NULL,
    [COMMISSION_VALUE__RULEID]            INT          NULL,
    [COMMISSION_WAIVER_%__RULEID]         INT          NULL,
    [RENEWAL_COMMISSION_%__RULEID]        INT          NULL,
    [PRICE_TYPE__RULEID]                  INT          NULL,
    [VALUATION_POINT]                     DATETIME     NOT NULL,
    [PRICING_DEALING_PERIOD_ID__RULEID]   INT          NULL,
    [DEAL_TYPE__RULEID]                   INT          NULL,
    [CONTRACT_NOTE_COMMENTS__RULEID]      INT          NULL,
    [FX_REQD?__RULEID]                    INT          NULL,
    [FX_CONFIRMED?__RULEID]               INT          NULL,
    [FX_INSTRUCTION__RULEID]              INT          NULL,
    [INDICATIVE_FX_RATE__RULEID]          INT          NULL,
    [CONFIRMED/SPOT_RATE__RULEID]         INT          NULL,
    [SETTLEMENT_CCY__RULEID]              INT          NULL,
    [SETTLEMENT_AMT__RULEID]              INT          NULL,
    [DL_%__RULEID]                        INT          NULL,
    [DL_AMOUNT__RULEID]                   INT          NULL,
    [EXEMPT?__RULEID]                     INT          NULL,
    [ESTIMATED?]                          BIT          NOT NULL,
    [EXTERNAL?__RULEID]                   INT          NULL,
    [IN_SPECIE__RULEID]                   INT          NULL,
    [US_WITHHOLDING_TAX__RULEID]          INT          NULL,
    [QUOTED_PRICE__RULEID]                INT          NULL,
    [DEAL_PRICE__RULEID]                  INT          NULL,
    [PRICE_ADJUSTMENT__RULEID]            INT          NULL,
    [%_OF_FUND_VALUE__RULEID]             INT          NULL,
    [COUNT__RULEID]                       INT          NULL,
    [DEALING_PERIOD_CLOSE_DATE__RULEID]   INT          NULL,
    [DEALING_PERIOD_CUT_OFF_DATE__RULEID] INT          NULL,
    [CUT_OFF_OVERRIDDEN__RULEID]          INT          NULL,
    [EXTERNAL_SOURCE__RULEID]             INT          NULL,
    PRIMARY KEY CLUSTERED ([ASSET] ASC, [ORDER_REF] ASC, [VALUATION_POINT] ASC, [ESTIMATED?] ASC)
);
