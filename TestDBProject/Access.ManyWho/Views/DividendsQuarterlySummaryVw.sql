CREATE VIEW [Access.ManyWho].[DividendsQuarterlySummaryVw]
AS
--/******************************
--** Desc:
--** Auth: D.Fanning
--** Date: 11/09/2017 
--**************************
--** Change History
--**************************
--** JIRA		  Date		  Author	  Description 
--** ----		  ----------  -------	  ------------------------------------
--** DAP-1283     11/09/2017  D.Fanning   DAP-1283 - Dividends - Quarterly Summary
--** DAP-1283     12/09/2017  D.Fanning   DAP-1283 - Added TotalDvdRatePerYearFund
--** DAP-1283     12/09/2017  D.Fanning   DAP-1283 - For the current period (fund specific) use the dividends accrual (PostExNetDvdValue) + FundNetIncome
--** DAP-1283     25/09/2017  D.Fanning   DAP-1283 - For the current period (fund specific) use the dividends accrual (PostExNetDvdValue) + FundNetIncome - Applied to DvdRate
--** DAP-1283     28/09/2017  D.Fanning   DAP-1283 - ISNULL corrections for NetDvdValue and DvdRate values
--*******************************/

Select 
    FundShortName,
	IncomePeriodQtr,
	IncomePeriodYr,
	GrossDvdValue,
	NetDvdValue, 
	Units,
	OriginalGrossDvdValue,
	OriginalNetDvdValue,
	OriginalUnits,
	DvdRate,
	TotalDvdRatePerYearFund = SUM(DvdRate) over (partition by IncomePeriodYr, FundShortName)
from 
(
	Select 
		DvdQtrSumm.FundShortName,
    
		(CASE WHEN DVD_FUND_O.[OVERRIDE_GROSS_DVD_VALUE] IS NULL THEN DvdQtrSumm.GrossDvdValue
		ELSE
			DVD_FUND_O.OVERRIDE_GROSS_DVD_VALUE
		END) AS GrossDvdValue,

		(CASE WHEN DVD_FUND_O.[OVERRIDE_NET_DVD_VALUE] IS NULL THEN 
			--// For the current period (fund specific) use the dividends accrual (PostExNetDvdValue) + FundNetIncome
			(CASE WHEN DvdQtrSumm.IncomePeriodYr = DvdQtrSumm.TodayPeriodYr AND DvdQtrSumm.IncomePeriodQtr = DvdQtrSumm.TodayPeriodQtr THEN ISNULL(CONVERT(DECIMAL(18, 2), DvdQtrSumm.PostExNetDvdValue), 0) + ISNULL(CONVERT(DECIMAL(18, 2), DvdQtrSumm.FundNetIncome), 0) ELSE ISNULL(CONVERT(DECIMAL(18, 2), DvdQtrSumm.NetDvdValue), 0) END)
		ELSE
			DVD_FUND_O.OVERRIDE_NET_DVD_VALUE
		END) AS NetDvdValue,
    
		(CASE WHEN DVD_FUND_O.[OVERRIDE_UNITS] IS NULL THEN DvdQtrSumm.Units
		ELSE
			DVD_FUND_O.OVERRIDE_UNITS
		END) AS Units,
    
		DvdQtrSumm.GrossDvdValue AS OriginalGrossDvdValue,
		DvdQtrSumm.NetDvdValue AS OriginalNetDvdValue,

		DvdQtrSumm.Units AS OriginalUnits,
    
		(CASE 
			WHEN DVD_FUND_O.[OVERRIDE_NET_DVD_VALUE] IS NULL AND DVD_FUND_O.[OVERRIDE_UNITS] IS NULL THEN 
				(CASE WHEN DvdQtrSumm.IncomePeriodYr = DvdQtrSumm.TodayPeriodYr AND DvdQtrSumm.IncomePeriodQtr = DvdQtrSumm.TodayPeriodQtr THEN ISNULL(CONVERT(DECIMAL(18, 2), DvdQtrSumm.PostExNetDvdValue), 0) + ISNULL(CONVERT(DECIMAL(18, 2), DvdQtrSumm.FundNetIncome), 0) ELSE ISNULL(CONVERT(DECIMAL(18, 2), DvdQtrSumm.NetDvdValue), 0) END) / DvdQtrSumm.Units
			WHEN DVD_FUND_O.[OVERRIDE_NET_DVD_VALUE] IS NULL AND DVD_FUND_O.[OVERRIDE_UNITS] IS NOT NULL THEN 
				DvdQtrSumm.NetDvdValue / DVD_FUND_O.[OVERRIDE_UNITS]
			WHEN DVD_FUND_O.[OVERRIDE_NET_DVD_VALUE] IS NOT NULL AND DVD_FUND_O.[OVERRIDE_UNITS] IS NULL THEN 
				DVD_FUND_O.OVERRIDE_NET_DVD_VALUE / DvdQtrSumm.Units
			ELSE
				DVD_FUND_O.OVERRIDE_NET_DVD_VALUE / DVD_FUND_O.[OVERRIDE_UNITS]
		END) * 100 AS DvdRate,

		DvdQtrSumm.IncomePeriodQtr,
		DvdQtrSumm.IncomePeriodYr
	from
	(
		select 
			X.FundShortName,
			GrossDvdValue = MIN(X.GrossDvdValue),
			NetDvdValue = MIN(X.NetDvdValue),
			PostExNetDvdValue = MIN(X.PostExNetDvdValue),
			Units = MAX(NT.Units),
			FundNetIncome = MAX(NT.FUND_NET_INCOME),
			DvdRate = MIN(X.NetDvdValue) / MAX(NT.Units),
			--FundNetIncome = MAX(NT.FUND_NET_INCOME),
			X.IncomePeriodYr,
			X.IncomePeriodQtr, 
			TodayPeriodYr = MIN(X.TodayPeriodYr), 
			TodayPeriodQtr = MIN(X.TodayPeriodQtr)  
		from 
		(
			--// Get quarterly dividends values, note FND.[INCOME_PERIOD_QUARTER_OFFSET] for offsetting exDates per fund income period 
			select 
				ExDate = MIN(DVD.ExDate),
				DVD.FundShortName,
				GrossDvdValue = SUM(DVD.GrossDvdValue),
				NetDvdValue = SUM(DVD.NetDvdValue),
				PostExNetDvdValue = SUM((CASE WHEN DVD.ExDate >= GetDate() THEN DVD.NetDvdValue ELSE 0 END)),
				IncomePeriodYr = DATEPART(YYYY, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], DVD.ExDate)),
				IncomePeriodQtr = DATEPART(QQ, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], DVD.ExDate)),
				TodayPeriodYr = MIN(DATEPART(YYYY, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], getDate()))),
				TodayPeriodQtr = MIN(DATEPART(QQ, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], getDate())))
			from 
				[Access.ManyWho].[Recalc_Overrides] DVD   --// DF - Replaced with Investment.Recalc_Overrides
			inner join 
				[dbo].[T_MASTER_FND]    FND on DVD.FundShortName = FND.SHORT_NAME 
			group by
				 DVD.FundShortName,
				 DATEPART(YYYY, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], DVD.ExDate)),
				 DATEPART(QQ, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], DVD.ExDate))
		) X
		inner join
			[dbo].T_REF_GENERAL_MAP                    MAP on MAP.FIELD_NAME    = 'Account Number'
															and MAP.SOURCE            = 'NT_FA_Account_Number'
															and X.FundShortName        = MAP.TARGET_CODE 

		inner join 
		(
			SELECT Z.ACCOUNT_NUMBER, Z.Units, Z.FUND_NET_INCOME FROM [dbo].[T_NT_EIARPT_PRE] Z 
		) NT on NT.ACCOUNT_NUMBER    = MAP.SOURCE_CODE 


		group by 
			X.FundShortName, 
			X.IncomePeriodYr,
			X.IncomePeriodQtr

	) DvdQtrSumm
	left outer join
		[Investment].[DVD_Fund_Overrides] DVD_FUND_O on DvdQtrSumm.FundShortName = DVD_FUND_O.FUND_SHORT_NAME
													  and DVD_FUND_O.isActive = 1
													  and DvdQtrSumm.IncomePeriodQtr = DVD_FUND_O.Qtr
													  and DvdQtrSumm.IncomePeriodYr = DVD_FUND_O.Yr
) X
