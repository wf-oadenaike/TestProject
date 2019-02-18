﻿CREATE TABLE [dbo].[T_OVERRIDE_SEC_ANALYTIC_RESET] (
    [EDM_SEC_ID]                       INT           NOT NULL,
    [MARKET_CAP]                       BIT           CONSTRAINT [DF__T_OVERRID__MARKE__72E79E89] DEFAULT ((0)) NULL,
    [AVERAGE_VOLUME_100D]              BIT           CONSTRAINT [DF__T_OVERRID__AVERA__73DBC2C2] DEFAULT ((0)) NULL,
    [AVERAGE_VOLUME_30D]               BIT           CONSTRAINT [DF__T_OVERRID__AVERA__74CFE6FB] DEFAULT ((0)) NULL,
    [VOTING_RIGHTS]                    BIT           CONSTRAINT [DF__T_OVERRID__VOTIN__75C40B34] DEFAULT ((0)) NULL,
    [PAR_AMOUNT]                       BIT           CONSTRAINT [DF__T_OVERRID__PAR_A__76B82F6D] DEFAULT ((0)) NULL,
    [OPEN_INTEREST]                    BIT           CONSTRAINT [DF__T_OVERRID__OPEN___77AC53A6] DEFAULT ((0)) NULL,
    [BASE_ACCRUAL_RATE_DATE]           BIT           CONSTRAINT [DF__T_OVERRID__BASE___78A077DF] DEFAULT ((0)) NULL,
    [UNDERLYING_BASE_CPI]              BIT           CONSTRAINT [DF__T_OVERRID__UNDER__79949C18] DEFAULT ((0)) NULL,
    [BASIC_SPREAD_PCT]                 BIT           CONSTRAINT [DF__T_OVERRID__BASIC__7A88C051] DEFAULT ((0)) NULL,
    [MID_CONVEXITY]                    BIT           CONSTRAINT [DF__T_OVERRID__MID_C__7B7CE48A] DEFAULT ((0)) NULL,
    [MID_DISCOUNT_MARGIN]              BIT           CONSTRAINT [DF__T_OVERRID__MID_D__7C7108C3] DEFAULT ((0)) NULL,
    [MID_DISCOUNT_MARGIN_TO_NEXT_CALL] BIT           CONSTRAINT [DF__T_OVERRID__MID_D__7D652CFC] DEFAULT ((0)) NULL,
    [MID_MODIFIED_DURATION]            BIT           CONSTRAINT [DF__T_OVERRID__MID_M__7E595135] DEFAULT ((0)) NULL,
    [MID_MACAULAY_DURATION]            BIT           CONSTRAINT [DF__T_OVERRID__MID_M__7F4D756E] DEFAULT ((0)) NULL,
    [MID_SPREAD_DURATION]              BIT           CONSTRAINT [DF__T_OVERRID__MID_S__004199A7] DEFAULT ((0)) NULL,
    [FLOATER_SPREAD_BP]                BIT           CONSTRAINT [DF__T_OVERRID__FLOAT__0135BDE0] DEFAULT ((0)) NULL,
    [MORTGAGE_GENERIC_CPR_ISSUE]       BIT           CONSTRAINT [DF__T_OVERRID__MORTG__0229E219] DEFAULT ((0)) NULL,
    [MORTGAGE_GENERIC_PSA_ISSUE]       BIT           CONSTRAINT [DF__T_OVERRID__MORTG__031E0652] DEFAULT ((0)) NULL,
    [MORTGAGE_ORIGINAL_WAC]            BIT           CONSTRAINT [DF__T_OVERRID__MORTG__04122A8B] DEFAULT ((0)) NULL,
    [MORTGAGE_ORIGINAL_WAM]            BIT           CONSTRAINT [DF__T_OVERRID__MORTG__05064EC4] DEFAULT ((0)) NULL,
    [MORTGAGE_POOL_PSA_ISSUE]          BIT           CONSTRAINT [DF__T_OVERRID__MORTG__05FA72FD] DEFAULT ((0)) NULL,
    [MORTGAGE_PRINCIPAL_LOSSES]        BIT           CONSTRAINT [DF__T_OVERRID__MORTG__06EE9736] DEFAULT ((0)) NULL,
    [MORTGAGE_WAL_YEARS]               BIT           CONSTRAINT [DF__T_OVERRID__MORTG__07E2BB6F] DEFAULT ((0)) NULL,
    [MORTGAGE_WAM_MONTHS]              BIT           CONSTRAINT [DF__T_OVERRID__MORTG__08D6DFA8] DEFAULT ((0)) NULL,
    [MID_OAS_SPREAD_DURATION]          BIT           CONSTRAINT [DF__T_OVERRID__MID_O__09CB03E1] DEFAULT ((0)) NULL,
    [WITHHOLDING_TAX]                  BIT           CONSTRAINT [DF__T_OVERRID__WITHH__0ABF281A] DEFAULT ((0)) NULL,
    [MID_YIELD_TO_CONVENTION]          BIT           CONSTRAINT [DF__T_OVERRID__MID_Y__0BB34C53] DEFAULT ((0)) NULL,
    [ASK_YIELD_TO_NEXT_CALL]           BIT           CONSTRAINT [DF__T_OVERRID__ASK_Y__0CA7708C] DEFAULT ((0)) NULL,
    [ASK_YIELD_TO_MATURITY]            BIT           CONSTRAINT [DF__T_OVERRID__ASK_Y__0D9B94C5] DEFAULT ((0)) NULL,
    [MID_YIELD_TO_MATURITY]            BIT           CONSTRAINT [DF__T_OVERRID__MID_Y__0E8FB8FE] DEFAULT ((0)) NULL,
    [MID_Z_SPREAD_BP]                  BIT           CONSTRAINT [DF__T_OVERRID__MID_Z__0F83DD37] DEFAULT ((0)) NULL,
    [ANNUAL_MODIFIED_DURATION]         BIT           CONSTRAINT [DF__T_OVERRID__ANNUA__10780170] DEFAULT ((0)) NULL,
    [SEMI_ANNUAL_MODIFIED_DURATION]    BIT           CONSTRAINT [DF__T_OVERRID__SEMI___116C25A9] DEFAULT ((0)) NULL,
    [ISMA_MODIFIED_DURATION]           BIT           CONSTRAINT [DF__T_OVERRID__ISMA___126049E2] DEFAULT ((0)) NULL,
    [MODIFIED_DURATION]                BIT           CONSTRAINT [DF__T_OVERRID__MODIF__13546E1B] DEFAULT ((0)) NULL,
    [YIELD_TO_MATURITY]                BIT           CONSTRAINT [DF__T_OVERRID__YIELD__14489254] DEFAULT ((0)) NULL,
    [ANNUAL_YIELD]                     BIT           CONSTRAINT [DF__T_OVERRID__ANNUA__153CB68D] DEFAULT ((0)) NULL,
    [SEMI_ANNUAL_YIELD]                BIT           CONSTRAINT [DF__T_OVERRID__SEMI___1630DAC6] DEFAULT ((0)) NULL,
    [ISMA_YIELD]                       BIT           CONSTRAINT [DF__T_OVERRID__ISMA___1724FEFF] DEFAULT ((0)) NULL,
    [OAS]                              BIT           CONSTRAINT [DF__T_OVERRIDE___OAS__18192338] DEFAULT ((0)) NULL,
    [Z_SPREAD]                         BIT           CONSTRAINT [DF__T_OVERRID__Z_SPR__190D4771] DEFAULT ((0)) NULL,
    [EXPECTED_REMAINING_LIFE]          BIT           CONSTRAINT [DF__T_OVERRID__EXPEC__1A016BAA] DEFAULT ((0)) NULL,
    [MATURITY_WAL]                     BIT           CONSTRAINT [DF__T_OVERRID__MATUR__1AF58FE3] DEFAULT ((0)) NULL,
    [CADIS_SYSTEM_INSERTED]            DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__1BE9B41C] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]             DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__1CDDD855] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]           NVARCHAR (50) CONSTRAINT [DF__T_OVERRID__CADIS__1DD1FC8E] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]            INT           CONSTRAINT [DF__T_OVERRID__CADIS__1EC620C7] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]           ROWVERSION    NOT NULL,
    CONSTRAINT [PK__T_OVERRI__B157E8F2E68158EE] PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 90)
);
