﻿CREATE VIEW "CADIS"."DG_FUNCTION209_RESULTS" AS 
SELECT ET."EDM_SEC_ID",ET."STATUS",ET."DATA_QUALITY",ET."SECURITY_NAME",ET."ASSET_TYPE",ET."SECURITY_TYPE",ET."ISSUE_DATE",ET."SECURITY_DESCRIPTION",ET."SECURITY_SHORTNAME",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."SEDOL",ET."CUSIP",ET."ISIN",ET."VALOREN",ET."WERTPAPIER",ET."TICKER",ET."MIC_EXCHANGE_CODE",ET."SECURITY_ISO_CCY",ET."RISK_ISO_CCY",ET."FIXED_ISO_CCY",ET."INCORPORATION_ISO_CTY",ET."DOMICILE_ISO_CTY",ET."RISK_ISO_CTY",ET."STATE_CODE",ET."ILLIQUID",ET."ACTIVE_TRADE_INDICATOR",ET."144A_INDICATOR",ET."PRIVATE_PLACEMENT_INDICATOR",ET."QUOTE_TYPE",ET."DAYS_TO_SETTLE",ET."TRADE_SETTLEMENT_CALENDAR_CODE",ET."EX_DIVIDEND_DATE",ET."DIVIDEND_FREQUENCY",ET."DIVIDEND_PAY_DATE",ET."DIVIDEND_PER_SHARE_LAST_NET",ET."DIVIDEND_PER_SHARE_LAST_GROSS",ET."DIVIDEND_PER_SHARE_ANNUAL_GROSS",ET."DIVIDEND_TYPE",ET."DIVIDEND_RECORD_DATE",ET."CURRENT_STOCK_DIVIDEND_EX_DATE",ET."CURRENT_STOCK_DIVIDEND_PAY_DATE",ET."CURRENT_STOCK_DIVIDEND_PCT",ET."NORMAL_MARKET_SIZE",ET."SHARES_OUTSTANDING",ET."SHARES_OUTSTANDING_DATE",ET."VOL_WEIGHTED_AVERAGE_PRICE",ET."FUND_NET_ASSET_VALUE",ET."FUND_TOTAL_ASSETS",ET."LAST_UPDATE_DATE_EXCHANGE_TIMEZONE",ET."TOTAL_VOTING_SHARES",ET."MATURITY_DATE",ET."COUPON_RATE",ET."COUPON_FREQUENCY",ET."AMOUNT_ISSUED",ET."AMOUNT_OUTSTANDING",ET."NEXT_COUPON_DATE",ET."NEXT_RESET_DATE",ET."RESET_FREQUENCY",ET."NEXT_CALL_DATE",ET."COUPON_TYPE",ET."CONVERTIBLE_INDICATOR",ET."COUPON_CAP",ET."COUPON_ISO_CCY",ET."COUPON_FLOOR",ET."ISSUE_PRICE",ET."DAY_COUNT",ET."FIRST_COUPON_DATE",ET."FIRST_SETTLE_DATE",ET."PREVIOUS_COUPON_DATE",ET."NEXT_CALL_PRICE",ET."LAST_RESET_DATE",ET."SECOND_COUPON_DATE",ET."FIXED_INDICATOR",ET."FIX_TO_FLOAT_INDICATOR",ET."FLOATER_INDICATOR",ET."FLOAT_TO_FIX_INDICATOR",ET."INDEX_LINKED_INDICATOR",ET."INFLATION_LINKED_INDICATOR",ET."PERPETUAL_INDICATOR",ET."ZERO_COUPON_INDICATOR",ET."ACCRUED_INTEREST_PER_100",ET."ACCRUED_INTEREST_DATE",ET."COLLATERAL_TYPE",ET."AGGREGATE_AMOUNT_ISSUED_INDICATOR",ET."ASSUMED_INDEX_VALUE",ET."BRADY_INDICATOR",ET."CALCULATION_TYPE",ET."CALLABLE_INDICATOR",ET."CALLED_INDICATOR",ET."CALL_DAYS_NOTICE",ET."PUTABLE_INDICATOR",ET."PUT_DAYS_NOTICE",ET."CASH_SETTLED_INDICATOR",ET."CDS_RECOVERY_RATE",ET."CORPORATE_TO_EQUITY_TICKER",ET."FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE",ET."DEFAULTED_INDICATOR",ET."EXCHANGEABLE_INDICATOR",ET."FLOATER_COUPON_CONVENTION",ET."FLOATER_LOCKOUT_PERIOD",ET."FLOATER_PAY_DAY",ET."JUNIOR_INDICATOR",ET."SENIOR_INDICATOR",ET."REGULATION_S_INDICATOR",ET."SUBORDINATED_INDICATOR",ET."UNIT_TRADED_INDICATOR",ET."LOAN_PARTICIPATION_NOTE_INDICATOR",ET."ORIGINAL_ISSUE_DISCOUNT_INDICATOR",ET."GILT_DIGITS",ET."GILTS_EX_DIVIDEND_DATE",ET."INDEX_RATIO_CPI",ET."MINIMUM_INCREMENT",ET."MINIMUM_PIECE",ET."MOST_RECENT_REPORTED_FACTOR",ET."MOST_RECENT_ACCRUAL_RATE",ET."MOST_RECENT_ACCRUAL_RATE_START_DATE",ET."MORTGAGE_DEAL_CALL_DATE",ET."MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY",ET."MORTGAGE_FACTOR_DATE",ET."MORTGAGE_CURRENT_PAYMENT_RATE",ET."MORTGAGE_FINAL_PAY_DATE",ET."MORTGAGE_FIRST_PAY_DATE",ET."MORTGAGE_LIFE_FLOOR",ET."MORTGAGE_PAYMENT_DELAY",ET."MORTGAGE_RATE_CHANGE_FREQUENCY",ET."MORTGAGE_TRANCHE_TYPE",ET."MATURITY_REFUND_TYPE",ET."NOMINAL_PAYMENT_DAY",ET."PENULTIMATE_COUPON_DATE",ET."REDEMPTION_VALUE",ET."UNDERLYING_REFERENCE_INDEX",ET."RESET_INDEX",ET."SINK_TYPE",ET."SINKABLE_INDICATOR",ET."STEPUP_STEPDOWN_COUPON",ET."STEPUP_STEPDOWN_COUPON_DATE",ET."STRUCTURED_NOTE_INDICATOR",ET."LOWER_TIER2_CAPITAL_INDICATOR",ET."TIER1_CAPITAL_INDICATOR",ET."TIER2_CAPITAL_NON_SPECIFIC_INDICATOR",ET."UPPER_TIER2_CAPITAL_INDICATOR",ET."EX_DIVIDEND_DAYS",ET."EX_DIVIDEND_DAYS_CALENDAR_CODE",ET."SUBORDINATE_TYPE",ET."SENIORITY_LEVEL_2",ET."EXPIRY_DATE",ET."FUTURE_TYPE",ET."DELTA",ET."VEGA",ET."GAMMA",ET."THETA",ET."STRIKE_PRICE",ET."OPTION_ROOT_TICKER",ET."PUT_CALL_INDICATOR",ET."FUTURE_EXPIRY_MONTH_YEAR",ET."EXERCISE_TYPE",ET."CONTRACT_SIZE",ET."CONTRACT_VALUE",ET."LAST_TRADE_DATE",ET."LONG_EXCHANGE_NAME",ET."EURO_FUTURE_INDICATOR",ET."CONVERSION_FACTOR",ET."CTD_CONVERSION_DURATION",ET."CTD_ISIN",ET."CTD_SEDOL",ET."CTD_RISK_TYPE",ET."FUTURE_DAYS_TO_EXPIRY",ET."FUTURE_LONGNAME",ET."TICK_SIZE",ET."MARKET_CAP",ET."AVERAGE_VOLUME_100D",ET."AVERAGE_VOLUME_30D",ET."VOTING_RIGHTS",ET."PAR_AMOUNT",ET."OPEN_INTEREST",ET."BASE_ACCRUAL_RATE_DATE",ET."UNDERLYING_BASE_CPI",ET."BASIC_SPREAD_PCT",ET."MID_CONVEXITY",ET."MID_DISCOUNT_MARGIN",ET."MID_DISCOUNT_MARGIN_TO_NEXT_CALL",ET."MID_MODIFIED_DURATION",ET."MID_MACAULAY_DURATION",ET."MID_SPREAD_DURATION",ET."FLOATER_SPREAD_BP",ET."MORTGAGE_GENERIC_CPR_ISSUE",ET."MORTGAGE_GENERIC_PSA_ISSUE",ET."MORTGAGE_ORIGINAL_WAC",ET."MORTGAGE_ORIGINAL_WAM",ET."MORTGAGE_POOL_PSA_ISSUE",ET."MORTGAGE_PRINCIPAL_LOSSES",ET."MORTGAGE_WAL_YEARS",ET."MORTGAGE_WAM_MONTHS",ET."MID_OAS_SPREAD_DURATION",ET."WITHHOLDING_TAX",ET."YIELD_TO_MATURITY",ET."MID_YIELD_TO_CONVENTION",ET."ASK_YIELD_TO_NEXT_CALL",ET."ASK_YIELD_TO_MATURITY",ET."MID_YIELD_TO_MATURITY",ET."MID_Z_SPREAD_BP",ET."ANNUAL_MODIFIED_DURATION",ET."SEMI_ANNUAL_MODIFIED_DURATION",ET."ISMA_MODIFIED_DURATION",ET."MODIFIED_DURATION",ET."ANNUAL_YIELD",ET."SEMI_ANNUAL_YIELD",ET."ISMA_YIELD",ET."OAS",ET."Z_SPREAD",ET."EXPECTED_REMAINING_LIFE",ET."MATURITY_WAL",ET."ISSUE_COUNTRY_ISO",ET."SHARE_OUTSTANDING_REAL_ACTUAL",ET."TOTAL_VOTING_SHARES_VALUE",ET."LAST_PUBLISHED_OFFER_NO_OF_SHARES",ET."SHARE_OUTSTANDING_REAL_VALUE",ET."SECURITY_IDENTIFIER",ET."IRISH_SEDOL_NUMBER",ET."ISSUER",ET."CUR_MAR_CAP",ET."PRIMARY_EXCHANGE_NAME",ET."CURRENT_MARKET_CAP",ET."SECURITY_HAS_ADRS",ET."UNIQUE_BLOOMBERG_ID",ET."PARSEKEYABLE_DESCRIPTION",ET."BBG_EXCHANGE_CODE",ET."EQUITY_UNDERLYING_TICKER",ET."DIVIDEND_CCY" FROM "CADIS"."VW_Master_Security" ET WITH (NOLOCK)
