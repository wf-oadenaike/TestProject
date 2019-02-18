﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION208_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @EDM_SEC_ID INT, @CADIS_SYSTEM_TIMESTAMP_1 ROWVERSION, @CADIS_SYSTEM_TIMESTAMP_1_CHECK BIT, @CADIS_SYSTEM_TIMESTAMP_2 ROWVERSION, @CADIS_SYSTEM_TIMESTAMP_2_CHECK BIT, @CADIS_SYSTEM_TIMESTAMP_3 ROWVERSION, @CADIS_SYSTEM_TIMESTAMP_3_CHECK BIT, @CADIS_SYSTEM_TIMESTAMP_4 ROWVERSION, @CADIS_SYSTEM_TIMESTAMP_4_CHECK BIT, @CADIS_SYSTEM_TIMESTAMP_5 ROWVERSION, @CADIS_SYSTEM_TIMESTAMP_5_CHECK BIT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @SECURITY_NAME BIT, @SECURITY_NAME_UPDATE BIT, @SECURITY_DESCRIPTION BIT, @SECURITY_DESCRIPTION_UPDATE BIT, @SECURITY_SHORTNAME BIT, @SECURITY_SHORTNAME_UPDATE BIT, @ASSET_TYPE BIT, @ASSET_TYPE_UPDATE BIT, @SECURITY_TYPE BIT, @SECURITY_TYPE_UPDATE BIT, @CUSIP BIT, @CUSIP_UPDATE BIT, @ISIN BIT, @ISIN_UPDATE BIT, @SEDOL BIT, @SEDOL_UPDATE BIT, @TICKER BIT, @TICKER_UPDATE BIT, @VALOREN BIT, @VALOREN_UPDATE BIT, @WERTPAPIER BIT, @WERTPAPIER_UPDATE BIT, @SECURITY_ISO_CCY BIT, @SECURITY_ISO_CCY_UPDATE BIT, @RISK_ISO_CCY BIT, @RISK_ISO_CCY_UPDATE BIT, @FIXED_ISO_CCY BIT, @FIXED_ISO_CCY_UPDATE BIT, @INCORPORATION_ISO_CTY BIT, @INCORPORATION_ISO_CTY_UPDATE BIT, @DOMICILE_ISO_CTY BIT, @DOMICILE_ISO_CTY_UPDATE BIT, @ISSUE_COUNTRY_ISO BIT, @ISSUE_COUNTRY_ISO_UPDATE BIT, @RISK_ISO_CTY BIT, @RISK_ISO_CTY_UPDATE BIT, @MIC_EXCHANGE_CODE BIT, @MIC_EXCHANGE_CODE_UPDATE BIT, @STATE_CODE BIT, @STATE_CODE_UPDATE BIT, @ACTIVE_TRADE_INDICATOR BIT, @ACTIVE_TRADE_INDICATOR_UPDATE BIT, @144A_INDICATOR BIT, @144A_INDICATOR_UPDATE BIT, @PRIVATE_PLACEMENT_INDICATOR BIT, @PRIVATE_PLACEMENT_INDICATOR_UPDATE BIT, @ILLIQUID BIT, @ILLIQUID_UPDATE BIT, @QUOTE_TYPE BIT, @QUOTE_TYPE_UPDATE BIT, @DAYS_TO_SETTLE BIT, @DAYS_TO_SETTLE_UPDATE BIT, @TRADE_SETTLEMENT_CALENDAR_CODE BIT, @TRADE_SETTLEMENT_CALENDAR_CODE_UPDATE BIT, @SECURITY_HAS_ADRS BIT, @SECURITY_HAS_ADRS_UPDATE BIT, @UNIQUE_BLOOMBERG_ID BIT, @UNIQUE_BLOOMBERG_ID_UPDATE BIT, @PARSEKEYABLE_DESCRIPTION BIT, @PARSEKEYABLE_DESCRIPTION_UPDATE BIT, @BBG_EXCHANGE_CODE BIT, @BBG_EXCHANGE_CODE_UPDATE BIT, @ISSUER BIT, @ISSUER_UPDATE BIT, @CUR_MAR_CAP BIT, @CUR_MAR_CAP_UPDATE BIT, @WITHHOLDING_TAX BIT, @WITHHOLDING_TAX_UPDATE BIT, @EX_DIVIDEND_DATE BIT, @EX_DIVIDEND_DATE_UPDATE BIT, @DIVIDEND_FREQUENCY BIT, @DIVIDEND_FREQUENCY_UPDATE BIT, @DIVIDEND_PAY_DATE BIT, @DIVIDEND_PAY_DATE_UPDATE BIT, @DIVIDEND_PER_SHARE_LAST_NET BIT, @DIVIDEND_PER_SHARE_LAST_NET_UPDATE BIT, @DIVIDEND_PER_SHARE_LAST_GROSS BIT, @DIVIDEND_PER_SHARE_LAST_GROSS_UPDATE BIT, @DIVIDEND_PER_SHARE_ANNUAL_GROSS BIT, @DIVIDEND_PER_SHARE_ANNUAL_GROSS_UPDATE BIT, @DIVIDEND_TYPE BIT, @DIVIDEND_TYPE_UPDATE BIT, @DIVIDEND_RECORD_DATE BIT, @DIVIDEND_RECORD_DATE_UPDATE BIT, @CURRENT_STOCK_DIVIDEND_EX_DATE BIT, @CURRENT_STOCK_DIVIDEND_EX_DATE_UPDATE BIT, @CURRENT_STOCK_DIVIDEND_PAY_DATE BIT, @CURRENT_STOCK_DIVIDEND_PAY_DATE_UPDATE BIT, @CURRENT_STOCK_DIVIDEND_PCT BIT, @CURRENT_STOCK_DIVIDEND_PCT_UPDATE BIT, @NORMAL_MARKET_SIZE BIT, @NORMAL_MARKET_SIZE_UPDATE BIT, @SHARES_OUTSTANDING BIT, @SHARES_OUTSTANDING_UPDATE BIT, @SHARES_OUTSTANDING_DATE BIT, @SHARES_OUTSTANDING_DATE_UPDATE BIT, @SHARE_OUTSTANDING_REAL_ACTUAL BIT, @SHARE_OUTSTANDING_REAL_ACTUAL_UPDATE BIT, @SHARE_OUTSTANDING_REAL_VALUE BIT, @SHARE_OUTSTANDING_REAL_VALUE_UPDATE BIT, @LAST_PUBLISHED_OFFER_NO_OF_SHARES BIT, @LAST_PUBLISHED_OFFER_NO_OF_SHARES_UPDATE BIT, @VOL_WEIGHTED_AVERAGE_PRICE BIT, @VOL_WEIGHTED_AVERAGE_PRICE_UPDATE BIT, @FUND_NET_ASSET_VALUE BIT, @FUND_NET_ASSET_VALUE_UPDATE BIT, @FUND_TOTAL_ASSETS BIT, @FUND_TOTAL_ASSETS_UPDATE BIT, @LAST_UPDATE_DATE_EXCHANGE_TIMEZONE BIT, @LAST_UPDATE_DATE_EXCHANGE_TIMEZONE_UPDATE BIT, @TOTAL_VOTING_SHARES BIT, @TOTAL_VOTING_SHARES_UPDATE BIT, @ISSUE_DATE BIT, @ISSUE_DATE_UPDATE BIT, @MATURITY_DATE BIT, @MATURITY_DATE_UPDATE BIT, @COUPON_RATE BIT, @COUPON_RATE_UPDATE BIT, @COUPON_FREQUENCY BIT, @COUPON_FREQUENCY_UPDATE BIT, @COUPON_TYPE BIT, @COUPON_TYPE_UPDATE BIT, @CONVERTIBLE_INDICATOR BIT, @CONVERTIBLE_INDICATOR_UPDATE BIT, @AMOUNT_ISSUED BIT, @AMOUNT_ISSUED_UPDATE BIT, @AMOUNT_OUTSTANDING BIT, @AMOUNT_OUTSTANDING_UPDATE BIT, @COUPON_CAP BIT, @COUPON_CAP_UPDATE BIT, @COUPON_ISO_CCY BIT, @COUPON_ISO_CCY_UPDATE BIT, @COUPON_FLOOR BIT, @COUPON_FLOOR_UPDATE BIT, @ISSUE_PRICE BIT, @ISSUE_PRICE_UPDATE BIT, @DAY_COUNT BIT, @DAY_COUNT_UPDATE BIT, @FIRST_COUPON_DATE BIT, @FIRST_COUPON_DATE_UPDATE BIT, @FIRST_SETTLE_DATE BIT, @FIRST_SETTLE_DATE_UPDATE BIT, @PREVIOUS_COUPON_DATE BIT, @PREVIOUS_COUPON_DATE_UPDATE BIT, @NEXT_COUPON_DATE BIT, @NEXT_COUPON_DATE_UPDATE BIT, @NEXT_CALL_DATE BIT, @NEXT_CALL_DATE_UPDATE BIT, @NEXT_CALL_PRICE BIT, @NEXT_CALL_PRICE_UPDATE BIT, @LAST_RESET_DATE BIT, @LAST_RESET_DATE_UPDATE BIT, @NEXT_RESET_DATE BIT, @NEXT_RESET_DATE_UPDATE BIT, @SECOND_COUPON_DATE BIT, @SECOND_COUPON_DATE_UPDATE BIT, @FIXED_INDICATOR BIT, @FIXED_INDICATOR_UPDATE BIT, @FIX_TO_FLOAT_INDICATOR BIT, @FIX_TO_FLOAT_INDICATOR_UPDATE BIT, @FLOATER_INDICATOR BIT, @FLOATER_INDICATOR_UPDATE BIT, @FLOAT_TO_FIX_INDICATOR BIT, @FLOAT_TO_FIX_INDICATOR_UPDATE BIT, @INDEX_LINKED_INDICATOR BIT, @INDEX_LINKED_INDICATOR_UPDATE BIT, @INFLATION_LINKED_INDICATOR BIT, @INFLATION_LINKED_INDICATOR_UPDATE BIT, @PERPETUAL_INDICATOR BIT, @PERPETUAL_INDICATOR_UPDATE BIT, @ZERO_COUPON_INDICATOR BIT, @ZERO_COUPON_INDICATOR_UPDATE BIT, @ACCRUED_INTEREST_PER_100 BIT, @ACCRUED_INTEREST_PER_100_UPDATE BIT, @ACCRUED_INTEREST_DATE BIT, @ACCRUED_INTEREST_DATE_UPDATE BIT, @COLLATERAL_TYPE BIT, @COLLATERAL_TYPE_UPDATE BIT, @AGGREGATE_AMOUNT_ISSUED_INDICATOR BIT, @AGGREGATE_AMOUNT_ISSUED_INDICATOR_UPDATE BIT, @ASSUMED_INDEX_VALUE BIT, @ASSUMED_INDEX_VALUE_UPDATE BIT, @BRADY_INDICATOR BIT, @BRADY_INDICATOR_UPDATE BIT, @CALCULATION_TYPE BIT, @CALCULATION_TYPE_UPDATE BIT, @CALLABLE_INDICATOR BIT, @CALLABLE_INDICATOR_UPDATE BIT, @CALLED_INDICATOR BIT, @CALLED_INDICATOR_UPDATE BIT, @CALL_DAYS_NOTICE BIT, @CALL_DAYS_NOTICE_UPDATE BIT, @PUTABLE_INDICATOR BIT, @PUTABLE_INDICATOR_UPDATE BIT, @PUT_DAYS_NOTICE BIT, @PUT_DAYS_NOTICE_UPDATE BIT, @CASH_SETTLED_INDICATOR BIT, @CASH_SETTLED_INDICATOR_UPDATE BIT, @CDS_RECOVERY_RATE BIT, @CDS_RECOVERY_RATE_UPDATE BIT, @CORPORATE_TO_EQUITY_TICKER BIT, @CORPORATE_TO_EQUITY_TICKER_UPDATE BIT, @FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE BIT, @FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE_UPDATE BIT, @DEFAULTED_INDICATOR BIT, @DEFAULTED_INDICATOR_UPDATE BIT, @EXCHANGEABLE_INDICATOR BIT, @EXCHANGEABLE_INDICATOR_UPDATE BIT, @FLOATER_COUPON_CONVENTION BIT, @FLOATER_COUPON_CONVENTION_UPDATE BIT, @FLOATER_LOCKOUT_PERIOD BIT, @FLOATER_LOCKOUT_PERIOD_UPDATE BIT, @FLOATER_PAY_DAY BIT, @FLOATER_PAY_DAY_UPDATE BIT, @JUNIOR_INDICATOR BIT, @JUNIOR_INDICATOR_UPDATE BIT, @SENIOR_INDICATOR BIT, @SENIOR_INDICATOR_UPDATE BIT, @REGULATION_S_INDICATOR BIT, @REGULATION_S_INDICATOR_UPDATE BIT, @SUBORDINATED_INDICATOR BIT, @SUBORDINATED_INDICATOR_UPDATE BIT, @UNIT_TRADED_INDICATOR BIT, @UNIT_TRADED_INDICATOR_UPDATE BIT, @LOAN_PARTICIPATION_NOTE_INDICATOR BIT, @LOAN_PARTICIPATION_NOTE_INDICATOR_UPDATE BIT, @ORIGINAL_ISSUE_DISCOUNT_INDICATOR BIT, @ORIGINAL_ISSUE_DISCOUNT_INDICATOR_UPDATE BIT, @GILT_DIGITS BIT, @GILT_DIGITS_UPDATE BIT, @GILTS_EX_DIVIDEND_DATE BIT, @GILTS_EX_DIVIDEND_DATE_UPDATE BIT, @INDEX_RATIO_CPI BIT, @INDEX_RATIO_CPI_UPDATE BIT, @MINIMUM_INCREMENT BIT, @MINIMUM_INCREMENT_UPDATE BIT, @MINIMUM_PIECE BIT, @MINIMUM_PIECE_UPDATE BIT, @MOST_RECENT_REPORTED_FACTOR BIT, @MOST_RECENT_REPORTED_FACTOR_UPDATE BIT, @MOST_RECENT_ACCRUAL_RATE BIT, @MOST_RECENT_ACCRUAL_RATE_UPDATE BIT, @MOST_RECENT_ACCRUAL_RATE_START_DATE BIT, @MOST_RECENT_ACCRUAL_RATE_START_DATE_UPDATE BIT, @MORTGAGE_DEAL_CALL_DATE BIT, @MORTGAGE_DEAL_CALL_DATE_UPDATE BIT, @MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY BIT, @MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY_UPDATE BIT, @MORTGAGE_FACTOR_DATE BIT, @MORTGAGE_FACTOR_DATE_UPDATE BIT, @MORTGAGE_CURRENT_PAYMENT_RATE BIT, @MORTGAGE_CURRENT_PAYMENT_RATE_UPDATE BIT, @MORTGAGE_FINAL_PAY_DATE BIT, @MORTGAGE_FINAL_PAY_DATE_UPDATE BIT, @MORTGAGE_FIRST_PAY_DATE BIT, @MORTGAGE_FIRST_PAY_DATE_UPDATE BIT, @MORTGAGE_LIFE_FLOOR BIT, @MORTGAGE_LIFE_FLOOR_UPDATE BIT, @MORTGAGE_PAYMENT_DELAY BIT, @MORTGAGE_PAYMENT_DELAY_UPDATE BIT, @MORTGAGE_RATE_CHANGE_FREQUENCY BIT, @MORTGAGE_RATE_CHANGE_FREQUENCY_UPDATE BIT, @MORTGAGE_TRANCHE_TYPE BIT, @MORTGAGE_TRANCHE_TYPE_UPDATE BIT, @MATURITY_REFUND_TYPE BIT, @MATURITY_REFUND_TYPE_UPDATE BIT, @NOMINAL_PAYMENT_DAY BIT, @NOMINAL_PAYMENT_DAY_UPDATE BIT, @PENULTIMATE_COUPON_DATE BIT, @PENULTIMATE_COUPON_DATE_UPDATE BIT, @REDEMPTION_VALUE BIT, @REDEMPTION_VALUE_UPDATE BIT, @UNDERLYING_REFERENCE_INDEX BIT, @UNDERLYING_REFERENCE_INDEX_UPDATE BIT, @RESET_FREQUENCY BIT, @RESET_FREQUENCY_UPDATE BIT, @RESET_INDEX BIT, @RESET_INDEX_UPDATE BIT, @SINK_TYPE BIT, @SINK_TYPE_UPDATE BIT, @SINKABLE_INDICATOR BIT, @SINKABLE_INDICATOR_UPDATE BIT, @STEPUP_STEPDOWN_COUPON BIT, @STEPUP_STEPDOWN_COUPON_UPDATE BIT, @STEPUP_STEPDOWN_COUPON_DATE BIT, @STEPUP_STEPDOWN_COUPON_DATE_UPDATE BIT, @STRUCTURED_NOTE_INDICATOR BIT, @STRUCTURED_NOTE_INDICATOR_UPDATE BIT, @LOWER_TIER2_CAPITAL_INDICATOR BIT, @LOWER_TIER2_CAPITAL_INDICATOR_UPDATE BIT, @TIER1_CAPITAL_INDICATOR BIT, @TIER1_CAPITAL_INDICATOR_UPDATE BIT, @TIER2_CAPITAL_NON_SPECIFIC_INDICATOR BIT, @TIER2_CAPITAL_NON_SPECIFIC_INDICATOR_UPDATE BIT, @UPPER_TIER2_CAPITAL_INDICATOR BIT, @UPPER_TIER2_CAPITAL_INDICATOR_UPDATE BIT, @EX_DIVIDEND_DAYS BIT, @EX_DIVIDEND_DAYS_UPDATE BIT, @EX_DIVIDEND_DAYS_CALENDAR_CODE BIT, @EX_DIVIDEND_DAYS_CALENDAR_CODE_UPDATE BIT, @SUBORDINATE_TYPE BIT, @SUBORDINATE_TYPE_UPDATE BIT, @SENIORITY_LEVEL_2 BIT, @SENIORITY_LEVEL_2_UPDATE BIT, @OPTION_ROOT_TICKER BIT, @OPTION_ROOT_TICKER_UPDATE BIT, @PUT_CALL_INDICATOR BIT, @PUT_CALL_INDICATOR_UPDATE BIT, @EXPIRY_DATE BIT, @EXPIRY_DATE_UPDATE BIT, @FUTURE_EXPIRY_MONTH_YEAR BIT, @FUTURE_EXPIRY_MONTH_YEAR_UPDATE BIT, @EXERCISE_TYPE BIT, @EXERCISE_TYPE_UPDATE BIT, @CONTRACT_SIZE BIT, @CONTRACT_SIZE_UPDATE BIT, @CONTRACT_VALUE BIT, @CONTRACT_VALUE_UPDATE BIT, @FUTURE_TYPE BIT, @FUTURE_TYPE_UPDATE BIT, @LAST_TRADE_DATE BIT, @LAST_TRADE_DATE_UPDATE BIT, @LONG_EXCHANGE_NAME BIT, @LONG_EXCHANGE_NAME_UPDATE BIT, @DELTA BIT, @DELTA_UPDATE BIT, @GAMMA BIT, @GAMMA_UPDATE BIT, @THETA BIT, @THETA_UPDATE BIT, @VEGA BIT, @VEGA_UPDATE BIT, @EURO_FUTURE_INDICATOR BIT, @EURO_FUTURE_INDICATOR_UPDATE BIT, @CONVERSION_FACTOR BIT, @CONVERSION_FACTOR_UPDATE BIT, @CTD_CONVERSION_DURATION BIT, @CTD_CONVERSION_DURATION_UPDATE BIT, @CTD_ISIN BIT, @CTD_ISIN_UPDATE BIT, @CTD_SEDOL BIT, @CTD_SEDOL_UPDATE BIT, @CTD_RISK_TYPE BIT, @CTD_RISK_TYPE_UPDATE BIT, @FUTURE_DAYS_TO_EXPIRY BIT, @FUTURE_DAYS_TO_EXPIRY_UPDATE BIT, @FUTURE_LONGNAME BIT, @FUTURE_LONGNAME_UPDATE BIT, @STRIKE_PRICE BIT, @STRIKE_PRICE_UPDATE BIT, @TICK_SIZE BIT, @TICK_SIZE_UPDATE BIT, @MARKET_CAP BIT, @MARKET_CAP_UPDATE BIT, @AVERAGE_VOLUME_100D BIT, @AVERAGE_VOLUME_100D_UPDATE BIT, @AVERAGE_VOLUME_30D BIT, @AVERAGE_VOLUME_30D_UPDATE BIT, @VOTING_RIGHTS BIT, @VOTING_RIGHTS_UPDATE BIT, @PAR_AMOUNT BIT, @PAR_AMOUNT_UPDATE BIT, @OPEN_INTEREST BIT, @OPEN_INTEREST_UPDATE BIT, @BASE_ACCRUAL_RATE_DATE BIT, @BASE_ACCRUAL_RATE_DATE_UPDATE BIT, @UNDERLYING_BASE_CPI BIT, @UNDERLYING_BASE_CPI_UPDATE BIT, @BASIC_SPREAD_PCT BIT, @BASIC_SPREAD_PCT_UPDATE BIT, @MID_CONVEXITY BIT, @MID_CONVEXITY_UPDATE BIT, @MID_DISCOUNT_MARGIN BIT, @MID_DISCOUNT_MARGIN_UPDATE BIT, @MID_DISCOUNT_MARGIN_TO_NEXT_CALL BIT, @MID_DISCOUNT_MARGIN_TO_NEXT_CALL_UPDATE BIT, @MID_MODIFIED_DURATION BIT, @MID_MODIFIED_DURATION_UPDATE BIT, @MID_MACAULAY_DURATION BIT, @MID_MACAULAY_DURATION_UPDATE BIT, @MID_SPREAD_DURATION BIT, @MID_SPREAD_DURATION_UPDATE BIT, @FLOATER_SPREAD_BP BIT, @FLOATER_SPREAD_BP_UPDATE BIT, @MORTGAGE_GENERIC_CPR_ISSUE BIT, @MORTGAGE_GENERIC_CPR_ISSUE_UPDATE BIT, @MORTGAGE_GENERIC_PSA_ISSUE BIT, @MORTGAGE_GENERIC_PSA_ISSUE_UPDATE BIT, @MORTGAGE_ORIGINAL_WAC BIT, @MORTGAGE_ORIGINAL_WAC_UPDATE BIT, @MORTGAGE_ORIGINAL_WAM BIT, @MORTGAGE_ORIGINAL_WAM_UPDATE BIT, @MORTGAGE_POOL_PSA_ISSUE BIT, @MORTGAGE_POOL_PSA_ISSUE_UPDATE BIT, @MORTGAGE_PRINCIPAL_LOSSES BIT, @MORTGAGE_PRINCIPAL_LOSSES_UPDATE BIT, @MORTGAGE_WAL_YEARS BIT, @MORTGAGE_WAL_YEARS_UPDATE BIT, @MORTGAGE_WAM_MONTHS BIT, @MORTGAGE_WAM_MONTHS_UPDATE BIT, @MID_OAS_SPREAD_DURATION BIT, @MID_OAS_SPREAD_DURATION_UPDATE BIT, @MID_YIELD_TO_CONVENTION BIT, @MID_YIELD_TO_CONVENTION_UPDATE BIT, @ASK_YIELD_TO_NEXT_CALL BIT, @ASK_YIELD_TO_NEXT_CALL_UPDATE BIT, @ASK_YIELD_TO_MATURITY BIT, @ASK_YIELD_TO_MATURITY_UPDATE BIT, @MID_YIELD_TO_MATURITY BIT, @MID_YIELD_TO_MATURITY_UPDATE BIT, @MID_Z_SPREAD_BP BIT, @MID_Z_SPREAD_BP_UPDATE BIT, @ANNUAL_MODIFIED_DURATION BIT, @ANNUAL_MODIFIED_DURATION_UPDATE BIT, @SEMI_ANNUAL_MODIFIED_DURATION BIT, @SEMI_ANNUAL_MODIFIED_DURATION_UPDATE BIT, @ISMA_MODIFIED_DURATION BIT, @ISMA_MODIFIED_DURATION_UPDATE BIT, @MODIFIED_DURATION BIT, @MODIFIED_DURATION_UPDATE BIT, @YIELD_TO_MATURITY BIT, @YIELD_TO_MATURITY_UPDATE BIT, @ANNUAL_YIELD BIT, @ANNUAL_YIELD_UPDATE BIT, @SEMI_ANNUAL_YIELD BIT, @SEMI_ANNUAL_YIELD_UPDATE BIT, @ISMA_YIELD BIT, @ISMA_YIELD_UPDATE BIT, @OAS BIT, @OAS_UPDATE BIT, @Z_SPREAD BIT, @Z_SPREAD_UPDATE BIT, @EXPECTED_REMAINING_LIFE BIT, @EXPECTED_REMAINING_LIFE_UPDATE BIT, @MATURITY_WAL BIT, @MATURITY_WAL_UPDATE BIT, @EQUITY_UNDERLYING_TICKER BIT, @EQUITY_UNDERLYING_TICKER_UPDATE BIT, @DIVIDEND_CCY BIT, @DIVIDEND_CCY_UPDATE BIT, @CADIS_SYSTEM_INSERTED DATETIME, @CADIS_SYSTEM_INSERTED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


