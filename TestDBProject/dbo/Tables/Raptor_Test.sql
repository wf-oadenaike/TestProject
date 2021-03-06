﻿CREATE TABLE [dbo].[Raptor_Test] (
    [CADIS_BATCH_ID]                         INT              NOT NULL,
    [CADIS_MSG_ID]                           INT              NOT NULL,
    [CADIS_PARENT_ID]                        INT              NOT NULL,
    [CADIS_ROW_ID]                           BIGINT           NULL,
    [PositionDate]                           VARCHAR (10)     NULL,
    [SOURCE]                                 VARCHAR (50)     NOT NULL,
    [POSITION_TYPE]                          VARCHAR (50)     NOT NULL,
    [EDM_SEC_ID]                             INT              NOT NULL,
    [FUND_SHORT_NAME]                        VARCHAR (15)     NOT NULL,
    [LONG_SHORT_IND]                         VARCHAR (8)      NOT NULL,
    [POSITION_DATE]                          DATETIME         NOT NULL,
    [PRICE]                                  DECIMAL (24, 10) NOT NULL,
    [QUANTITY]                               DECIMAL (20, 6)  NOT NULL,
    [SECURITY_NAME]                          VARCHAR (100)    NULL,
    [SECURITY_DESCRIPTION]                   VARCHAR (200)    NULL,
    [SECURITY_SHORTNAME]                     VARCHAR (30)     NULL,
    [ASSET_TYPE]                             VARCHAR (30)     NULL,
    [SECURITY_TYPE]                          VARCHAR (50)     NULL,
    [CUSIP]                                  VARCHAR (9)      NULL,
    [ISIN]                                   VARCHAR (12)     NULL,
    [SEDOL]                                  VARCHAR (7)      NULL,
    [TICKER]                                 VARCHAR (26)     NULL,
    [VALOREN]                                VARCHAR (12)     NULL,
    [WERTPAPIER]                             VARCHAR (12)     NULL,
    [SECURITY_ISO_CCY]                       VARCHAR (3)      NOT NULL,
    [RISK_ISO_CCY]                           VARCHAR (3)      NULL,
    [FIXED_ISO_CCY]                          VARCHAR (3)      NULL,
    [INCORPORATION_ISO_CTY]                  VARCHAR (4)      NULL,
    [DOMICILE_ISO_CTY]                       VARCHAR (4)      NULL,
    [ISSUE_COUNTRY_ISO]                      VARCHAR (4)      NULL,
    [RISK_ISO_CTY]                           VARCHAR (4)      NULL,
    [MIC_EXCHANGE_CODE]                      VARCHAR (4)      NULL,
    [BBG_EXCHANGE_CODE]                      VARCHAR (20)     NULL,
    [STATE_CODE]                             VARCHAR (8)      NULL,
    [ACTIVE_TRADE_INDICATOR]                 VARCHAR (1)      NULL,
    [144A_INDICATOR]                         VARCHAR (1)      NULL,
    [PRIVATE_PLACEMENT_INDICATOR]            VARCHAR (1)      NULL,
    [ILLIQUID]                               VARCHAR (1)      NULL,
    [QUOTE_TYPE]                             VARCHAR (8)      NULL,
    [DAYS_TO_SETTLE]                         INT              NULL,
    [TRADE_SETTLEMENT_CALENDAR_CODE]         VARCHAR (4)      NULL,
    [UNIQUE_BLOOMBERG_ID]                    VARCHAR (30)     NULL,
    [BBG_SECTOR]                             VARCHAR (20)     NULL,
    [BBG_SUBSECTOR]                          VARCHAR (20)     NULL,
    [BBG_GROUP]                              VARCHAR (40)     NULL,
    [IS_IPO]                                 VARCHAR (20)     NULL,
    [PARSEKEYABLE_DESCRIPTION]               VARCHAR (100)    NULL,
    [SECURITY_IDENTIFIER]                    VARCHAR (20)     NULL,
    [IRISH_SEDOL_NUMBER]                     VARCHAR (20)     NULL,
    [PRIMARY_EXCHANGE_NAME]                  VARCHAR (30)     NULL,
    [ISSUER]                                 VARCHAR (80)     NULL,
    [SECURITY_HAS_ADRS]                      VARCHAR (4)      NULL,
    [Component_InstrumentId]                 VARCHAR (30)     NULL,
    [EX_DIVIDEND_DATE]                       VARCHAR (10)     NOT NULL,
    [DIVIDEND_FREQUENCY]                     VARCHAR (20)     NOT NULL,
    [DIVIDEND_PAY_DATE]                      VARCHAR (10)     NOT NULL,
    [DIVIDEND_PER_SHARE_LAST_NET]            DECIMAL (26, 12) NOT NULL,
    [DIVIDEND_PER_SHARE_LAST_GROSS]          DECIMAL (26, 12) NOT NULL,
    [DIVIDEND_PER_SHARE_ANNUAL_GROSS]        DECIMAL (26, 6)  NOT NULL,
    [DIVIDEND_TYPE]                          VARCHAR (30)     NOT NULL,
    [DIVIDEND_RECORD_DATE]                   VARCHAR (10)     NOT NULL,
    [CURRENT_STOCK_DIVIDEND_EX_DATE]         VARCHAR (10)     NOT NULL,
    [CURRENT_STOCK_DIVIDEND_PAY_DATE]        VARCHAR (10)     NOT NULL,
    [CURRENT_STOCK_DIVIDEND_PCT]             VARCHAR (10)     NOT NULL,
    [NORMAL_MARKET_SIZE]                     DECIMAL (26, 6)  NOT NULL,
    [SHARES_OUTSTANDING]                     DECIMAL (26, 6)  NOT NULL,
    [SHARES_OUTSTANDING_DATE]                VARCHAR (10)     NOT NULL,
    [IPO]                                    VARCHAR (20)     NOT NULL,
    [VOL_WEIGHTED_AVERAGE_PRICE]             DECIMAL (26, 6)  NOT NULL,
    [FUND_NET_ASSET_VALUE]                   DECIMAL (26, 6)  NOT NULL,
    [FUND_TOTAL_ASSETS]                      DECIMAL (26, 6)  NOT NULL,
    [LAST_UPDATE_DATE_EXCHANGE_TIMEZONE]     VARCHAR (10)     NOT NULL,
    [TOTAL_VOTING_SHARES]                    DECIMAL (26, 6)  NOT NULL,
    [SHARE_OUTSTANDING_REAL_ACTUAL]          VARCHAR (20)     NOT NULL,
    [TOTAL_VOTING_SHARES_VALUE]              VARCHAR (20)     NOT NULL,
    [LAST_PUBLISHED_OFFER_NO_OF_SHARES]      VARCHAR (20)     NOT NULL,
    [SHARE_OUTSTANDING_REAL_VALUE]           VARCHAR (20)     NOT NULL,
    [CUR_MAR_CAP]                            VARCHAR (20)     NOT NULL,
    [OPTION_ROOT_TICKER]                     VARCHAR (10)     NOT NULL,
    [PUT_CALL_INDICATOR]                     VARCHAR (8)      NOT NULL,
    [EXPIRY_DATE]                            VARCHAR (10)     NOT NULL,
    [FUTURE_EXPIRY_MONTH_YEAR]               VARCHAR (10)     NOT NULL,
    [EXERCISE_TYPE]                          VARCHAR (8)      NOT NULL,
    [CONTRACT_SIZE]                          DECIMAL (26, 6)  NOT NULL,
    [CONTRACT_VALUE]                         DECIMAL (26, 6)  NOT NULL,
    [FUTURE_TYPE]                            VARCHAR (30)     NOT NULL,
    [LAST_TRADE_DATE]                        VARCHAR (10)     NOT NULL,
    [LONG_EXCHANGE_NAME]                     VARCHAR (30)     NOT NULL,
    [DELTA]                                  DECIMAL (26, 6)  NOT NULL,
    [GAMMA]                                  DECIMAL (26, 6)  NOT NULL,
    [THETA]                                  DECIMAL (26, 6)  NOT NULL,
    [VEGA]                                   DECIMAL (26, 6)  NOT NULL,
    [EURO_FUTURE_INDICATOR]                  VARCHAR (1)      NOT NULL,
    [CONVERSION_FACTOR]                      DECIMAL (26, 6)  NOT NULL,
    [CTD_CONVERSION_DURATION]                DECIMAL (26, 6)  NOT NULL,
    [CTD_ISIN]                               VARCHAR (12)     NOT NULL,
    [CTD_SEDOL]                              VARCHAR (7)      NOT NULL,
    [CTD_RISK_TYPE]                          VARCHAR (20)     NOT NULL,
    [FUTURE_DAYS_TO_EXPIRY]                  INT              NOT NULL,
    [FUTURE_LONGNAME]                        VARCHAR (30)     NOT NULL,
    [STRIKE_PRICE]                           DECIMAL (26, 6)  NOT NULL,
    [TICK_SIZE]                              DECIMAL (26, 6)  NOT NULL,
    [ISSUE_DATE]                             VARCHAR (10)     NOT NULL,
    [MATURITY_DATE]                          VARCHAR (10)     NOT NULL,
    [COUPON_RATE]                            DECIMAL (26, 6)  NOT NULL,
    [COUPON_FREQUENCY]                       INT              NOT NULL,
    [COUPON_TYPE]                            VARCHAR (30)     NOT NULL,
    [CONVERTIBLE_INDICATOR]                  VARCHAR (1)      NOT NULL,
    [AMOUNT_ISSUED]                          DECIMAL (26, 2)  NOT NULL,
    [AMOUNT_OUTSTANDING]                     DECIMAL (26, 2)  NOT NULL,
    [COUPON_CAP]                             DECIMAL (26, 6)  NOT NULL,
    [COUPON_ISO_CCY]                         VARCHAR (3)      NOT NULL,
    [COUPON_FLOOR]                           DECIMAL (26, 6)  NOT NULL,
    [ISSUE_PRICE]                            DECIMAL (26, 6)  NOT NULL,
    [DAY_COUNT]                              INT              NOT NULL,
    [FIRST_COUPON_DATE]                      VARCHAR (10)     NOT NULL,
    [FIRST_SETTLE_DATE]                      VARCHAR (10)     NOT NULL,
    [PREVIOUS_COUPON_DATE]                   VARCHAR (10)     NOT NULL,
    [NEXT_COUPON_DATE]                       VARCHAR (10)     NOT NULL,
    [NEXT_CALL_DATE]                         VARCHAR (10)     NOT NULL,
    [NEXT_CALL_PRICE]                        DECIMAL (26, 6)  NOT NULL,
    [LAST_RESET_DATE]                        VARCHAR (10)     NOT NULL,
    [NEXT_RESET_DATE]                        VARCHAR (10)     NOT NULL,
    [SECOND_COUPON_DATE]                     VARCHAR (10)     NOT NULL,
    [FIXED_INDICATOR]                        VARCHAR (1)      NOT NULL,
    [FIX_TO_FLOAT_INDICATOR]                 VARCHAR (1)      NOT NULL,
    [FLOATER_INDICATOR]                      VARCHAR (1)      NOT NULL,
    [FLOAT_TO_FIX_INDICATOR]                 VARCHAR (1)      NOT NULL,
    [INDEX_LINKED_INDICATOR]                 VARCHAR (1)      NOT NULL,
    [INFLATION_LINKED_INDICATOR]             VARCHAR (1)      NOT NULL,
    [PERPETUAL_INDICATOR]                    VARCHAR (1)      NOT NULL,
    [ZERO_COUPON_INDICATOR]                  VARCHAR (1)      NOT NULL,
    [ACCRUED_INTEREST_PER_100]               DECIMAL (26, 6)  NOT NULL,
    [ACCRUED_INTEREST_DATE]                  VARCHAR (10)     NOT NULL,
    [COLLATERAL_TYPE]                        VARCHAR (30)     NOT NULL,
    [AGGREGATE_AMOUNT_ISSUED_INDICATOR]      VARCHAR (1)      NOT NULL,
    [ASSUMED_INDEX_VALUE]                    VARCHAR (10)     NOT NULL,
    [BRADY_INDICATOR]                        VARCHAR (1)      NOT NULL,
    [CALCULATION_TYPE]                       INT              NOT NULL,
    [CALLABLE_INDICATOR]                     VARCHAR (1)      NOT NULL,
    [CALLED_INDICATOR]                       VARCHAR (1)      NOT NULL,
    [CALL_DAYS_NOTICE]                       INT              NOT NULL,
    [PUTABLE_INDICATOR]                      VARCHAR (1)      NOT NULL,
    [PUT_DAYS_NOTICE]                        INT              NOT NULL,
    [CASH_SETTLED_INDICATOR]                 VARCHAR (1)      NOT NULL,
    [CDS_RECOVERY_RATE]                      DECIMAL (26, 6)  NOT NULL,
    [CORPORATE_TO_EQUITY_TICKER]             VARCHAR (11)     NOT NULL,
    [FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE]    VARCHAR (10)     NOT NULL,
    [DEFAULTED_INDICATOR]                    VARCHAR (1)      NOT NULL,
    [EXCHANGEABLE_INDICATOR]                 VARCHAR (1)      NOT NULL,
    [FLOATER_COUPON_CONVENTION]              VARCHAR (30)     NOT NULL,
    [FLOATER_LOCKOUT_PERIOD]                 INT              NOT NULL,
    [FLOATER_PAY_DAY]                        VARCHAR (30)     NOT NULL,
    [JUNIOR_INDICATOR]                       VARCHAR (1)      NOT NULL,
    [SENIOR_INDICATOR]                       VARCHAR (1)      NOT NULL,
    [REGULATION_S_INDICATOR]                 VARCHAR (1)      NOT NULL,
    [SUBORDINATED_INDICATOR]                 VARCHAR (1)      NOT NULL,
    [UNIT_TRADED_INDICATOR]                  VARCHAR (1)      NOT NULL,
    [LOAN_PARTICIPATION_NOTE_INDICATOR]      VARCHAR (1)      NOT NULL,
    [ORIGINAL_ISSUE_DISCOUNT_INDICATOR]      VARCHAR (4)      NOT NULL,
    [GILT_DIGITS]                            INT              NOT NULL,
    [GILTS_EX_DIVIDEND_DATE]                 VARCHAR (10)     NOT NULL,
    [INDEX_RATIO_CPI]                        DECIMAL (26, 6)  NOT NULL,
    [MINIMUM_INCREMENT]                      DECIMAL (26, 6)  NOT NULL,
    [MINIMUM_PIECE]                          DECIMAL (26, 6)  NOT NULL,
    [MOST_RECENT_REPORTED_FACTOR]            DECIMAL (26, 10) NOT NULL,
    [MOST_RECENT_ACCRUAL_RATE]               DECIMAL (26, 6)  NOT NULL,
    [MOST_RECENT_ACCRUAL_RATE_START_DATE]    VARCHAR (10)     NOT NULL,
    [MORTGAGE_DEAL_CALL_DATE]                VARCHAR (10)     NOT NULL,
    [MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY] VARCHAR (10)     NOT NULL,
    [MORTGAGE_FACTOR_DATE]                   VARCHAR (10)     NOT NULL,
    [MORTGAGE_CURRENT_PAYMENT_RATE]          DECIMAL (26, 6)  NOT NULL,
    [MORTGAGE_FINAL_PAY_DATE]                VARCHAR (10)     NOT NULL,
    [MORTGAGE_FIRST_PAY_DATE]                VARCHAR (10)     NOT NULL,
    [MORTGAGE_LIFE_FLOOR]                    DECIMAL (26, 2)  NOT NULL,
    [MORTGAGE_PAYMENT_DELAY]                 VARCHAR (8)      NOT NULL,
    [MORTGAGE_RATE_CHANGE_FREQUENCY]         INT              NOT NULL,
    [MORTGAGE_TRANCHE_TYPE]                  VARCHAR (8)      NOT NULL,
    [MATURITY_REFUND_TYPE]                   VARCHAR (18)     NOT NULL,
    [NOMINAL_PAYMENT_DAY]                    INT              NOT NULL,
    [PENULTIMATE_COUPON_DATE]                VARCHAR (10)     NOT NULL,
    [REDEMPTION_VALUE]                       DECIMAL (26, 6)  NOT NULL,
    [UNDERLYING_REFERENCE_INDEX]             VARCHAR (30)     NOT NULL,
    [RESET_FREQUENCY]                        INT              NOT NULL,
    [RESET_INDEX]                            VARCHAR (15)     NOT NULL,
    [SINK_TYPE]                              VARCHAR (10)     NOT NULL,
    [SINKABLE_INDICATOR]                     VARCHAR (1)      NOT NULL,
    [STEPUP_STEPDOWN_COUPON]                 DECIMAL (26, 6)  NOT NULL,
    [STEPUP_STEPDOWN_COUPON_DATE]            VARCHAR (10)     NOT NULL,
    [STRUCTURED_NOTE_INDICATOR]              VARCHAR (1)      NOT NULL,
    [LOWER_TIER2_CAPITAL_INDICATOR]          VARCHAR (1)      NOT NULL,
    [TIER1_CAPITAL_INDICATOR]                VARCHAR (1)      NOT NULL,
    [TIER2_CAPITAL_NON_SPECIFIC_INDICATOR]   VARCHAR (1)      NOT NULL,
    [UPPER_TIER2_CAPITAL_INDICATOR]          VARCHAR (1)      NOT NULL,
    [EX_DIVIDEND_DAYS]                       INT              NOT NULL,
    [EX_DIVIDEND_DAYS_CALENDAR_CODE]         VARCHAR (8)      NOT NULL,
    [SUBORDINATE_TYPE]                       VARCHAR (6)      NOT NULL,
    [SENIORITY_LEVEL_2]                      VARCHAR (5)      NOT NULL,
    [DIVIDEND_CCY]                           VARCHAR (10)     NOT NULL,
    [WITHHOLDING_TAX]                        VARCHAR (MAX)    NOT NULL,
    [EQUITY_UNDERLYING_TICKER]               VARCHAR (26)     NOT NULL
);

