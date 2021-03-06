﻿CREATE TABLE [CADIS_PROC].[DC_UPMASSECFI_RESET_PREP] (
    [EDM_SEC_ID]                             INT           NOT NULL,
    [ISSUE_DATE]                             BIT           NULL,
    [MATURITY_DATE]                          BIT           NULL,
    [COUPON_RATE]                            BIT           NULL,
    [COUPON_FREQUENCY]                       BIT           NULL,
    [COUPON_TYPE]                            BIT           NULL,
    [CONVERTIBLE_INDICATOR]                  BIT           NULL,
    [AMOUNT_ISSUED]                          BIT           NULL,
    [AMOUNT_OUTSTANDING]                     BIT           NULL,
    [COUPON_CAP]                             BIT           NULL,
    [COUPON_ISO_CCY]                         BIT           NULL,
    [COUPON_FLOOR]                           BIT           NULL,
    [ISSUE_PRICE]                            BIT           NULL,
    [DAY_COUNT]                              BIT           NULL,
    [FIRST_COUPON_DATE]                      BIT           NULL,
    [FIRST_SETTLE_DATE]                      BIT           NULL,
    [PREVIOUS_COUPON_DATE]                   BIT           NULL,
    [NEXT_COUPON_DATE]                       BIT           NULL,
    [NEXT_CALL_DATE]                         BIT           NULL,
    [NEXT_CALL_PRICE]                        BIT           NULL,
    [LAST_RESET_DATE]                        BIT           NULL,
    [NEXT_RESET_DATE]                        BIT           NULL,
    [SECOND_COUPON_DATE]                     BIT           NULL,
    [FIXED_INDICATOR]                        BIT           NULL,
    [FIX_TO_FLOAT_INDICATOR]                 BIT           NULL,
    [FLOATER_INDICATOR]                      BIT           NULL,
    [FLOAT_TO_FIX_INDICATOR]                 BIT           NULL,
    [INDEX_LINKED_INDICATOR]                 BIT           NULL,
    [INFLATION_LINKED_INDICATOR]             BIT           NULL,
    [PERPETUAL_INDICATOR]                    BIT           NULL,
    [ZERO_COUPON_INDICATOR]                  BIT           NULL,
    [ACCRUED_INTEREST_PER_100]               BIT           NULL,
    [ACCRUED_INTEREST_DATE]                  BIT           NULL,
    [COLLATERAL_TYPE]                        BIT           NULL,
    [AGGREGATE_AMOUNT_ISSUED_INDICATOR]      BIT           NULL,
    [ASSUMED_INDEX_VALUE]                    BIT           NULL,
    [BRADY_INDICATOR]                        BIT           NULL,
    [CALCULATION_TYPE]                       BIT           NULL,
    [CALLABLE_INDICATOR]                     BIT           NULL,
    [CALLED_INDICATOR]                       BIT           NULL,
    [CALL_DAYS_NOTICE]                       BIT           NULL,
    [PUTABLE_INDICATOR]                      BIT           NULL,
    [PUT_DAYS_NOTICE]                        BIT           NULL,
    [CASH_SETTLED_INDICATOR]                 BIT           NULL,
    [CDS_RECOVERY_RATE]                      BIT           NULL,
    [CORPORATE_TO_EQUITY_TICKER]             BIT           NULL,
    [FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE]    BIT           NULL,
    [DEFAULTED_INDICATOR]                    BIT           NULL,
    [EXCHANGEABLE_INDICATOR]                 BIT           NULL,
    [FLOATER_COUPON_CONVENTION]              BIT           NULL,
    [FLOATER_LOCKOUT_PERIOD]                 BIT           NULL,
    [FLOATER_PAY_DAY]                        BIT           NULL,
    [JUNIOR_INDICATOR]                       BIT           NULL,
    [SENIOR_INDICATOR]                       BIT           NULL,
    [REGULATION_S_INDICATOR]                 BIT           NULL,
    [SUBORDINATED_INDICATOR]                 BIT           NULL,
    [UNIT_TRADED_INDICATOR]                  BIT           NULL,
    [LOAN_PARTICIPATION_NOTE_INDICATOR]      BIT           NULL,
    [ORIGINAL_ISSUE_DISCOUNT_INDICATOR]      BIT           NULL,
    [GILT_DIGITS]                            BIT           NULL,
    [GILTS_EX_DIVIDEND_DATE]                 BIT           NULL,
    [INDEX_RATIO_CPI]                        BIT           NULL,
    [MINIMUM_INCREMENT]                      BIT           NULL,
    [MINIMUM_PIECE]                          BIT           NULL,
    [MOST_RECENT_REPORTED_FACTOR]            BIT           NULL,
    [MOST_RECENT_ACCRUAL_RATE]               BIT           NULL,
    [MOST_RECENT_ACCRUAL_RATE_START_DATE]    BIT           NULL,
    [MORTGAGE_DEAL_CALL_DATE]                BIT           NULL,
    [MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY] BIT           NULL,
    [MORTGAGE_FACTOR_DATE]                   BIT           NULL,
    [MORTGAGE_CURRENT_PAYMENT_RATE]          BIT           NULL,
    [MORTGAGE_FINAL_PAY_DATE]                BIT           NULL,
    [MORTGAGE_FIRST_PAY_DATE]                BIT           NULL,
    [MORTGAGE_LIFE_FLOOR]                    BIT           NULL,
    [MORTGAGE_PAYMENT_DELAY]                 BIT           NULL,
    [MORTGAGE_RATE_CHANGE_FREQUENCY]         BIT           NULL,
    [MORTGAGE_TRANCHE_TYPE]                  BIT           NULL,
    [MATURITY_REFUND_TYPE]                   BIT           NULL,
    [NOMINAL_PAYMENT_DAY]                    BIT           NULL,
    [PENULTIMATE_COUPON_DATE]                BIT           NULL,
    [REDEMPTION_VALUE]                       BIT           NULL,
    [UNDERLYING_REFERENCE_INDEX]             BIT           NULL,
    [RESET_FREQUENCY]                        BIT           NULL,
    [RESET_INDEX]                            BIT           NULL,
    [SINK_TYPE]                              BIT           NULL,
    [SINKABLE_INDICATOR]                     BIT           NULL,
    [STEPUP_STEPDOWN_COUPON]                 BIT           NULL,
    [STEPUP_STEPDOWN_COUPON_DATE]            BIT           NULL,
    [STRUCTURED_NOTE_INDICATOR]              BIT           NULL,
    [LOWER_TIER2_CAPITAL_INDICATOR]          BIT           NULL,
    [TIER1_CAPITAL_INDICATOR]                BIT           NULL,
    [TIER2_CAPITAL_NON_SPECIFIC_INDICATOR]   BIT           NULL,
    [UPPER_TIER2_CAPITAL_INDICATOR]          BIT           NULL,
    [EX_DIVIDEND_DAYS]                       BIT           NULL,
    [EX_DIVIDEND_DAYS_CALENDAR_CODE]         BIT           NULL,
    [SUBORDINATE_TYPE]                       BIT           NULL,
    [SENIORITY_LEVEL_2]                      BIT           NULL,
    [CADIS_SYSTEM_INSERTED]                  DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]                   DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]                 NVARCHAR (50) NULL,
    [CADIS_SYSTEM_PRIORITY]                  INT           NULL,
    [CADIS_SYSTEM_TIMESTAMP]                 ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 80)
);

