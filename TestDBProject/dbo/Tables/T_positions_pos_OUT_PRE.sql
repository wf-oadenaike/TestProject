﻿CREATE TABLE [dbo].[T_positions_pos_OUT_PRE] (
    [CADIS_BATCH_ID]                         INT            NOT NULL,
    [CADIS_MSG_ID]                           INT            DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]                        INT            NOT NULL,
    [CADIS_ROW_ID]                           INT            NOT NULL,
    [RowNumber]                              NVARCHAR (MAX) NULL,
    [PositionDate]                           NVARCHAR (MAX) NULL,
    [AssetName]                              NVARCHAR (MAX) NULL,
    [CompanyType]                            NVARCHAR (MAX) NULL,
    [SOURCE]                                 NVARCHAR (MAX) NULL,
    [POSITION_TYPE]                          NVARCHAR (MAX) NULL,
    [EDM_SEC_ID]                             NVARCHAR (MAX) NULL,
    [FUND_SHORT_NAME]                        NVARCHAR (MAX) NULL,
    [LONG_SHORT_IND]                         NVARCHAR (MAX) NULL,
    [POSITION_DATE]                          NVARCHAR (MAX) NULL,
    [PRICE]                                  NVARCHAR (MAX) NULL,
    [QUANTITY]                               NVARCHAR (MAX) NULL,
    [SECURITY_NAME]                          NVARCHAR (MAX) NULL,
    [SECURITY_DESCRIPTION]                   NVARCHAR (MAX) NULL,
    [SECURITY_SHORTNAME]                     NVARCHAR (MAX) NULL,
    [ASSET_TYPE]                             NVARCHAR (MAX) NULL,
    [SECURITY_TYPE]                          NVARCHAR (MAX) NULL,
    [CUSIP]                                  NVARCHAR (MAX) NULL,
    [ISIN]                                   NVARCHAR (MAX) NULL,
    [SEDOL]                                  NVARCHAR (MAX) NULL,
    [TICKER]                                 NVARCHAR (MAX) NULL,
    [VALOREN]                                NVARCHAR (MAX) NULL,
    [WERTPAPIER]                             NVARCHAR (MAX) NULL,
    [SECURITY_ISO_CCY]                       NVARCHAR (MAX) NULL,
    [RISK_ISO_CCY]                           NVARCHAR (MAX) NULL,
    [FIXED_ISO_CCY]                          NVARCHAR (MAX) NULL,
    [INCORPORATION_ISO_CTY]                  NVARCHAR (MAX) NULL,
    [DOMICILE_ISO_CTY]                       NVARCHAR (MAX) NULL,
    [ISSUE_COUNTRY_ISO]                      NVARCHAR (MAX) NULL,
    [RISK_ISO_CTY]                           NVARCHAR (MAX) NULL,
    [MIC_EXCHANGE_CODE]                      NVARCHAR (MAX) NULL,
    [BBG_EXCHANGE_CODE]                      NVARCHAR (MAX) NULL,
    [STATE_CODE]                             NVARCHAR (MAX) NULL,
    [ACTIVE_TRADE_INDICATOR]                 NVARCHAR (MAX) NULL,
    [_x0031_44A_INDICATOR]                   NVARCHAR (MAX) NULL,
    [PRIVATE_PLACEMENT_INDICATOR]            NVARCHAR (MAX) NULL,
    [ILLIQUID]                               NVARCHAR (MAX) NULL,
    [QUOTE_TYPE]                             NVARCHAR (MAX) NULL,
    [DAYS_TO_SETTLE]                         NVARCHAR (MAX) NULL,
    [TRADE_SETTLEMENT_CALENDAR_CODE]         NVARCHAR (MAX) NULL,
    [UNIQUE_BLOOMBERG_ID]                    NVARCHAR (MAX) NULL,
    [BBG_SECTOR]                             NVARCHAR (MAX) NULL,
    [BBG_SUBSECTOR]                          NVARCHAR (MAX) NULL,
    [BBG_GROUP]                              NVARCHAR (MAX) NULL,
    [IS_IPO]                                 NVARCHAR (MAX) NULL,
    [PARSEKEYABLE_DESCRIPTION]               NVARCHAR (MAX) NULL,
    [SECURITY_IDENTIFIER]                    NVARCHAR (MAX) NULL,
    [IRISH_SEDOL_NUMBER]                     NVARCHAR (MAX) NULL,
    [PRIMARY_EXCHANGE_NAME]                  NVARCHAR (MAX) NULL,
    [ISSUER]                                 NVARCHAR (MAX) NULL,
    [SECURITY_HAS_ADRS]                      NVARCHAR (MAX) NULL,
    [EX_DIVIDEND_DATE]                       NVARCHAR (MAX) NULL,
    [DIVIDEND_FREQUENCY]                     NVARCHAR (MAX) NULL,
    [DIVIDEND_PAY_DATE]                      NVARCHAR (MAX) NULL,
    [DIVIDEND_PER_SHARE_LAST_NET]            NVARCHAR (MAX) NULL,
    [DIVIDEND_PER_SHARE_LAST_GROSS]          NVARCHAR (MAX) NULL,
    [DIVIDEND_PER_SHARE_ANNUAL_GROSS]        NVARCHAR (MAX) NULL,
    [DIVIDEND_TYPE]                          NVARCHAR (MAX) NULL,
    [DIVIDEND_RECORD_DATE]                   NVARCHAR (MAX) NULL,
    [CURRENT_STOCK_DIVIDEND_EX_DATE]         NVARCHAR (MAX) NULL,
    [CURRENT_STOCK_DIVIDEND_PAY_DATE]        NVARCHAR (MAX) NULL,
    [CURRENT_STOCK_DIVIDEND_PCT]             NVARCHAR (MAX) NULL,
    [NORMAL_MARKET_SIZE]                     NVARCHAR (MAX) NULL,
    [SHARES_OUTSTANDING]                     NVARCHAR (MAX) NULL,
    [SHARES_OUTSTANDING_DATE]                NVARCHAR (MAX) NULL,
    [IPO]                                    NVARCHAR (MAX) NULL,
    [VOL_WEIGHTED_AVERAGE_PRICE]             NVARCHAR (MAX) NULL,
    [FUND_NET_ASSET_VALUE]                   NVARCHAR (MAX) NULL,
    [FUND_TOTAL_ASSETS]                      NVARCHAR (MAX) NULL,
    [LAST_UPDATE_DATE_EXCHANGE_TIMEZONE]     NVARCHAR (MAX) NULL,
    [TOTAL_VOTING_SHARES]                    NVARCHAR (MAX) NULL,
    [SHARE_OUTSTANDING_REAL_ACTUAL]          NVARCHAR (MAX) NULL,
    [TOTAL_VOTING_SHARES_VALUE]              NVARCHAR (MAX) NULL,
    [LAST_PUBLISHED_OFFER_NO_OF_SHARES]      NVARCHAR (MAX) NULL,
    [SHARE_OUTSTANDING_REAL_VALUE]           NVARCHAR (MAX) NULL,
    [CUR_MAR_CAP]                            NVARCHAR (MAX) NULL,
    [OPTION_ROOT_TICKER]                     NVARCHAR (MAX) NULL,
    [PUT_CALL_INDICATOR]                     NVARCHAR (MAX) NULL,
    [EXPIRY_DATE]                            NVARCHAR (MAX) NULL,
    [FUTURE_EXPIRY_MONTH_YEAR]               NVARCHAR (MAX) NULL,
    [EXERCISE_TYPE]                          NVARCHAR (MAX) NULL,
    [CONTRACT_SIZE]                          NVARCHAR (MAX) NULL,
    [CONTRACT_VALUE]                         NVARCHAR (MAX) NULL,
    [FUTURE_TYPE]                            NVARCHAR (MAX) NULL,
    [LAST_TRADE_DATE]                        NVARCHAR (MAX) NULL,
    [LONG_EXCHANGE_NAME]                     NVARCHAR (MAX) NULL,
    [DELTA]                                  NVARCHAR (MAX) NULL,
    [GAMMA]                                  NVARCHAR (MAX) NULL,
    [THETA]                                  NVARCHAR (MAX) NULL,
    [VEGA]                                   NVARCHAR (MAX) NULL,
    [EURO_FUTURE_INDICATOR]                  NVARCHAR (MAX) NULL,
    [CONVERSION_FACTOR]                      NVARCHAR (MAX) NULL,
    [CTD_CONVERSION_DURATION]                NVARCHAR (MAX) NULL,
    [CTD_ISIN]                               NVARCHAR (MAX) NULL,
    [CTD_SEDOL]                              NVARCHAR (MAX) NULL,
    [CTD_RISK_TYPE]                          NVARCHAR (MAX) NULL,
    [FUTURE_DAYS_TO_EXPIRY]                  NVARCHAR (MAX) NULL,
    [FUTURE_LONGNAME]                        NVARCHAR (MAX) NULL,
    [STRIKE_PRICE]                           NVARCHAR (MAX) NULL,
    [TICK_SIZE]                              NVARCHAR (MAX) NULL,
    [ISSUE_DATE]                             NVARCHAR (MAX) NULL,
    [MATURITY_DATE]                          NVARCHAR (MAX) NULL,
    [COUPON_RATE]                            NVARCHAR (MAX) NULL,
    [COUPON_FREQUENCY]                       NVARCHAR (MAX) NULL,
    [COUPON_TYPE]                            NVARCHAR (MAX) NULL,
    [CONVERTIBLE_INDICATOR]                  NVARCHAR (MAX) NULL,
    [IsConvertiblePreferred]                 NVARCHAR (MAX) NULL,
    [AMOUNT_ISSUED]                          NVARCHAR (MAX) NULL,
    [AMOUNT_OUTSTANDING]                     NVARCHAR (MAX) NULL,
    [COUPON_CAP]                             NVARCHAR (MAX) NULL,
    [COUPON_ISO_CCY]                         NVARCHAR (MAX) NULL,
    [COUPON_FLOOR]                           NVARCHAR (MAX) NULL,
    [ISSUE_PRICE]                            NVARCHAR (MAX) NULL,
    [DAY_COUNT]                              NVARCHAR (MAX) NULL,
    [FIRST_COUPON_DATE]                      NVARCHAR (MAX) NULL,
    [FIRST_SETTLE_DATE]                      NVARCHAR (MAX) NULL,
    [PREVIOUS_COUPON_DATE]                   NVARCHAR (MAX) NULL,
    [NEXT_COUPON_DATE]                       NVARCHAR (MAX) NULL,
    [NEXT_CALL_DATE]                         NVARCHAR (MAX) NULL,
    [NEXT_CALL_PRICE]                        NVARCHAR (MAX) NULL,
    [LAST_RESET_DATE]                        NVARCHAR (MAX) NULL,
    [NEXT_RESET_DATE]                        NVARCHAR (MAX) NULL,
    [SECOND_COUPON_DATE]                     NVARCHAR (MAX) NULL,
    [FIXED_INDICATOR]                        NVARCHAR (MAX) NULL,
    [FIX_TO_FLOAT_INDICATOR]                 NVARCHAR (MAX) NULL,
    [FLOATER_INDICATOR]                      NVARCHAR (MAX) NULL,
    [FLOAT_TO_FIX_INDICATOR]                 NVARCHAR (MAX) NULL,
    [INDEX_LINKED_INDICATOR]                 NVARCHAR (MAX) NULL,
    [INFLATION_LINKED_INDICATOR]             NVARCHAR (MAX) NULL,
    [PERPETUAL_INDICATOR]                    NVARCHAR (MAX) NULL,
    [ZERO_COUPON_INDICATOR]                  NVARCHAR (MAX) NULL,
    [ACCRUED_INTEREST_PER_100]               NVARCHAR (MAX) NULL,
    [ACCRUED_INTEREST_DATE]                  NVARCHAR (MAX) NULL,
    [COLLATERAL_TYPE]                        NVARCHAR (MAX) NULL,
    [AGGREGATE_AMOUNT_ISSUED_INDICATOR]      NVARCHAR (MAX) NULL,
    [ASSUMED_INDEX_VALUE]                    NVARCHAR (MAX) NULL,
    [BRADY_INDICATOR]                        NVARCHAR (MAX) NULL,
    [CALCULATION_TYPE]                       NVARCHAR (MAX) NULL,
    [CALLABLE_INDICATOR]                     NVARCHAR (MAX) NULL,
    [CALLED_INDICATOR]                       NVARCHAR (MAX) NULL,
    [CALL_DAYS_NOTICE]                       NVARCHAR (MAX) NULL,
    [PUTABLE_INDICATOR]                      NVARCHAR (MAX) NULL,
    [PUT_DAYS_NOTICE]                        NVARCHAR (MAX) NULL,
    [CASH_SETTLED_INDICATOR]                 NVARCHAR (MAX) NULL,
    [CDS_RECOVERY_RATE]                      NVARCHAR (MAX) NULL,
    [CORPORATE_TO_EQUITY_TICKER]             NVARCHAR (MAX) NULL,
    [FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE]    NVARCHAR (MAX) NULL,
    [DEFAULTED_INDICATOR]                    NVARCHAR (MAX) NULL,
    [EXCHANGEABLE_INDICATOR]                 NVARCHAR (MAX) NULL,
    [FLOATER_COUPON_CONVENTION]              NVARCHAR (MAX) NULL,
    [FLOATER_LOCKOUT_PERIOD]                 NVARCHAR (MAX) NULL,
    [FLOATER_PAY_DAY]                        NVARCHAR (MAX) NULL,
    [JUNIOR_INDICATOR]                       NVARCHAR (MAX) NULL,
    [SENIOR_INDICATOR]                       NVARCHAR (MAX) NULL,
    [REGULATION_S_INDICATOR]                 NVARCHAR (MAX) NULL,
    [SUBORDINATED_INDICATOR]                 NVARCHAR (MAX) NULL,
    [UNIT_TRADED_INDICATOR]                  NVARCHAR (MAX) NULL,
    [LOAN_PARTICIPATION_NOTE_INDICATOR]      NVARCHAR (MAX) NULL,
    [ORIGINAL_ISSUE_DISCOUNT_INDICATOR]      NVARCHAR (MAX) NULL,
    [GILT_DIGITS]                            NVARCHAR (MAX) NULL,
    [GILTS_EX_DIVIDEND_DATE]                 NVARCHAR (MAX) NULL,
    [INDEX_RATIO_CPI]                        NVARCHAR (MAX) NULL,
    [MINIMUM_INCREMENT]                      NVARCHAR (MAX) NULL,
    [MINIMUM_PIECE]                          NVARCHAR (MAX) NULL,
    [MOST_RECENT_REPORTED_FACTOR]            NVARCHAR (MAX) NULL,
    [MOST_RECENT_ACCRUAL_RATE]               NVARCHAR (MAX) NULL,
    [MOST_RECENT_ACCRUAL_RATE_START_DATE]    NVARCHAR (MAX) NULL,
    [MORTGAGE_DEAL_CALL_DATE]                NVARCHAR (MAX) NULL,
    [MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY] NVARCHAR (MAX) NULL,
    [MORTGAGE_FACTOR_DATE]                   NVARCHAR (MAX) NULL,
    [MORTGAGE_CURRENT_PAYMENT_RATE]          NVARCHAR (MAX) NULL,
    [MORTGAGE_FINAL_PAY_DATE]                NVARCHAR (MAX) NULL,
    [MORTGAGE_FIRST_PAY_DATE]                NVARCHAR (MAX) NULL,
    [MORTGAGE_LIFE_FLOOR]                    NVARCHAR (MAX) NULL,
    [MORTGAGE_PAYMENT_DELAY]                 NVARCHAR (MAX) NULL,
    [MORTGAGE_RATE_CHANGE_FREQUENCY]         NVARCHAR (MAX) NULL,
    [MORTGAGE_TRANCHE_TYPE]                  NVARCHAR (MAX) NULL,
    [MATURITY_REFUND_TYPE]                   NVARCHAR (MAX) NULL,
    [NOMINAL_PAYMENT_DAY]                    NVARCHAR (MAX) NULL,
    [PENULTIMATE_COUPON_DATE]                NVARCHAR (MAX) NULL,
    [REDEMPTION_VALUE]                       NVARCHAR (MAX) NULL,
    [UNDERLYING_REFERENCE_INDEX]             NVARCHAR (MAX) NULL,
    [RESET_FREQUENCY]                        NVARCHAR (MAX) NULL,
    [RESET_INDEX]                            NVARCHAR (MAX) NULL,
    [SINK_TYPE]                              NVARCHAR (MAX) NULL,
    [SINKABLE_INDICATOR]                     NVARCHAR (MAX) NULL,
    [STEPUP_STEPDOWN_COUPON]                 NVARCHAR (MAX) NULL,
    [STEPUP_STEPDOWN_COUPON_DATE]            NVARCHAR (MAX) NULL,
    [STRUCTURED_NOTE_INDICATOR]              NVARCHAR (MAX) NULL,
    [LOWER_TIER2_CAPITAL_INDICATOR]          NVARCHAR (MAX) NULL,
    [TIER1_CAPITAL_INDICATOR]                NVARCHAR (MAX) NULL,
    [TIER2_CAPITAL_NON_SPECIFIC_INDICATOR]   NVARCHAR (MAX) NULL,
    [UPPER_TIER2_CAPITAL_INDICATOR]          NVARCHAR (MAX) NULL,
    [EX_DIVIDEND_DAYS]                       NVARCHAR (MAX) NULL,
    [EX_DIVIDEND_DAYS_CALENDAR_CODE]         NVARCHAR (MAX) NULL,
    [SUBORDINATE_TYPE]                       NVARCHAR (MAX) NULL,
    [SENIORITY_LEVEL_2]                      NVARCHAR (MAX) NULL,
    [DIVIDEND_CCY]                           NVARCHAR (MAX) NULL,
    [WITHHOLDING_TAX]                        NVARCHAR (MAX) NULL,
    [EQUITY_UNDERLYING_TICKER]               NVARCHAR (MAX) NULL,
    [pos_InnerText]                          NVARCHAR (MAX) NULL,
    [Component_InstrumentId]                 NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]                  DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                   DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                 NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_RUNID]                     INT            DEFAULT ((0)) NULL,
    [CADIS_SYSTEM_TOPRUNID]                  INT            DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC)
);

