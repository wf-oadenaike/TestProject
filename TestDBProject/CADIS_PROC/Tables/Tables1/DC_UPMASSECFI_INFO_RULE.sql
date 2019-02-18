﻿CREATE TABLE [CADIS_PROC].[DC_UPMASSECFI_INFO_RULE] (
    [EDM_SEC_ID]                                     INT NOT NULL,
    [ISSUE_DATE__RULEID]                             INT NULL,
    [MATURITY_DATE__RULEID]                          INT NULL,
    [COUPON_RATE__RULEID]                            INT NULL,
    [COUPON_FREQUENCY__RULEID]                       INT NULL,
    [COUPON_TYPE__RULEID]                            INT NULL,
    [CONVERTIBLE_INDICATOR__RULEID]                  INT NULL,
    [AMOUNT_ISSUED__RULEID]                          INT NULL,
    [AMOUNT_OUTSTANDING__RULEID]                     INT NULL,
    [COUPON_CAP__RULEID]                             INT NULL,
    [COUPON_ISO_CCY__RULEID]                         INT NULL,
    [COUPON_FLOOR__RULEID]                           INT NULL,
    [ISSUE_PRICE__RULEID]                            INT NULL,
    [DAY_COUNT__RULEID]                              INT NULL,
    [FIRST_COUPON_DATE__RULEID]                      INT NULL,
    [FIRST_SETTLE_DATE__RULEID]                      INT NULL,
    [PREVIOUS_COUPON_DATE__RULEID]                   INT NULL,
    [NEXT_COUPON_DATE__RULEID]                       INT NULL,
    [NEXT_CALL_DATE__RULEID]                         INT NULL,
    [NEXT_CALL_PRICE__RULEID]                        INT NULL,
    [LAST_RESET_DATE__RULEID]                        INT NULL,
    [NEXT_RESET_DATE__RULEID]                        INT NULL,
    [SECOND_COUPON_DATE__RULEID]                     INT NULL,
    [FIXED_INDICATOR__RULEID]                        INT NULL,
    [FIX_TO_FLOAT_INDICATOR__RULEID]                 INT NULL,
    [FLOATER_INDICATOR__RULEID]                      INT NULL,
    [FLOAT_TO_FIX_INDICATOR__RULEID]                 INT NULL,
    [INDEX_LINKED_INDICATOR__RULEID]                 INT NULL,
    [INFLATION_LINKED_INDICATOR__RULEID]             INT NULL,
    [PERPETUAL_INDICATOR__RULEID]                    INT NULL,
    [ZERO_COUPON_INDICATOR__RULEID]                  INT NULL,
    [ACCRUED_INTEREST_PER_100__RULEID]               INT NULL,
    [ACCRUED_INTEREST_DATE__RULEID]                  INT NULL,
    [COLLATERAL_TYPE__RULEID]                        INT NULL,
    [AGGREGATE_AMOUNT_ISSUED_INDICATOR__RULEID]      INT NULL,
    [ASSUMED_INDEX_VALUE__RULEID]                    INT NULL,
    [BRADY_INDICATOR__RULEID]                        INT NULL,
    [CALCULATION_TYPE__RULEID]                       INT NULL,
    [CALLABLE_INDICATOR__RULEID]                     INT NULL,
    [CALLED_INDICATOR__RULEID]                       INT NULL,
    [CALL_DAYS_NOTICE__RULEID]                       INT NULL,
    [PUTABLE_INDICATOR__RULEID]                      INT NULL,
    [PUT_DAYS_NOTICE__RULEID]                        INT NULL,
    [CASH_SETTLED_INDICATOR__RULEID]                 INT NULL,
    [CDS_RECOVERY_RATE__RULEID]                      INT NULL,
    [CORPORATE_TO_EQUITY_TICKER__RULEID]             INT NULL,
    [FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE__RULEID]    INT NULL,
    [DEFAULTED_INDICATOR__RULEID]                    INT NULL,
    [EXCHANGEABLE_INDICATOR__RULEID]                 INT NULL,
    [FLOATER_COUPON_CONVENTION__RULEID]              INT NULL,
    [FLOATER_LOCKOUT_PERIOD__RULEID]                 INT NULL,
    [FLOATER_PAY_DAY__RULEID]                        INT NULL,
    [JUNIOR_INDICATOR__RULEID]                       INT NULL,
    [SENIOR_INDICATOR__RULEID]                       INT NULL,
    [REGULATION_S_INDICATOR__RULEID]                 INT NULL,
    [SUBORDINATED_INDICATOR__RULEID]                 INT NULL,
    [UNIT_TRADED_INDICATOR__RULEID]                  INT NULL,
    [LOAN_PARTICIPATION_NOTE_INDICATOR__RULEID]      INT NULL,
    [ORIGINAL_ISSUE_DISCOUNT_INDICATOR__RULEID]      INT NULL,
    [GILT_DIGITS__RULEID]                            INT NULL,
    [GILTS_EX_DIVIDEND_DATE__RULEID]                 INT NULL,
    [INDEX_RATIO_CPI__RULEID]                        INT NULL,
    [MINIMUM_INCREMENT__RULEID]                      INT NULL,
    [MINIMUM_PIECE__RULEID]                          INT NULL,
    [MOST_RECENT_REPORTED_FACTOR__RULEID]            INT NULL,
    [MOST_RECENT_ACCRUAL_RATE__RULEID]               INT NULL,
    [MOST_RECENT_ACCRUAL_RATE_START_DATE__RULEID]    INT NULL,
    [MORTGAGE_DEAL_CALL_DATE__RULEID]                INT NULL,
    [MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY__RULEID] INT NULL,
    [MORTGAGE_FACTOR_DATE__RULEID]                   INT NULL,
    [MORTGAGE_CURRENT_PAYMENT_RATE__RULEID]          INT NULL,
    [MORTGAGE_FINAL_PAY_DATE__RULEID]                INT NULL,
    [MORTGAGE_FIRST_PAY_DATE__RULEID]                INT NULL,
    [MORTGAGE_LIFE_FLOOR__RULEID]                    INT NULL,
    [MORTGAGE_PAYMENT_DELAY__RULEID]                 INT NULL,
    [MORTGAGE_RATE_CHANGE_FREQUENCY__RULEID]         INT NULL,
    [MORTGAGE_TRANCHE_TYPE__RULEID]                  INT NULL,
    [MATURITY_REFUND_TYPE__RULEID]                   INT NULL,
    [NOMINAL_PAYMENT_DAY__RULEID]                    INT NULL,
    [PENULTIMATE_COUPON_DATE__RULEID]                INT NULL,
    [REDEMPTION_VALUE__RULEID]                       INT NULL,
    [UNDERLYING_REFERENCE_INDEX__RULEID]             INT NULL,
    [RESET_FREQUENCY__RULEID]                        INT NULL,
    [RESET_INDEX__RULEID]                            INT NULL,
    [SINK_TYPE__RULEID]                              INT NULL,
    [SINKABLE_INDICATOR__RULEID]                     INT NULL,
    [STEPUP_STEPDOWN_COUPON__RULEID]                 INT NULL,
    [STEPUP_STEPDOWN_COUPON_DATE__RULEID]            INT NULL,
    [STRUCTURED_NOTE_INDICATOR__RULEID]              INT NULL,
    [LOWER_TIER2_CAPITAL_INDICATOR__RULEID]          INT NULL,
    [TIER1_CAPITAL_INDICATOR__RULEID]                INT NULL,
    [TIER2_CAPITAL_NON_SPECIFIC_INDICATOR__RULEID]   INT NULL,
    [UPPER_TIER2_CAPITAL_INDICATOR__RULEID]          INT NULL,
    [EX_DIVIDEND_DAYS__RULEID]                       INT NULL,
    [EX_DIVIDEND_DAYS_CALENDAR_CODE__RULEID]         INT NULL,
    [SUBORDINATE_TYPE__RULEID]                       INT NULL,
    [SENIORITY_LEVEL_2__RULEID]                      INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC)
);
