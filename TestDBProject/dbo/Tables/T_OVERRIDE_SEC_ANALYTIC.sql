﻿CREATE TABLE [dbo].[T_OVERRIDE_SEC_ANALYTIC] (
    [EDM_SEC_ID]                       INT             NOT NULL,
    [MARKET_CAP]                       DECIMAL (26, 2) NULL,
    [AVERAGE_VOLUME_100D]              DECIMAL (26, 6) NULL,
    [AVERAGE_VOLUME_30D]               DECIMAL (26, 6) NULL,
    [VOTING_RIGHTS]                    DECIMAL (26, 6) NULL,
    [PAR_AMOUNT]                       DECIMAL (26, 6) NULL,
    [OPEN_INTEREST]                    INT             NULL,
    [BASE_ACCRUAL_RATE_DATE]           DATETIME        NULL,
    [UNDERLYING_BASE_CPI]              DECIMAL (26, 6) NULL,
    [BASIC_SPREAD_PCT]                 DECIMAL (26, 6) NULL,
    [MID_CONVEXITY]                    DECIMAL (26, 6) NULL,
    [MID_DISCOUNT_MARGIN]              DECIMAL (26, 6) NULL,
    [MID_DISCOUNT_MARGIN_TO_NEXT_CALL] DECIMAL (26, 6) NULL,
    [MID_MODIFIED_DURATION]            DECIMAL (26, 6) NULL,
    [MID_MACAULAY_DURATION]            DECIMAL (26, 6) NULL,
    [MID_SPREAD_DURATION]              DECIMAL (26, 6) NULL,
    [FLOATER_SPREAD_BP]                DECIMAL (26, 6) NULL,
    [MORTGAGE_GENERIC_CPR_ISSUE]       DECIMAL (26, 6) NULL,
    [MORTGAGE_GENERIC_PSA_ISSUE]       DECIMAL (26, 6) NULL,
    [MORTGAGE_ORIGINAL_WAC]            DECIMAL (26, 6) NULL,
    [MORTGAGE_ORIGINAL_WAM]            DECIMAL (26, 6) NULL,
    [MORTGAGE_POOL_PSA_ISSUE]          DECIMAL (26, 6) NULL,
    [MORTGAGE_PRINCIPAL_LOSSES]        DECIMAL (26, 6) NULL,
    [MORTGAGE_WAL_YEARS]               DECIMAL (26, 6) NULL,
    [MORTGAGE_WAM_MONTHS]              DECIMAL (26, 6) NULL,
    [MID_OAS_SPREAD_DURATION]          DECIMAL (26, 6) NULL,
    [WITHHOLDING_TAX]                  DECIMAL (26, 6) NULL,
    [MID_YIELD_TO_CONVENTION]          DECIMAL (26, 6) NULL,
    [ASK_YIELD_TO_NEXT_CALL]           DECIMAL (26, 6) NULL,
    [ASK_YIELD_TO_MATURITY]            DECIMAL (26, 6) NULL,
    [MID_YIELD_TO_MATURITY]            DECIMAL (26, 6) NULL,
    [MID_Z_SPREAD_BP]                  DECIMAL (26, 6) NULL,
    [ANNUAL_MODIFIED_DURATION]         DECIMAL (26, 6) NULL,
    [SEMI_ANNUAL_MODIFIED_DURATION]    DECIMAL (26, 6) NULL,
    [ISMA_MODIFIED_DURATION]           DECIMAL (26, 6) NULL,
    [MODIFIED_DURATION]                DECIMAL (26, 6) NULL,
    [YIELD_TO_MATURITY]                DECIMAL (26, 6) NULL,
    [ANNUAL_YIELD]                     DECIMAL (26, 6) NULL,
    [SEMI_ANNUAL_YIELD]                DECIMAL (26, 6) NULL,
    [ISMA_YIELD]                       DECIMAL (26, 6) NULL,
    [OAS]                              DECIMAL (26, 6) NULL,
    [Z_SPREAD]                         DECIMAL (26, 6) NULL,
    [EXPECTED_REMAINING_LIFE]          DECIMAL (26, 6) NULL,
    [MATURITY_WAL]                     DECIMAL (26, 6) NULL,
    [CADIS_SYSTEM_INSERTED]            DATETIME        CONSTRAINT [DF__T_OVERRID__CADIS__076DBA23] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]             DATETIME        CONSTRAINT [DF__T_OVERRID__CADIS__0861DE5C] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]           NVARCHAR (50)   CONSTRAINT [DF__T_OVERRID__CADIS__09560295] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]            INT             CONSTRAINT [DF__T_OVERRID__CADIS__0A4A26CE] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]           ROWVERSION      NOT NULL,
    CONSTRAINT [PK__T_OVERRI__B157E8F25AF96B99] PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 90)
);

