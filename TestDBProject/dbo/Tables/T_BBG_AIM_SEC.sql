﻿CREATE TABLE [dbo].[T_BBG_AIM_SEC] (
    [FILE_NAME]                                    VARCHAR (50)    NULL,
    [FILE_DATE]                                    DATETIME        NULL,
    [FILE_TYPE]                                    VARCHAR (20)    NULL,
    [NUMBER_OF_RECORDS]                            INT             NULL,
    [SECURITY_IDENTIFIER_FLAG]                     INT             NULL,
    [FIRM_IDENTIFIER]                              VARCHAR (12)    NULL,
    [TICKER]                                       VARCHAR (8)     NULL,
    [COUNTRY]                                      VARCHAR (50)    NULL,
    [COUNTRY_RAW]                                  VARCHAR (50)    NULL,
    [CURRENCY]                                     VARCHAR (3)     NULL,
    [CURRENCY_RAW]                                 VARCHAR (50)    NULL,
    [PRPL_INDICATOR]                               VARCHAR (1)     NULL,
    [MATURITY]                                     DATETIME        NULL,
    [ISSUER]                                       VARCHAR (80)    NULL,
    [AMOUNT_OUTSTANDING]                           DECIMAL (20, 2) NULL,
    [AMOUNT_ISSUED]                                DECIMAL (20, 2) NULL,
    [NAME]                                         VARCHAR (80)    NULL,
    [UNDERLYING_CUSIP]                             VARCHAR (9)     NULL,
    [EXPIRATION_DATE_OPT]                          DATETIME        NULL,
    [FITCH_RATING]                                 VARCHAR (10)    NULL,
    [MOODYS_RATING]                                VARCHAR (13)    NULL,
    [ISIN_NUMBER]                                  VARCHAR (12)    NULL,
    [UNIQUE_IDENTIFIER]                            VARCHAR (30)    NOT NULL,
    [IPO]                                          VARCHAR (4)     NULL,
    [SEDOL1_NUMBER]                                VARCHAR (7)     NULL,
    [SEDOL2_NUMBER]                                VARCHAR (7)     NULL,
    [DIVIDEND_EX_DATE]                             DATETIME        NULL,
    [DIVIDEND_FREQUENCY]                           VARCHAR (8)     NULL,
    [DIVIDEND_PAY_DATE]                            DATETIME        NULL,
    [DIVIDEND_CURRENCY]                            VARCHAR (5)     NULL,
    [ISO_COUNTRY_OF_ISSUE]                         VARCHAR (4)     NULL,
    [EXCHANGE_CODE]                                VARCHAR (18)    NULL,
    [TICKER_AND_EXCHANGE_CODE]                     VARCHAR (12)    NULL,
    [LONG_EXCHANGE_NAME]                           VARCHAR (30)    NULL,
    [COUNTRY_FULL_NAME]                            VARCHAR (30)    NULL,
    [COUNTRY_ISO_CODE]                             VARCHAR (4)     NULL,
    [COUNTRY_OF_DOMICILE]                          VARCHAR (4)     NULL,
    [NUMERIC_COUNTRY_CODE]                         INT             NULL,
    [SECURITY_NAME]                                VARCHAR (30)    NULL,
    [SHORT_NAME]                                   VARCHAR (30)    NULL,
    [SECURITY_DESCRIPTION]                         VARCHAR (30)    NULL,
    [PARSKEYEABLE_DESCRIPTION]                     VARCHAR (30)    NULL,
    [CUSIP_NUMBER]                                 VARCHAR (9)     NULL,
    [VALOREN_NUMBER]                               VARCHAR (12)    NULL,
    [WERTPAPIER_NUMBER]                            VARCHAR (8)     NULL,
    [SECTOR]                                       VARCHAR (20)    NULL,
    [MARKET_SECTOR_DESCRIPTION]                    VARCHAR (8)     NULL,
    [MARKET_SECTOR_NUMBER]                         INT             NULL,
    [CUSTOM_SECTOR_NAME]                           VARCHAR (30)    NULL,
    [CUSTOM_SECTOR_GROUP_NAME]                     VARCHAR (30)    NULL,
    [TRADING_SYSTEM_INDUSTRY_CODE]                 DECIMAL (9, 2)  NULL,
    [SECURITY_TYPE]                                VARCHAR (30)    NULL,
    [ASSET_TYPE]                                   VARCHAR (50)    NULL,
    [MARKET_SECTOR_TWO]                            VARCHAR (20)    NULL,
    [SUBSECTOR]                                    VARCHAR (20)    NULL,
    [CUSTOM_SECTOR_LEVEL_1_NAME]                   VARCHAR (30)    NULL,
    [CUSTOM_SECTOR_LEVEL_2_NAME]                   VARCHAR (30)    NULL,
    [CUSTOM_SECTOR_LEVEL_3_NAME]                   VARCHAR (30)    NULL,
    [COUNTRY_OF_INCORPORATION]                     VARCHAR (4)     NULL,
    [CUSIPIDENTIFIER_NUMBER]                       VARCHAR (9)     NULL,
    [SECURITY_IDENTIFIER]                          INT             NULL,
    [IRISH_SEDOL_NUMBER]                           VARCHAR (8)     NULL,
    [CURRENT_SHARES_OUTSTANDING]                   DECIMAL (19, 2) NULL,
    [CURRENT_SHARES_OUTSTANDING_DATE]              DATETIME        NULL,
    [CURRENT_SHARES_OUTSTANDING_ACTUAL]            DECIMAL (19, 2) NULL,
    [TOTAL_VOTING_SHARES_VALUE]                    DECIMAL (33, 2) NULL,
    [PRIMARY_EXCHANGE_NAME]                        VARCHAR (30)    NULL,
    [LAST_PUB_OFFER_NUMBER_OF_SHARES]              DECIMAL (17, 2) NULL,
    [TRADER_NAME]                                  VARCHAR (30)    NULL,
    [CURRENT_SHARES_OUTSTANDING_REAL_VALUE]        DECIMAL (33, 2) NULL,
    [PRIMARY_EXCHANGE_MIC]                         VARCHAR (4)     NULL,
    [CLOSING_PRICE_1_DAY_AGO]                      DECIMAL (15, 2) NULL,
    [CUSIP_8_CHARACTERS_ONLY]                      VARCHAR (8)     NULL,
    [CURRENT_MARKET_CAP]                           DECIMAL (17, 2) NULL,
    [COUNTRY_OF_RISK]                              VARCHAR (4)     NULL,
    [STATE_CODE]                                   VARCHAR (8)     NULL,
    [TRADING_STATUS]                               VARCHAR (4)     NULL,
    [144A_ELIGIBLE_INDICATOR]                      VARCHAR (4)     NULL,
    [SHORT_SELLING_REGULATION_LIQUIDITY_INDICATOR] VARCHAR (4)     NULL,
    [QUOTE_TYPE]                                   INT             NULL,
    [DAYS_TO_SETTLE]                               INT             NULL,
    [CDR_SETTLE_CODE]                              VARCHAR (4)     NULL,
    [DIVIDEND_PER_SHARE_LAST_NET]                  DECIMAL (21, 2) NULL,
    [DIVIDEND_PER_SHARE_LAST_GROSS]                DECIMAL (21, 2) NULL,
    [DIVIDEND_PER_SHARE_IND_ANNUAL__GROSS]         DECIMAL (17, 2) NULL,
    [DIVIDEND_TYPE]                                VARCHAR (30)    NULL,
    [DIVIDEND_RECORD_DATE]                         DATETIME        NULL,
    [CURRENT_STOCK_DIVIDEND_EX_DATE]               DATETIME        NULL,
    [CURRENT_STOCK_DIVIDEND_PAY_DATE]              DATETIME        NULL,
    [CURRENT_STOCK_DIVIDEND_PERCENT]               VARCHAR (10)    NULL,
    [VWAP_VOL_WEIGHTED_AVERAGE_PRICE]              DECIMAL (17, 2) NULL,
    [NET_ASSET_VALUE_NAV]                          DECIMAL (17, 2) NULL,
    [FUND_TOTAL_ASSETS]                            DECIMAL (17, 2) NULL,
    [LAST_UPDATE_DATE_EXCHANGE_TIMEZONE]           DATETIME        NULL,
    [OPTION_ROOT_TICKER]                           VARCHAR (10)    NULL,
    [CALLPUT]                                      VARCHAR (8)     NULL,
    [FUTURES_CONTRACT_EXPIRATION_DATE]             VARCHAR (7)     NULL,
    [CONTRACT_SIZE]                                DECIMAL (21, 2) NULL,
    [FUTURES_CATEGORY_TYPE]                        VARCHAR (30)    NULL,
    [EXPIRATION_DATE_WRT]                          DATETIME        NULL,
    [EXERCISE_TYPE_OPT]                            VARCHAR (8)     NULL,
    [EXERCISE_TYPE_WRT]                            VARCHAR (8)     NULL,
    [DELTA_BEST_PRICE]                             DECIMAL (11, 2) NULL,
    [GAMMA_USING_BEST_PRICE]                       DECIMAL (15, 2) NULL,
    [THETA]                                        DECIMAL (16, 2) NULL,
    [VEGA_BEST_PRICE]                              DECIMAL (11, 2) NULL,
    [EURO_FUTURE_INDICATOR]                        VARCHAR (4)     NULL,
    [CONVERSION_FACTOR]                            DECIMAL (13, 2) NULL,
    [CHEAPEST_TO_DELIVER_CNV_DURATION]             DECIMAL (15, 2) NULL,
    [CHEAPEST_TO_DELIVER_ISIN]                     VARCHAR (12)    NULL,
    [BEARER_CHEAPEST_TO_DELIVER_SEDOL]             VARCHAR (8)     NULL,
    [CHEAPEST_TO_DELIVER_RISK_TYPE]                VARCHAR (20)    NULL,
    [DAYS_UNTIL_EXPIRATION_DATE_OF_FUTURES]        INT             NULL,
    [LONG_FUTURE_NAME]                             VARCHAR (30)    NULL,
    [STRIKE_PRICE_OPT]                             DECIMAL (19, 2) NULL,
    [STRIKE_PRICE_FXOPT]                           DECIMAL (13, 2) NULL,
    [TICK_SIZE]                                    DECIMAL (15, 2) NULL,
    [ISSUE_DATE]                                   DATETIME        NULL,
    [COUPON]                                       DECIMAL (18, 2) NULL,
    [COUPON_FREQUENCY]                             INT             NULL,
    [COUPON_TYPE]                                  VARCHAR (24)    NULL,
    [CONVERTIBLE_INDICATOR]                        VARCHAR (4)     NULL,
    [COUPON_CAP]                                   DECIMAL (13, 2) NULL,
    [COUPON_CURRENCY]                              VARCHAR (8)     NULL,
    [COUPON_FLOOR]                                 DECIMAL (13, 2) NULL,
    [ISSUE_PRICE]                                  DECIMAL (21, 2) NULL,
    [DAY_COUNT]                                    INT             NULL,
    [REAL_FIRST_COUPON_DATE]                       DATETIME        NULL,
    [FIRST_SETTLE_DATE]                            DATETIME        NULL,
    [PREVIOUS_COUPON_SETTLE_DATE]                  DATETIME        NULL,
    [NEXT_COUPON_SETTLE_DATE]                      DATETIME        NULL,
    [NEXT_CALL_DATE]                               DATETIME        NULL,
    [NEXT_CALL_PRICE]                              DECIMAL (15, 2) NULL,
    [LAST_RESET_DATE]                              DATETIME        NULL,
    [NEXT_RESET_DATE]                              DATETIME        NULL,
    [SECOND_COUPON_DATE]                           DATETIME        NULL,
    [FIXED_COUPON_INDICATOR]                       VARCHAR (4)     NULL,
    [FIX_TO_FLOAT_INDICATOR]                       VARCHAR (4)     NULL,
    [FLOATER_INDICATOR]                            VARCHAR (4)     NULL,
    [FLOAT_TO_FIX_INDICATOR]                       VARCHAR (4)     NULL,
    [INFLATIONLINKED_INDICATOR]                    VARCHAR (4)     NULL,
    [PERPETUAL_INDICATOR]                          VARCHAR (4)     NULL,
    [ZERO_COUPON_INDICATOR]                        VARCHAR (4)     NULL,
    [ACCRUED_INTEREST100]                          DECIMAL (21, 2) NULL,
    [INTEREST_ACCRUAL_DATE]                        DATETIME        NULL,
    [COLLATERAL_TYPE]                              VARCHAR (30)    NULL,
    [AGGREGATE_AMOUNT_ISSUED_INDICATOR]            VARCHAR (4)     NULL,
    [ASSUMED_INDEX]                                DECIMAL (17, 2) NULL,
    [BRADY_BOND_INDICATOR]                         VARCHAR (4)     NULL,
    [CALCULATION_TYPE]                             INT             NULL,
    [CALL_INDICATOR]                               VARCHAR (4)     NULL,
    [BOND_CALLED_INDICATOR]                        VARCHAR (4)     NULL,
    [CALL_SCHEDULE__DAYS_NOTICE]                   INT             NULL,
    [PUT_INDICATOR]                                VARCHAR (4)     NULL,
    [PUT_SCHEDULE__DAYS_NOTICE]                    INT             NULL,
    [IS_CASH_SETTLED__INDICATOR]                   VARCHAR (4)     NULL,
    [CDS_RECOVERY_RATE]                            DECIMAL (8, 2)  NULL,
    [FIX_TO_FLOAT_COUPON_FREQUENCY]                INT             NULL,
    [DEFAULTED_INDICATOR]                          VARCHAR (4)     NULL,
    [EXCHANGEABLE_INDICATOR]                       VARCHAR (4)     NULL,
    [LOCKOUT_PERIOD]                               INT             NULL,
    [JUNIOR]                                       VARCHAR (4)     NULL,
    [SENIOR]                                       VARCHAR (4)     NULL,
    [REGULATION_S_INDICATOR]                       VARCHAR (4)     NULL,
    [SUBORDINATED_INDICATOR]                       VARCHAR (4)     NULL,
    [UNIT_TRADED_INDICATOR]                        VARCHAR (4)     NULL,
    [LOAN_PARTICIPATION_NOTE_INDICATOR]            VARCHAR (4)     NULL,
    [ORIGINAL_ISSUE_DISCOUNT_SECURITY]             VARCHAR (4)     NULL,
    [GILT_DIGITS]                                  INT             NULL,
    [EXDIVIDEND_DATE__GILTS]                       DATETIME        NULL,
    [INDEX_RATIO__CPI]                             DECIMAL (15, 2) NULL,
    [MINIMUM_INCREMENT]                            DECIMAL (22, 2) NULL,
    [MOST_RECENTLY_REPORTED_FACTOR]                DECIMAL (23, 2) NULL,
    [MOST_RECENT_ACCRUAL_RATE]                     DECIMAL (19, 2) NULL,
    [MOST_RECENT_ACCR._RT_START_DATE]              DATETIME        NULL,
    [MTGE_DEAL_CALL_DATE]                          DATETIME        NULL,
    [MTGE_END_PRINCIPAL_WINDOWMATURITY]            DATETIME        NULL,
    [MORTGAGE_FACTOR_DATE]                         VARCHAR (10)    NULL,
    [MTGE_CURRENT_PAYMENT_DATE]                    DATETIME        NULL,
    [MTGE_FINAL_PAYMENT_DATE]                      DATETIME        NULL,
    [MTGE_FIRST_PAYMENT_DATE]                      DATETIME        NULL,
    [LIFE_FLOOR]                                   DECIMAL (15, 2) NULL,
    [MORTGAGE_PAYMENT_DELAY]                       VARCHAR (8)     NULL,
    [RATE_CHANGE_FREQUENCY]                        VARCHAR (10)    NULL,
    [MORTGAGE_TRANCHE_TYPE]                        VARCHAR (8)     NULL,
    [MATURITY__REFUND_TYPE]                        VARCHAR (18)    NULL,
    [NOMINAL_PAYMENT_DAY]                          INT             NULL,
    [PENULTIMATE_COUPON_DATE]                      DATETIME        NULL,
    [REDEMPTION_VALUE]                             DECIMAL (19, 2) NULL,
    [UNDERLYING_REFERENCE_INDEX]                   VARCHAR (30)    NULL,
    [RESET_FREQUENCY]                              DECIMAL (10, 2) NULL,
    [RESET_INDEX]                                  VARCHAR (15)    NULL,
    [SINK_TYPE]                                    VARCHAR (10)    NULL,
    [SINK_INDICATOR]                               VARCHAR (4)     NULL,
    [STEPUP_STEPDOWN_COUPON]                       DECIMAL (15, 2) NULL,
    [STEPUP_STEPDOWN_DATE]                         DATETIME        NULL,
    [STRUCTURED_NOTE_INDICATOR]                    VARCHAR (4)     NULL,
    [LOWER_TIER_2_CAPITAL_INDICATOR]               VARCHAR (4)     NULL,
    [TIER_1_CAPITAL_INDICATOR]                     VARCHAR (4)     NULL,
    [TIER_2_CAPITAL_NONSPECIFIC_INDICATOR]         VARCHAR (4)     NULL,
    [UPPER_TIER_2_CAPITAL_INDICATOR]               VARCHAR (4)     NULL,
    [EX_DIV_DAYS]                                  INT             NULL,
    [EX_DIVIDEND_CALENDAR]                         VARCHAR (8)     NULL,
    [SECURITY_SUB_FLAG]                            VARCHAR (20)    NULL,
    [SECURITY_HAS_ADRS]                            VARCHAR (4)     NULL,
    [VOLUME_AVG_5D]                                DECIMAL (26, 6) NULL,
    [VOLUME_AVG_20D]                               DECIMAL (26, 6) NULL,
    [ADV_TOTAL_VOLUME]                             DECIMAL (19, 2) NULL,
    [CADIS_SYSTEM_INSERTED]                        DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                         DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                       NVARCHAR (50)   DEFAULT ('UNKOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                        INT             DEFAULT ((1)) NULL,
    PRIMARY KEY CLUSTERED ([UNIQUE_IDENTIFIER] ASC) WITH (FILLFACTOR = 80)
);

