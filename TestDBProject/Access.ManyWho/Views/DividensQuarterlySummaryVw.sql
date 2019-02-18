CREATE VIEW [Access.ManyWho].[DividensQuarterlySummaryVw]
AS
select 
    DvdQtrSumm.FundShortName,
    (CASE WHEN DVD_FUND_O.[OVERRIDE_GROSS_DVD_VALUE] IS NULL THEN DvdQtrSumm.GrossDvdValue
    ELSE
        DVD_FUND_O.OVERRIDE_GROSS_DVD_VALUE
    END) AS GrossDvdValue,
    (CASE WHEN DVD_FUND_O.[OVERRIDE_NET_DVD_VALUE] IS NULL THEN DvdQtrSumm.NetDvdValue
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
			DvdQtrSumm.DvdRate
		WHEN DVD_FUND_O.[OVERRIDE_NET_DVD_VALUE] IS NULL AND DVD_FUND_O.[OVERRIDE_UNITS] IS NOT NULL THEN 
			DvdQtrSumm.NetDvdValue / DVD_FUND_O.[OVERRIDE_UNITS]
		WHEN DVD_FUND_O.[OVERRIDE_NET_DVD_VALUE] IS NOT NULL AND DVD_FUND_O.[OVERRIDE_UNITS] IS NULL THEN 
			DVD_FUND_O.OVERRIDE_NET_DVD_VALUE / Units
		ELSE
			DVD_FUND_O.OVERRIDE_NET_DVD_VALUE / DVD_FUND_O.[OVERRIDE_UNITS]
    END) AS DvdRate,
    DvdQtrSumm.IncomePeriodQtr,
    DvdQtrSumm.IncomePeriodYr
from
(
    select 
        X.FundShortName,
        GrossDvdValue = SUM(X.GrossDvdValue),
        NetDvdValue = SUM(X.NetDvdValue),
        Units = MAX(NT.Units),
        DvdRate = SUM(X.NetDvdValue) / MAX(NT.Units),
        X.IncomePeriodYr,
        X.IncomePeriodQtr    
    from 
    (
        --// Get quarterly dividends values, note FND.[INCOME_PERIOD_QUARTER_OFFSET] for offsetting exDates per fund income period 
        select 
            DVD.FundShortName,
            DVD.GrossDvdValue,
            DVD.NetDvdValue,
            IncomePeriodYr = DATEPART(YYYY, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], DVD.ExDate)),
            IncomePeriodQtr = DATEPART(QQ, DATEADD(MM, FND.[INCOME_PERIOD_QUARTER_OFFSET], DVD.ExDate))
        from 
            [Access.ManyWho].[Recalc_Overrides] DVD   --// DF - Replaced with Investment.Recalc_Overrides
        inner join 
            [dbo].[T_MASTER_FND]    FND on DVD.FundShortName = FND.SHORT_NAME 
    ) X
    inner join 
        [dbo].[T_NT_EIARPT_PRE]                    NT on X.IncomePeriodYr    = datepart(YYYY, NT.[DATE])
                                                and X.IncomePeriodQtr    = datepart(Q, NT.[DATE])

    inner join
        [dbo].T_REF_GENERAL_MAP                    MAP on MAP.FIELD_NAME    = 'Account Number'
                                                and MAP.SOURCE            = 'NT_FA_Account_Number'
                                                and NT.ACCOUNT_NUMBER    = MAP.SOURCE_CODE 
                                                and X.FundShortName        = MAP.TARGET_CODE 
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