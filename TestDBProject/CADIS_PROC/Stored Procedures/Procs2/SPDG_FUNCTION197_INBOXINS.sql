﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION197_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @EDM_SEC_ID INT, @CADIS_SYSTEM_INSERTED DATETIME, @CADIS_SYSTEM_INSERTED_UPDATE BIT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @SECURITY_NAME VARCHAR (100), @SECURITY_NAME_UPDATE BIT, @SECURITY_DESCRIPTION VARCHAR (200), @SECURITY_DESCRIPTION_UPDATE BIT, @SECURITY_SHORTNAME VARCHAR (30), @SECURITY_SHORTNAME_UPDATE BIT, @ASSET_TYPE VARCHAR (30), @ASSET_TYPE_UPDATE BIT, @SECURITY_TYPE VARCHAR (50), @SECURITY_TYPE_UPDATE BIT, @CUSIP VARCHAR (9), @CUSIP_UPDATE BIT, @ISIN VARCHAR (12), @ISIN_UPDATE BIT, @SEDOL VARCHAR (7), @SEDOL_UPDATE BIT, @TICKER VARCHAR (26), @TICKER_UPDATE BIT, @VALOREN VARCHAR (12), @VALOREN_UPDATE BIT, @WERTPAPIER VARCHAR (12), @WERTPAPIER_UPDATE BIT, @SECURITY_ISO_CCY VARCHAR (3), @SECURITY_ISO_CCY_UPDATE BIT, @RISK_ISO_CCY VARCHAR (3), @RISK_ISO_CCY_UPDATE BIT, @FIXED_ISO_CCY VARCHAR (3), @FIXED_ISO_CCY_UPDATE BIT, @INCORPORATION_ISO_CTY VARCHAR (4), @INCORPORATION_ISO_CTY_UPDATE BIT, @DOMICILE_ISO_CTY VARCHAR (4), @DOMICILE_ISO_CTY_UPDATE BIT, @ISSUE_COUNTRY_ISO VARCHAR (4), @ISSUE_COUNTRY_ISO_UPDATE BIT, @RISK_ISO_CTY VARCHAR (4), @RISK_ISO_CTY_UPDATE BIT, @MIC_EXCHANGE_CODE VARCHAR (4), @MIC_EXCHANGE_CODE_UPDATE BIT, @STATE_CODE VARCHAR (8), @STATE_CODE_UPDATE BIT, @ACTIVE_TRADE_INDICATOR VARCHAR (1), @ACTIVE_TRADE_INDICATOR_UPDATE BIT, @144A_INDICATOR VARCHAR (1), @144A_INDICATOR_UPDATE BIT, @PRIVATE_PLACEMENT_INDICATOR VARCHAR (1), @PRIVATE_PLACEMENT_INDICATOR_UPDATE BIT, @ILLIQUID VARCHAR (1), @ILLIQUID_UPDATE BIT, @QUOTE_TYPE VARCHAR (8), @QUOTE_TYPE_UPDATE BIT, @DAYS_TO_SETTLE INT, @DAYS_TO_SETTLE_UPDATE BIT, @TRADE_SETTLEMENT_CALENDAR_CODE VARCHAR (4), @TRADE_SETTLEMENT_CALENDAR_CODE_UPDATE BIT, @SECURITY_HAS_ADRS VARCHAR (4), @SECURITY_HAS_ADRS_UPDATE BIT, @UNIQUE_BLOOMBERG_ID VARCHAR (30), @UNIQUE_BLOOMBERG_ID_UPDATE BIT, @PARSEKEYABLE_DESCRIPTION VARCHAR (100), @PARSEKEYABLE_DESCRIPTION_UPDATE BIT, @BBG_EXCHANGE_CODE VARCHAR (20), @BBG_EXCHANGE_CODE_UPDATE BIT, @ISSUER VARCHAR (80), @ISSUER_UPDATE BIT, @CUR_MAR_CAP VARCHAR (20), @CUR_MAR_CAP_UPDATE BIT, @WITHHOLDING_TAX DECIMAL (26, 6), @WITHHOLDING_TAX_UPDATE BIT, @EX_DIVIDEND_DATE DATETIME, @EX_DIVIDEND_DATE_UPDATE BIT, @DIVIDEND_FREQUENCY VARCHAR (20), @DIVIDEND_FREQUENCY_UPDATE BIT, @DIVIDEND_PAY_DATE DATETIME, @DIVIDEND_PAY_DATE_UPDATE BIT, @DIVIDEND_PER_SHARE_LAST_NET DECIMAL (26, 12), @DIVIDEND_PER_SHARE_LAST_NET_UPDATE BIT, @DIVIDEND_PER_SHARE_LAST_GROSS DECIMAL (26, 12), @DIVIDEND_PER_SHARE_LAST_GROSS_UPDATE BIT, @DIVIDEND_PER_SHARE_ANNUAL_GROSS DECIMAL (26, 6), @DIVIDEND_PER_SHARE_ANNUAL_GROSS_UPDATE BIT, @DIVIDEND_TYPE VARCHAR (30), @DIVIDEND_TYPE_UPDATE BIT, @DIVIDEND_RECORD_DATE DATETIME, @DIVIDEND_RECORD_DATE_UPDATE BIT, @CURRENT_STOCK_DIVIDEND_EX_DATE DATETIME, @CURRENT_STOCK_DIVIDEND_EX_DATE_UPDATE BIT, @CURRENT_STOCK_DIVIDEND_PAY_DATE DATETIME, @CURRENT_STOCK_DIVIDEND_PAY_DATE_UPDATE BIT, @CURRENT_STOCK_DIVIDEND_PCT VARCHAR (10), @CURRENT_STOCK_DIVIDEND_PCT_UPDATE BIT, @NORMAL_MARKET_SIZE DECIMAL (26, 6), @NORMAL_MARKET_SIZE_UPDATE BIT, @SHARES_OUTSTANDING DECIMAL (26, 6), @SHARES_OUTSTANDING_UPDATE BIT, @SHARES_OUTSTANDING_DATE DATETIME, @SHARES_OUTSTANDING_DATE_UPDATE BIT, @SHARE_OUTSTANDING_REAL_ACTUAL VARCHAR (20), @SHARE_OUTSTANDING_REAL_ACTUAL_UPDATE BIT, @SHARE_OUTSTANDING_REAL_VALUE VARCHAR (20), @SHARE_OUTSTANDING_REAL_VALUE_UPDATE BIT, @VOL_WEIGHTED_AVERAGE_PRICE DECIMAL (26, 6), @VOL_WEIGHTED_AVERAGE_PRICE_UPDATE BIT, @FUND_NET_ASSET_VALUE DECIMAL (26, 6), @FUND_NET_ASSET_VALUE_UPDATE BIT, @FUND_TOTAL_ASSETS DECIMAL (26, 6), @FUND_TOTAL_ASSETS_UPDATE BIT, @LAST_UPDATE_DATE_EXCHANGE_TIMEZONE DATETIME, @LAST_UPDATE_DATE_EXCHANGE_TIMEZONE_UPDATE BIT, @TOTAL_VOTING_SHARES DECIMAL (26, 6), @TOTAL_VOTING_SHARES_UPDATE BIT, @LAST_PUBLISHED_OFFER_NO_OF_SHARES VARCHAR (20), @LAST_PUBLISHED_OFFER_NO_OF_SHARES_UPDATE BIT, @ISSUE_DATE DATETIME, @ISSUE_DATE_UPDATE BIT, @MATURITY_DATE DATETIME, @MATURITY_DATE_UPDATE BIT, @COUPON_RATE DECIMAL (26, 6), @COUPON_RATE_UPDATE BIT, @COUPON_FREQUENCY INT, @COUPON_FREQUENCY_UPDATE BIT, @COUPON_TYPE VARCHAR (30), @COUPON_TYPE_UPDATE BIT, @CONVERTIBLE_INDICATOR VARCHAR (1), @CONVERTIBLE_INDICATOR_UPDATE BIT, @AMOUNT_ISSUED DECIMAL (26, 2), @AMOUNT_ISSUED_UPDATE BIT, @AMOUNT_OUTSTANDING DECIMAL (26, 2), @AMOUNT_OUTSTANDING_UPDATE BIT, @COUPON_CAP DECIMAL (26, 6), @COUPON_CAP_UPDATE BIT, @COUPON_ISO_CCY VARCHAR (3), @COUPON_ISO_CCY_UPDATE BIT, @COUPON_FLOOR DECIMAL (26, 6), @COUPON_FLOOR_UPDATE BIT, @ISSUE_PRICE DECIMAL (26, 6), @ISSUE_PRICE_UPDATE BIT, @DAY_COUNT INT, @DAY_COUNT_UPDATE BIT, @FIRST_COUPON_DATE DATETIME, @FIRST_COUPON_DATE_UPDATE BIT, @FIRST_SETTLE_DATE DATETIME, @FIRST_SETTLE_DATE_UPDATE BIT, @PREVIOUS_COUPON_DATE DATETIME, @PREVIOUS_COUPON_DATE_UPDATE BIT, @NEXT_COUPON_DATE DATETIME, @NEXT_COUPON_DATE_UPDATE BIT, @NEXT_CALL_DATE DATETIME, @NEXT_CALL_DATE_UPDATE BIT, @NEXT_CALL_PRICE DECIMAL (26, 6), @NEXT_CALL_PRICE_UPDATE BIT, @LAST_RESET_DATE DATETIME, @LAST_RESET_DATE_UPDATE BIT, @NEXT_RESET_DATE DATETIME, @NEXT_RESET_DATE_UPDATE BIT, @SECOND_COUPON_DATE DATETIME, @SECOND_COUPON_DATE_UPDATE BIT, @FIXED_INDICATOR VARCHAR (1), @FIXED_INDICATOR_UPDATE BIT, @FIX_TO_FLOAT_INDICATOR VARCHAR (1), @FIX_TO_FLOAT_INDICATOR_UPDATE BIT, @FLOATER_INDICATOR VARCHAR (1), @FLOATER_INDICATOR_UPDATE BIT, @FLOAT_TO_FIX_INDICATOR VARCHAR (1), @FLOAT_TO_FIX_INDICATOR_UPDATE BIT, @INDEX_LINKED_INDICATOR VARCHAR (1), @INDEX_LINKED_INDICATOR_UPDATE BIT, @INFLATION_LINKED_INDICATOR VARCHAR (1), @INFLATION_LINKED_INDICATOR_UPDATE BIT, @PERPETUAL_INDICATOR VARCHAR (1), @PERPETUAL_INDICATOR_UPDATE BIT, @ZERO_COUPON_INDICATOR VARCHAR (1), @ZERO_COUPON_INDICATOR_UPDATE BIT, @ACCRUED_INTEREST_PER_100 DECIMAL (26, 6), @ACCRUED_INTEREST_PER_100_UPDATE BIT, @ACCRUED_INTEREST_DATE DATETIME, @ACCRUED_INTEREST_DATE_UPDATE BIT, @COLLATERAL_TYPE VARCHAR (30), @COLLATERAL_TYPE_UPDATE BIT, @AGGREGATE_AMOUNT_ISSUED_INDICATOR VARCHAR (1), @AGGREGATE_AMOUNT_ISSUED_INDICATOR_UPDATE BIT, @ASSUMED_INDEX_VALUE DECIMAL (26, 6), @ASSUMED_INDEX_VALUE_UPDATE BIT, @BRADY_INDICATOR VARCHAR (1), @BRADY_INDICATOR_UPDATE BIT, @CALCULATION_TYPE INT, @CALCULATION_TYPE_UPDATE BIT, @CALLABLE_INDICATOR VARCHAR (1), @CALLABLE_INDICATOR_UPDATE BIT, @CALLED_INDICATOR VARCHAR (1), @CALLED_INDICATOR_UPDATE BIT, @CALL_DAYS_NOTICE INT, @CALL_DAYS_NOTICE_UPDATE BIT, @PUTABLE_INDICATOR VARCHAR (1), @PUTABLE_INDICATOR_UPDATE BIT, @PUT_DAYS_NOTICE INT, @PUT_DAYS_NOTICE_UPDATE BIT, @CASH_SETTLED_INDICATOR VARCHAR (1), @CASH_SETTLED_INDICATOR_UPDATE BIT, @CDS_RECOVERY_RATE DECIMAL (26, 6), @CDS_RECOVERY_RATE_UPDATE BIT, @CORPORATE_TO_EQUITY_TICKER VARCHAR (11), @CORPORATE_TO_EQUITY_TICKER_UPDATE BIT, @FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE DATETIME, @FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE_UPDATE BIT, @DEFAULTED_INDICATOR VARCHAR (1), @DEFAULTED_INDICATOR_UPDATE BIT, @EXCHANGEABLE_INDICATOR VARCHAR (1), @EXCHANGEABLE_INDICATOR_UPDATE BIT, @FLOATER_COUPON_CONVENTION VARCHAR (30), @FLOATER_COUPON_CONVENTION_UPDATE BIT, @FLOATER_LOCKOUT_PERIOD INT, @FLOATER_LOCKOUT_PERIOD_UPDATE BIT, @FLOATER_PAY_DAY VARCHAR (30), @FLOATER_PAY_DAY_UPDATE BIT, @JUNIOR_INDICATOR VARCHAR (1), @JUNIOR_INDICATOR_UPDATE BIT, @SENIOR_INDICATOR VARCHAR (1), @SENIOR_INDICATOR_UPDATE BIT, @REGULATION_S_INDICATOR VARCHAR (1), @REGULATION_S_INDICATOR_UPDATE BIT, @SUBORDINATED_INDICATOR VARCHAR (1), @SUBORDINATED_INDICATOR_UPDATE BIT, @UNIT_TRADED_INDICATOR VARCHAR (1), @UNIT_TRADED_INDICATOR_UPDATE BIT, @LOAN_PARTICIPATION_NOTE_INDICATOR VARCHAR (1), @LOAN_PARTICIPATION_NOTE_INDICATOR_UPDATE BIT, @ORIGINAL_ISSUE_DISCOUNT_INDICATOR VARCHAR (4), @ORIGINAL_ISSUE_DISCOUNT_INDICATOR_UPDATE BIT, @GILT_DIGITS INT, @GILT_DIGITS_UPDATE BIT, @GILTS_EX_DIVIDEND_DATE DATETIME, @GILTS_EX_DIVIDEND_DATE_UPDATE BIT, @INDEX_RATIO_CPI DECIMAL (26, 6), @INDEX_RATIO_CPI_UPDATE BIT, @MINIMUM_INCREMENT DECIMAL (26, 6), @MINIMUM_INCREMENT_UPDATE BIT, @MINIMUM_PIECE DECIMAL (26, 6), @MINIMUM_PIECE_UPDATE BIT, @MOST_RECENT_REPORTED_FACTOR DECIMAL (26, 10), @MOST_RECENT_REPORTED_FACTOR_UPDATE BIT, @MOST_RECENT_ACCRUAL_RATE DECIMAL (26, 6), @MOST_RECENT_ACCRUAL_RATE_UPDATE BIT, @MOST_RECENT_ACCRUAL_RATE_START_DATE DATETIME, @MOST_RECENT_ACCRUAL_RATE_START_DATE_UPDATE BIT, @MORTGAGE_DEAL_CALL_DATE DATETIME, @MORTGAGE_DEAL_CALL_DATE_UPDATE BIT, @MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY DATETIME, @MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY_UPDATE BIT, @MORTGAGE_FACTOR_DATE DATETIME, @MORTGAGE_FACTOR_DATE_UPDATE BIT, @MORTGAGE_CURRENT_PAYMENT_RATE DECIMAL (26, 6), @MORTGAGE_CURRENT_PAYMENT_RATE_UPDATE BIT, @MORTGAGE_FINAL_PAY_DATE DATETIME, @MORTGAGE_FINAL_PAY_DATE_UPDATE BIT, @MORTGAGE_FIRST_PAY_DATE DATETIME, @MORTGAGE_FIRST_PAY_DATE_UPDATE BIT, @MORTGAGE_LIFE_FLOOR DECIMAL (26, 2), @MORTGAGE_LIFE_FLOOR_UPDATE BIT, @MORTGAGE_PAYMENT_DELAY VARCHAR (8), @MORTGAGE_PAYMENT_DELAY_UPDATE BIT, @MORTGAGE_RATE_CHANGE_FREQUENCY INT, @MORTGAGE_RATE_CHANGE_FREQUENCY_UPDATE BIT, @MORTGAGE_TRANCHE_TYPE VARCHAR (8), @MORTGAGE_TRANCHE_TYPE_UPDATE BIT, @MATURITY_REFUND_TYPE VARCHAR (18), @MATURITY_REFUND_TYPE_UPDATE BIT, @NOMINAL_PAYMENT_DAY INT, @NOMINAL_PAYMENT_DAY_UPDATE BIT, @PENULTIMATE_COUPON_DATE DATETIME, @PENULTIMATE_COUPON_DATE_UPDATE BIT, @REDEMPTION_VALUE DECIMAL (26, 6), @REDEMPTION_VALUE_UPDATE BIT, @UNDERLYING_REFERENCE_INDEX VARCHAR (30), @UNDERLYING_REFERENCE_INDEX_UPDATE BIT, @RESET_FREQUENCY INT, @RESET_FREQUENCY_UPDATE BIT, @RESET_INDEX VARCHAR (15), @RESET_INDEX_UPDATE BIT, @SINK_TYPE VARCHAR (10), @SINK_TYPE_UPDATE BIT, @SINKABLE_INDICATOR VARCHAR (1), @SINKABLE_INDICATOR_UPDATE BIT, @STEPUP_STEPDOWN_COUPON DECIMAL (26, 6), @STEPUP_STEPDOWN_COUPON_UPDATE BIT, @STEPUP_STEPDOWN_COUPON_DATE DATETIME, @STEPUP_STEPDOWN_COUPON_DATE_UPDATE BIT, @STRUCTURED_NOTE_INDICATOR VARCHAR (1), @STRUCTURED_NOTE_INDICATOR_UPDATE BIT, @LOWER_TIER2_CAPITAL_INDICATOR VARCHAR (1), @LOWER_TIER2_CAPITAL_INDICATOR_UPDATE BIT, @TIER1_CAPITAL_INDICATOR VARCHAR (1), @TIER1_CAPITAL_INDICATOR_UPDATE BIT, @TIER2_CAPITAL_NON_SPECIFIC_INDICATOR VARCHAR (1), @TIER2_CAPITAL_NON_SPECIFIC_INDICATOR_UPDATE BIT, @UPPER_TIER2_CAPITAL_INDICATOR VARCHAR (1), @UPPER_TIER2_CAPITAL_INDICATOR_UPDATE BIT, @EX_DIVIDEND_DAYS INT, @EX_DIVIDEND_DAYS_UPDATE BIT, @EX_DIVIDEND_DAYS_CALENDAR_CODE VARCHAR (8), @EX_DIVIDEND_DAYS_CALENDAR_CODE_UPDATE BIT, @SUBORDINATE_TYPE VARCHAR (6), @SUBORDINATE_TYPE_UPDATE BIT, @SENIORITY_LEVEL_2 VARCHAR (5), @SENIORITY_LEVEL_2_UPDATE BIT, @OPTION_ROOT_TICKER VARCHAR (10), @OPTION_ROOT_TICKER_UPDATE BIT, @PUT_CALL_INDICATOR VARCHAR (8), @PUT_CALL_INDICATOR_UPDATE BIT, @EXPIRY_DATE DATETIME, @EXPIRY_DATE_UPDATE BIT, @FUTURE_EXPIRY_MONTH_YEAR VARCHAR (10), @FUTURE_EXPIRY_MONTH_YEAR_UPDATE BIT, @EXERCISE_TYPE VARCHAR (8), @EXERCISE_TYPE_UPDATE BIT, @CONTRACT_SIZE DECIMAL (26, 6), @CONTRACT_SIZE_UPDATE BIT, @CONTRACT_VALUE DECIMAL (26, 6), @CONTRACT_VALUE_UPDATE BIT, @FUTURE_TYPE VARCHAR (30), @FUTURE_TYPE_UPDATE BIT, @LAST_TRADE_DATE DATETIME, @LAST_TRADE_DATE_UPDATE BIT, @LONG_EXCHANGE_NAME VARCHAR (30), @LONG_EXCHANGE_NAME_UPDATE BIT, @DELTA DECIMAL (26, 6), @DELTA_UPDATE BIT, @GAMMA DECIMAL (26, 6), @GAMMA_UPDATE BIT, @THETA DECIMAL (26, 6), @THETA_UPDATE BIT, @VEGA DECIMAL (26, 6), @VEGA_UPDATE BIT, @EURO_FUTURE_INDICATOR VARCHAR (1), @EURO_FUTURE_INDICATOR_UPDATE BIT, @CONVERSION_FACTOR DECIMAL (26, 6), @CONVERSION_FACTOR_UPDATE BIT, @CTD_CONVERSION_DURATION DECIMAL (26, 6), @CTD_CONVERSION_DURATION_UPDATE BIT, @CTD_ISIN VARCHAR (12), @CTD_ISIN_UPDATE BIT, @CTD_SEDOL VARCHAR (7), @CTD_SEDOL_UPDATE BIT, @CTD_RISK_TYPE VARCHAR (20), @CTD_RISK_TYPE_UPDATE BIT, @FUTURE_DAYS_TO_EXPIRY INT, @FUTURE_DAYS_TO_EXPIRY_UPDATE BIT, @FUTURE_LONGNAME VARCHAR (30), @FUTURE_LONGNAME_UPDATE BIT, @STRIKE_PRICE DECIMAL (26, 6), @STRIKE_PRICE_UPDATE BIT, @TICK_SIZE DECIMAL (26, 6), @TICK_SIZE_UPDATE BIT, @MARKET_CAP DECIMAL (26, 2), @MARKET_CAP_UPDATE BIT, @AVERAGE_VOLUME_100D DECIMAL (26, 6), @AVERAGE_VOLUME_100D_UPDATE BIT, @AVERAGE_VOLUME_30D DECIMAL (26, 6), @AVERAGE_VOLUME_30D_UPDATE BIT, @VOTING_RIGHTS DECIMAL (26, 6), @VOTING_RIGHTS_UPDATE BIT, @PAR_AMOUNT DECIMAL (26, 6), @PAR_AMOUNT_UPDATE BIT, @OPEN_INTEREST INT, @OPEN_INTEREST_UPDATE BIT, @BASE_ACCRUAL_RATE_DATE DATETIME, @BASE_ACCRUAL_RATE_DATE_UPDATE BIT, @UNDERLYING_BASE_CPI DECIMAL (26, 6), @UNDERLYING_BASE_CPI_UPDATE BIT, @BASIC_SPREAD_PCT DECIMAL (26, 6), @BASIC_SPREAD_PCT_UPDATE BIT, @MID_CONVEXITY DECIMAL (26, 6), @MID_CONVEXITY_UPDATE BIT, @MID_DISCOUNT_MARGIN DECIMAL (26, 6), @MID_DISCOUNT_MARGIN_UPDATE BIT, @MID_DISCOUNT_MARGIN_TO_NEXT_CALL DECIMAL (26, 6), @MID_DISCOUNT_MARGIN_TO_NEXT_CALL_UPDATE BIT, @MID_MODIFIED_DURATION DECIMAL (26, 6), @MID_MODIFIED_DURATION_UPDATE BIT, @MID_MACAULAY_DURATION DECIMAL (26, 6), @MID_MACAULAY_DURATION_UPDATE BIT, @MID_SPREAD_DURATION DECIMAL (26, 6), @MID_SPREAD_DURATION_UPDATE BIT, @FLOATER_SPREAD_BP DECIMAL (26, 6), @FLOATER_SPREAD_BP_UPDATE BIT, @MORTGAGE_GENERIC_CPR_ISSUE DECIMAL (26, 6), @MORTGAGE_GENERIC_CPR_ISSUE_UPDATE BIT, @MORTGAGE_GENERIC_PSA_ISSUE DECIMAL (26, 6), @MORTGAGE_GENERIC_PSA_ISSUE_UPDATE BIT, @MORTGAGE_ORIGINAL_WAC DECIMAL (26, 6), @MORTGAGE_ORIGINAL_WAC_UPDATE BIT, @MORTGAGE_ORIGINAL_WAM DECIMAL (26, 6), @MORTGAGE_ORIGINAL_WAM_UPDATE BIT, @MORTGAGE_POOL_PSA_ISSUE DECIMAL (26, 6), @MORTGAGE_POOL_PSA_ISSUE_UPDATE BIT, @MORTGAGE_PRINCIPAL_LOSSES DECIMAL (26, 6), @MORTGAGE_PRINCIPAL_LOSSES_UPDATE BIT, @MORTGAGE_WAL_YEARS DECIMAL (26, 6), @MORTGAGE_WAL_YEARS_UPDATE BIT, @MORTGAGE_WAM_MONTHS DECIMAL (26, 6), @MORTGAGE_WAM_MONTHS_UPDATE BIT, @MID_OAS_SPREAD_DURATION DECIMAL (26, 6), @MID_OAS_SPREAD_DURATION_UPDATE BIT, @MID_YIELD_TO_CONVENTION DECIMAL (26, 6), @MID_YIELD_TO_CONVENTION_UPDATE BIT, @ASK_YIELD_TO_NEXT_CALL DECIMAL (26, 6), @ASK_YIELD_TO_NEXT_CALL_UPDATE BIT, @ASK_YIELD_TO_MATURITY DECIMAL (26, 6), @ASK_YIELD_TO_MATURITY_UPDATE BIT, @MID_YIELD_TO_MATURITY DECIMAL (26, 6), @MID_YIELD_TO_MATURITY_UPDATE BIT, @MID_Z_SPREAD_BP DECIMAL (26, 6), @MID_Z_SPREAD_BP_UPDATE BIT, @ANNUAL_MODIFIED_DURATION DECIMAL (26, 6), @ANNUAL_MODIFIED_DURATION_UPDATE BIT, @SEMI_ANNUAL_MODIFIED_DURATION DECIMAL (26, 6), @SEMI_ANNUAL_MODIFIED_DURATION_UPDATE BIT, @ISMA_MODIFIED_DURATION DECIMAL (26, 6), @ISMA_MODIFIED_DURATION_UPDATE BIT, @MODIFIED_DURATION DECIMAL (26, 6), @MODIFIED_DURATION_UPDATE BIT, @YIELD_TO_MATURITY DECIMAL (26, 6), @YIELD_TO_MATURITY_UPDATE BIT, @ANNUAL_YIELD DECIMAL (26, 6), @ANNUAL_YIELD_UPDATE BIT, @SEMI_ANNUAL_YIELD DECIMAL (26, 6), @SEMI_ANNUAL_YIELD_UPDATE BIT, @ISMA_YIELD DECIMAL (26, 6), @ISMA_YIELD_UPDATE BIT, @OAS DECIMAL (26, 6), @OAS_UPDATE BIT, @Z_SPREAD DECIMAL (26, 6), @Z_SPREAD_UPDATE BIT, @EXPECTED_REMAINING_LIFE DECIMAL (26, 6), @EXPECTED_REMAINING_LIFE_UPDATE BIT, @MATURITY_WAL DECIMAL (26, 6), @MATURITY_WAL_UPDATE BIT, @EQUITY_UNDERLYING_TICKER VARCHAR (26), @EQUITY_UNDERLYING_TICKER_UPDATE BIT, @DIVIDEND_CCY VARCHAR (10), @DIVIDEND_CCY_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


