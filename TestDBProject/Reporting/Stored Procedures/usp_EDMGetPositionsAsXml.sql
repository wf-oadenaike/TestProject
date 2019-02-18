﻿CREATE PROCEDURE [Reporting].[usp_EDMGetPositionsAsXml]
	@ReportDate DATE = NULL
AS
SET NOCOUNT ON

IF (@ReportDate IS NULL)
BEGIN
	SET @ReportDate = (CASE WHEN DATENAME(DW, GETDATE()) = 'MONDAY' THEN DATEADD(dd, -3, GETDATE()) ELSE DATEADD(dd, -1, GETDATE()) END)
END
--Declare @xmldata VARCHAR(MAX)
--SET @xmlData = '<positions>' + (
SELECT 
		ROW_NUMBER() 
        OVER (ORDER BY [FUND_SHORT_NAME], [Position_DATE], pos.[EDM_SEC_ID])  AS RowNumber
		,CONVERT(VARCHAR(10),@ReportDate) AS [PositionDate]
	  ,ISNULL(pos.[SOURCE],'') AS [SOURCE]
      ,ISNULL(pos.[POSITION_TYPE],'') AS [POSITION_TYPE]
      ,ISNULL(pos.[EDM_SEC_ID],'') AS [EDM_SEC_ID]
      ,ISNULL(pos.[FUND_SHORT_NAME],'') AS [FUND_SHORT_NAME]
      ,ISNULL(pos.[LONG_SHORT_IND],'') AS [LONG_SHORT_IND]
      ,pos.[POSITION_DATE]
	  ,ISNULL(prc.[MASTER_PRICE],0) AS [PRICE]
      ,ISNULL(pos.[QUANTITY],0) AS [QUANTITY]
	  ,ISNULL(sec.[SECURITY_NAME],'') AS [SECURITY_NAME]
      ,ISNULL(sec.[SECURITY_DESCRIPTION],'') AS [SECURITY_DESCRIPTION]
      ,ISNULL(sec.[SECURITY_SHORTNAME],'') AS [SECURITY_SHORTNAME]
      ,ISNULL(sec.[ASSET_TYPE],'') AS [ASSET_TYPE]
      ,ISNULL(sec.[SECURITY_TYPE],'') AS [SECURITY_TYPE]
      ,ISNULL(sec.[CUSIP],'') AS [CUSIP]
      ,ISNULL(sec.[ISIN],'') AS [ISIN]
      ,ISNULL(sec.[SEDOL],'') AS [SEDOL]
      ,ISNULL(sec.[TICKER],'') AS [TICKER]
      ,ISNULL(sec.[VALOREN],'') AS [VALOREN]
      ,ISNULL(sec.[WERTPAPIER],'') AS [WERTPAPIER]
      ,ISNULL(COALESCE(sec.[SECURITY_ISO_CCY],prc.[PRICE_ISO_CCY]),'') AS [SECURITY_ISO_CCY]
      ,ISNULL(sec.[RISK_ISO_CCY],'') AS [RISK_ISO_CCY]
      ,ISNULL(sec.[FIXED_ISO_CCY],'') AS [FIXED_ISO_CCY]
      ,ISNULL(sec.[INCORPORATION_ISO_CTY],'') AS [INCORPORATION_ISO_CTY]
      ,ISNULL(sec.[DOMICILE_ISO_CTY],'') AS [DOMICILE_ISO_CTY]
      ,ISNULL(sec.[ISSUE_COUNTRY_ISO],'') AS [ISSUE_COUNTRY_ISO]
      ,ISNULL(sec.[RISK_ISO_CTY],'') AS [RISK_ISO_CTY]
      ,ISNULL(sec.[MIC_EXCHANGE_CODE],'') AS [MIC_EXCHANGE_CODE]
      ,ISNULL(sec.[BBG_EXCHANGE_CODE],'') AS [BBG_EXCHANGE_CODE]
      ,ISNULL(sec.[STATE_CODE],'') AS [STATE_CODE]
      ,ISNULL(sec.[ACTIVE_TRADE_INDICATOR],'') AS [ACTIVE_TRADE_INDICATOR]
      ,ISNULL(sec.[144A_INDICATOR],'') AS [144A_INDICATOR]
      ,ISNULL(sec.[PRIVATE_PLACEMENT_INDICATOR],'') AS [PRIVATE_PLACEMENT_INDICATOR]
      ,ISNULL(sec.[ILLIQUID],'') AS [ILLIQUID]
      ,ISNULL(sec.[QUOTE_TYPE],'') AS [QUOTE_TYPE]
      ,ISNULL(sec.[DAYS_TO_SETTLE],0) AS [DAYS_TO_SETTLE]
      ,ISNULL(sec.[TRADE_SETTLEMENT_CALENDAR_CODE],'') AS [TRADE_SETTLEMENT_CALENDAR_CODE]
      ,ISNULL(sec.[UNIQUE_BLOOMBERG_ID],'') AS [UNIQUE_BLOOMBERG_ID]
      ,ISNULL(sec.[BBG_SECTOR],'') AS [BBG_SECTOR]
      ,ISNULL(sec.[BBG_SUBSECTOR],'') AS [BBG_SUBSECTOR]
      ,ISNULL(sec.[BBG_GROUP],'') AS [BBG_GROUP]
      ,ISNULL(sec.[IS_IPO],'') AS [IS_IPO]
      ,ISNULL(sec.[PARSEKEYABLE_DESCRIPTION],'') AS [PARSEKEYABLE_DESCRIPTION]
	  ,ISNULL(sec.[SECURITY_IDENTIFIER],'') AS [SECURITY_IDENTIFIER]
		,ISNULL(sec.[IRISH_SEDOL_NUMBER],'') AS [IRISH_SEDOL_NUMBER]
		,ISNULL(sec.[PRIMARY_EXCHANGE_NAME],'') AS [PRIMARY_EXCHANGE_NAME]
	,ISNULL(sec.[ISSUER],'') AS [ISSUER]
	,ISNULL(sec.[SECURITY_HAS_ADRS],'') AS [SECURITY_HAS_ADRS]
	  ,ISNULL(CONVERT(VARCHAR(10),eq.[EX_DIVIDEND_DATE]),'') AS [EX_DIVIDEND_DATE]
      ,ISNULL(eq.[DIVIDEND_FREQUENCY],'') AS [DIVIDEND_FREQUENCY]
      ,ISNULL(CONVERT(VARCHAR(10),eq.[DIVIDEND_PAY_DATE]),'') AS [DIVIDEND_PAY_DATE]
      ,ISNULL(eq.[DIVIDEND_PER_SHARE_LAST_NET],0) AS [DIVIDEND_PER_SHARE_LAST_NET]
      ,ISNULL(eq.[DIVIDEND_PER_SHARE_LAST_GROSS],0) AS [DIVIDEND_PER_SHARE_LAST_GROSS]
      ,ISNULL(eq.[DIVIDEND_PER_SHARE_ANNUAL_GROSS],0) AS [DIVIDEND_PER_SHARE_ANNUAL_GROSS]
      ,ISNULL(eq.[DIVIDEND_TYPE],'') AS [DIVIDEND_TYPE]
      ,ISNULL(CONVERT(VARCHAR(10),eq.[DIVIDEND_RECORD_DATE]),'') AS [DIVIDEND_RECORD_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),eq.[CURRENT_STOCK_DIVIDEND_EX_DATE]),'') AS [CURRENT_STOCK_DIVIDEND_EX_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),eq.[CURRENT_STOCK_DIVIDEND_PAY_DATE]),'') AS [CURRENT_STOCK_DIVIDEND_PAY_DATE]
      ,ISNULL(eq.[CURRENT_STOCK_DIVIDEND_PCT],'') AS [CURRENT_STOCK_DIVIDEND_PCT]
      ,ISNULL(eq.[NORMAL_MARKET_SIZE],0) AS [NORMAL_MARKET_SIZE]
      ,ISNULL(eq.[SHARES_OUTSTANDING],0) AS [SHARES_OUTSTANDING]
      ,ISNULL(CONVERT(VARCHAR(10),eq.[SHARES_OUTSTANDING_DATE]),'') AS [SHARES_OUTSTANDING_DATE]
      ,ISNULL(eq.[IPO],'') AS [IPO]
      ,ISNULL(eq.[VOL_WEIGHTED_AVERAGE_PRICE],0) AS [VOL_WEIGHTED_AVERAGE_PRICE]
      ,ISNULL(eq.[FUND_NET_ASSET_VALUE],0) AS [FUND_NET_ASSET_VALUE]
      ,ISNULL(eq.[FUND_TOTAL_ASSETS],0) AS [FUND_TOTAL_ASSETS]
      ,ISNULL(CONVERT(VARCHAR(10),eq.[LAST_UPDATE_DATE_EXCHANGE_TIMEZONE]),'') AS [LAST_UPDATE_DATE_EXCHANGE_TIMEZONE]
      ,ISNULL(eq.[TOTAL_VOTING_SHARES],0) AS [TOTAL_VOTING_SHARES]
	  ,ISNULL(eq.[SHARE_OUTSTANDING_REAL_ACTUAL],0) AS [SHARE_OUTSTANDING_REAL_ACTUAL]
	,ISNULL(eq.[TOTAL_VOTING_SHARES_VALUE],0) AS [TOTAL_VOTING_SHARES_VALUE]
	,ISNULL(eq.[LAST_PUBLISHED_OFFER_NO_OF_SHARES],0) AS [LAST_PUBLISHED_OFFER_NO_OF_SHARES]
	,ISNULL(eq.[SHARE_OUTSTANDING_REAL_VALUE],0) AS [SHARE_OUTSTANDING_REAL_VALUE]
	,ISNULL(eq.[CURRENT_MARKET_CAP],0) AS [CUR_MAR_CAP]
	  ,ISNULL(der.[OPTION_ROOT_TICKER],'') AS [OPTION_ROOT_TICKER]
      ,ISNULL(der.[PUT_CALL_INDICATOR],'') AS [PUT_CALL_INDICATOR]
      ,ISNULL(CONVERT(VARCHAR(10),der.[EXPIRY_DATE]),'') AS [EXPIRY_DATE]
      ,ISNULL(der.[FUTURE_EXPIRY_MONTH_YEAR],'') AS [FUTURE_EXPIRY_MONTH_YEAR]
      ,ISNULL(der.[EXERCISE_TYPE],'') AS [EXERCISE_TYPE]
      ,ISNULL(der.[CONTRACT_SIZE],0) AS [CONTRACT_SIZE]
      ,ISNULL(der.[CONTRACT_VALUE],0) AS [CONTRACT_VALUE]
      ,ISNULL(der.[FUTURE_TYPE],'') AS [FUTURE_TYPE]
      ,ISNULL(CONVERT(VARCHAR(10),der.[LAST_TRADE_DATE]),'') AS [LAST_TRADE_DATE]
      ,ISNULL(der.[LONG_EXCHANGE_NAME],'') AS [LONG_EXCHANGE_NAME]
      ,ISNULL(der.[DELTA],0) AS [DELTA]
      ,ISNULL(der.[GAMMA],0) AS [GAMMA]
      ,ISNULL(der.[THETA],0) AS [THETA]
      ,ISNULL(der.[VEGA],0) AS [VEGA]
      ,ISNULL(der.[EURO_FUTURE_INDICATOR],'') AS [EURO_FUTURE_INDICATOR]
      ,ISNULL(der.[CONVERSION_FACTOR],0) AS [CONVERSION_FACTOR]
      ,ISNULL(der.[CTD_CONVERSION_DURATION],0) AS [CTD_CONVERSION_DURATION]
      ,ISNULL(der.[CTD_ISIN],'') AS [CTD_ISIN]
      ,ISNULL(der.[CTD_SEDOL],'') AS [CTD_SEDOL]
      ,ISNULL(der.[CTD_RISK_TYPE],'') AS [CTD_RISK_TYPE]
      ,ISNULL(der.[FUTURE_DAYS_TO_EXPIRY],0) AS [FUTURE_DAYS_TO_EXPIRY]
      ,ISNULL(der.[FUTURE_LONGNAME],'') AS [FUTURE_LONGNAME]
      ,ISNULL(der.[STRIKE_PRICE],0) AS [STRIKE_PRICE]
      ,ISNULL(der.[TICK_SIZE],0) AS [TICK_SIZE]
	  ,ISNULL(CONVERT(VARCHAR(10),fi.[ISSUE_DATE]),'') AS [ISSUE_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[MATURITY_DATE]),'') AS [MATURITY_DATE]
      ,ISNULL(fi.[COUPON_RATE],0) AS [COUPON_RATE]
      ,ISNULL(fi.[COUPON_FREQUENCY],0) AS [COUPON_FREQUENCY]
      ,ISNULL(fi.[COUPON_TYPE],'') AS [COUPON_TYPE]
      ,ISNULL(fi.[CONVERTIBLE_INDICATOR],'') AS [CONVERTIBLE_INDICATOR]
      ,ISNULL(fi.[AMOUNT_ISSUED],0) AS [AMOUNT_ISSUED]
      ,ISNULL(fi.[AMOUNT_OUTSTANDING],0) AS [AMOUNT_OUTSTANDING]
      ,ISNULL(fi.[COUPON_CAP],0) AS [COUPON_CAP]
      ,ISNULL(fi.[COUPON_ISO_CCY],'') AS [COUPON_ISO_CCY]
      ,ISNULL(fi.[COUPON_FLOOR],0) AS [COUPON_FLOOR]
      ,ISNULL(fi.[ISSUE_PRICE],0) AS [ISSUE_PRICE]
      ,ISNULL(fi.[DAY_COUNT],0) AS [DAY_COUNT]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[FIRST_COUPON_DATE]),'') AS [FIRST_COUPON_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[FIRST_SETTLE_DATE]),'') AS [FIRST_SETTLE_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[PREVIOUS_COUPON_DATE]),'') AS [PREVIOUS_COUPON_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[NEXT_COUPON_DATE]),'') AS [NEXT_COUPON_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[NEXT_CALL_DATE]),'') AS [NEXT_CALL_DATE]
      ,ISNULL(fi.[NEXT_CALL_PRICE],0) AS [NEXT_CALL_PRICE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[LAST_RESET_DATE]),'') AS [LAST_RESET_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[NEXT_RESET_DATE]),'') AS [NEXT_RESET_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[SECOND_COUPON_DATE]),'') AS [SECOND_COUPON_DATE]
      ,ISNULL(fi.[FIXED_INDICATOR],'') AS [FIXED_INDICATOR]
      ,ISNULL(fi.[FIX_TO_FLOAT_INDICATOR],'') AS [FIX_TO_FLOAT_INDICATOR]
      ,ISNULL(fi.[FLOATER_INDICATOR],'') AS [FLOATER_INDICATOR]
      ,ISNULL(fi.[FLOAT_TO_FIX_INDICATOR],'') AS [FLOAT_TO_FIX_INDICATOR]
      ,ISNULL(fi.[INDEX_LINKED_INDICATOR],'') AS [INDEX_LINKED_INDICATOR]
      ,ISNULL(fi.[INFLATION_LINKED_INDICATOR],'') AS [INFLATION_LINKED_INDICATOR]
      ,ISNULL(fi.[PERPETUAL_INDICATOR],'') AS [PERPETUAL_INDICATOR]
      ,ISNULL(fi.[ZERO_COUPON_INDICATOR],'') AS [ZERO_COUPON_INDICATOR]
      ,ISNULL(fi.[ACCRUED_INTEREST_PER_100],0) AS [ACCRUED_INTEREST_PER_100]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[ACCRUED_INTEREST_DATE]),'') AS [ACCRUED_INTEREST_DATE]
      ,ISNULL(fi.[COLLATERAL_TYPE],'') AS [COLLATERAL_TYPE]
      ,ISNULL(fi.[AGGREGATE_AMOUNT_ISSUED_INDICATOR],'') AS [AGGREGATE_AMOUNT_ISSUED_INDICATOR]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[ASSUMED_INDEX_VALUE]),'') AS [ASSUMED_INDEX_VALUE]
      ,ISNULL(fi.[BRADY_INDICATOR],'') AS [BRADY_INDICATOR]
      ,ISNULL(fi.[CALCULATION_TYPE],0) AS [CALCULATION_TYPE]
      ,ISNULL(fi.[CALLABLE_INDICATOR],'') AS [CALLABLE_INDICATOR]
      ,ISNULL(fi.[CALLED_INDICATOR],'') AS [CALLED_INDICATOR]
      ,ISNULL(fi.[CALL_DAYS_NOTICE],0) AS [CALL_DAYS_NOTICE]
      ,ISNULL(fi.[PUTABLE_INDICATOR],'') AS [PUTABLE_INDICATOR]
      ,ISNULL(fi.[PUT_DAYS_NOTICE],0) AS [PUT_DAYS_NOTICE]
      ,ISNULL(fi.[CASH_SETTLED_INDICATOR],'') AS [CASH_SETTLED_INDICATOR]
      ,ISNULL(fi.[CDS_RECOVERY_RATE],0) AS [CDS_RECOVERY_RATE]
      ,ISNULL(fi.[CORPORATE_TO_EQUITY_TICKER],'') AS [CORPORATE_TO_EQUITY_TICKER]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE]),'') AS [FIX_TO_FLOAT_COUPON_TYPE_RESET_DATE]
      ,ISNULL(fi.[DEFAULTED_INDICATOR],'') AS [DEFAULTED_INDICATOR]
      ,ISNULL(fi.[EXCHANGEABLE_INDICATOR],'') AS [EXCHANGEABLE_INDICATOR]
      ,ISNULL(fi.[FLOATER_COUPON_CONVENTION],'') AS [FLOATER_COUPON_CONVENTION]
      ,ISNULL(fi.[FLOATER_LOCKOUT_PERIOD],0) AS [FLOATER_LOCKOUT_PERIOD]
      ,ISNULL(fi.[FLOATER_PAY_DAY],'') AS [FLOATER_PAY_DAY]
      ,ISNULL(fi.[JUNIOR_INDICATOR],'') AS [JUNIOR_INDICATOR]
      ,ISNULL(fi.[SENIOR_INDICATOR],'') AS [SENIOR_INDICATOR]
      ,ISNULL(fi.[REGULATION_S_INDICATOR],'') AS [REGULATION_S_INDICATOR]
      ,ISNULL(fi.[SUBORDINATED_INDICATOR],'') AS [SUBORDINATED_INDICATOR]
      ,ISNULL(fi.[UNIT_TRADED_INDICATOR],'') AS [UNIT_TRADED_INDICATOR]
      ,ISNULL(fi.[LOAN_PARTICIPATION_NOTE_INDICATOR],'') AS [LOAN_PARTICIPATION_NOTE_INDICATOR]
      ,ISNULL(fi.[ORIGINAL_ISSUE_DISCOUNT_INDICATOR],'') AS [ORIGINAL_ISSUE_DISCOUNT_INDICATOR]
      ,ISNULL(fi.[GILT_DIGITS],0) AS [GILT_DIGITS]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[GILTS_EX_DIVIDEND_DATE]),'') AS [GILTS_EX_DIVIDEND_DATE]
      ,ISNULL(fi.[INDEX_RATIO_CPI],0) AS [INDEX_RATIO_CPI]
      ,ISNULL(fi.[MINIMUM_INCREMENT],0) AS [MINIMUM_INCREMENT]
      ,ISNULL(fi.[MINIMUM_PIECE],0) AS [MINIMUM_PIECE]
      ,ISNULL(fi.[MOST_RECENT_REPORTED_FACTOR],0) AS [MOST_RECENT_REPORTED_FACTOR]
      ,ISNULL(fi.[MOST_RECENT_ACCRUAL_RATE],0) AS [MOST_RECENT_ACCRUAL_RATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[MOST_RECENT_ACCRUAL_RATE_START_DATE]),'') AS [MOST_RECENT_ACCRUAL_RATE_START_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[MORTGAGE_DEAL_CALL_DATE]),'') AS [MORTGAGE_DEAL_CALL_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY]),'') AS [MORTGAGE_END_PRINCIPAL_WINDOW_MATURITY]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[MORTGAGE_FACTOR_DATE]),'') AS [MORTGAGE_FACTOR_DATE]
      ,ISNULL(fi.[MORTGAGE_CURRENT_PAYMENT_RATE],0) AS [MORTGAGE_CURRENT_PAYMENT_RATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[MORTGAGE_FINAL_PAY_DATE]),'') AS [MORTGAGE_FINAL_PAY_DATE]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[MORTGAGE_FIRST_PAY_DATE]),'') AS [MORTGAGE_FIRST_PAY_DATE]
      ,ISNULL(fi.[MORTGAGE_LIFE_FLOOR],0) AS [MORTGAGE_LIFE_FLOOR]
      ,ISNULL(fi.[MORTGAGE_PAYMENT_DELAY],'') AS [MORTGAGE_PAYMENT_DELAY]
      ,ISNULL(fi.[MORTGAGE_RATE_CHANGE_FREQUENCY],0) AS [MORTGAGE_RATE_CHANGE_FREQUENCY]
      ,ISNULL(fi.[MORTGAGE_TRANCHE_TYPE],'') AS [MORTGAGE_TRANCHE_TYPE]
      ,ISNULL(fi.[MATURITY_REFUND_TYPE],'') AS [MATURITY_REFUND_TYPE]
      ,ISNULL(fi.[NOMINAL_PAYMENT_DAY],0) AS [NOMINAL_PAYMENT_DAY]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[PENULTIMATE_COUPON_DATE]),'') AS [PENULTIMATE_COUPON_DATE]
      ,ISNULL(fi.[REDEMPTION_VALUE],0) AS [REDEMPTION_VALUE]
      ,ISNULL(fi.[UNDERLYING_REFERENCE_INDEX],'') AS [UNDERLYING_REFERENCE_INDEX]
      ,ISNULL(fi.[RESET_FREQUENCY],0) AS [RESET_FREQUENCY]
      ,ISNULL(fi.[RESET_INDEX],'') AS [RESET_INDEX]
      ,ISNULL(fi.[SINK_TYPE],'') AS [SINK_TYPE]
      ,ISNULL(fi.[SINKABLE_INDICATOR],'') AS [SINKABLE_INDICATOR]
      ,ISNULL(fi.[STEPUP_STEPDOWN_COUPON],0) AS [STEPUP_STEPDOWN_COUPON]
      ,ISNULL(CONVERT(VARCHAR(10),fi.[STEPUP_STEPDOWN_COUPON_DATE]),'') AS [STEPUP_STEPDOWN_COUPON_DATE]
      ,ISNULL(fi.[STRUCTURED_NOTE_INDICATOR],'') AS [STRUCTURED_NOTE_INDICATOR]
      ,ISNULL(fi.[LOWER_TIER2_CAPITAL_INDICATOR],'') AS [LOWER_TIER2_CAPITAL_INDICATOR]
      ,ISNULL(fi.[TIER1_CAPITAL_INDICATOR],'') AS [TIER1_CAPITAL_INDICATOR]
      ,ISNULL(fi.[TIER2_CAPITAL_NON_SPECIFIC_INDICATOR],'') AS [TIER2_CAPITAL_NON_SPECIFIC_INDICATOR]
      ,ISNULL(fi.[UPPER_TIER2_CAPITAL_INDICATOR],'') AS [UPPER_TIER2_CAPITAL_INDICATOR]
      ,ISNULL(fi.[EX_DIVIDEND_DAYS],0) AS [EX_DIVIDEND_DAYS]
      ,ISNULL(fi.[EX_DIVIDEND_DAYS_CALENDAR_CODE],'') AS [EX_DIVIDEND_DAYS_CALENDAR_CODE]
      ,ISNULL(fi.[SUBORDINATE_TYPE],'') AS [SUBORDINATE_TYPE]
      ,ISNULL(fi.[SENIORITY_LEVEL_2],'') AS [SENIORITY_LEVEL_2]
  FROM [dbo].[T_MASTER_POS] pos
  LEFT JOIN [dbo].[T_MASTER_SEC] sec ON sec.EDM_SEC_ID = pos.[EDM_SEC_ID]
  LEFT JOIN [dbo].[T_MASTER_SEC_EQUITY] eq ON eq.EDM_SEC_ID = pos.[EDM_SEC_ID]
  LEFT JOIN [dbo].[T_MASTER_SEC_DERIVATIVE] der ON der.EDM_SEC_ID = pos.[EDM_SEC_ID]
  LEFT JOIN [dbo].[T_MASTER_SEC_FIXED] fi ON fi.EDM_SEC_ID = pos.[EDM_SEC_ID]
  LEFT JOIN [dbo].[T_MASTER_PRC] prc ON prc.EDM_SEC_ID = pos.[EDM_SEC_ID] AND CONVERT(DATE, prc.[PRICE_DATE]) = @ReportDate AND prc.[PRICE_TYPE] = 'EOD'
  WHERE CONVERT(DATE, pos.[POSITION_DATE]) = @ReportDate
  FOR XML AUTO