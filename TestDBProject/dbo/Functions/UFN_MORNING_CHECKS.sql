CREATE FUNCTION [dbo].[UFN_MORNING_CHECKS] 
(
)

RETURNS @Output TABLE 
(
	[TestCategory] VARCHAR(50) NULL,
    [TestName] VARCHAR(50) NULL,
	[IsPassed] INTEGER NULL,
	[SqlFunction] VARCHAR(50) NULL,
	[Todo] VARCHAR(250) NULL,
	[AsAt] DATETIME NULL
)

AS

BEGIN

/*
PURPOSE: Temporary checks to ensure data is available for CIO \ CEO dashboards

Assumes you're running on EDM prod

DSB	20170710 - Added futher enhancements to prevent false errors when running on Monday, changes can be found by searching for comments that contian 'DSB'
RAD 20170720 - [Access.WebDev].[ufn_TradingReport] returns AsOfTradeDate rather than TradeDate field, check updated accordingly
RAD 20170808 - [Access.WebDev].[ufn_GetInFlows] now accepts two parameters, morning checks script amended accordinly.
RAD 20180213 - [Access.WebDev].[ufn_CashSummaryUnquoted] removed from morning checks
DJF 20180502 - 
RAD 20180621 - replace morning star check with financial express check
*/

--select * from [dbo].[T_MASTER_FND]

declare @prevBusinessDate date

set @prevBusinessDate = (select top 1 CalendarDate from [Core].[Calendar] where IsWeekday = 1 and IsHolidayUK = 0 and cast(CalendarDate as date) < cast(GetDate() as date) order by CalendarDate desc)


declare @ExcludeFund TABLE 
(
	[SHORT_NAME] VARCHAR(50) NULL
)
insert into @ExcludeFund ([SHORT_NAME]) values ('BDSEIF')


--// Check Portfolio Risk KPI ran
--// We only need 1 KPI of the list to have run to check that EDM ran
--// Other errors go direct to Hassan

Declare @PositionDate date
	Set @PositionDate=getdate()
	SET @PositionDate= CONVERT(VARCHAR(10), DATEADD(DAY, CASE DATENAME(WEEKDAY, @PositionDate) 
                        WHEN 'Sunday' THEN -2 
                        WHEN 'Monday' THEN -3 
                        ELSE -1 END, DATEDIFF(DAY, 0, @PositionDate)),120)


if(
	(Select case when count(*)>0 then 1 else 0 end  from fact.KPIFact F join
	[KPI].[MeasuredKPIs] m on F.kpiid=M.kpiid
	where 
	( m.[KPIName] like '% - exposure to any one sector'
	 or  m.[KPIName] like '% - mid-large cap stocks'
	 or  m.[KPIName] like '% - quoted early growth companies'
	 
	 or  m.[KPIName] like '% - quoted early stage companies'
	 or  m.[KPIName] like '% - Unquoted stocks'
	 or  m.[KPIName] like '% - Redemptions (% AuM)'
	 or  m.[KPIName] like '% - Daily AuM'
	 )
	-- order by measuredateid desc
	 and MeasureDateID=convert(varchar(8),@positionDate,112) 
	 )
=1)
insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Portfolio Risk KPI', 'CRITICAL: Fund Count', 1, '[Fact].[usp_MergeKPIFact_PortfolioRisk]')
else
insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Portfolio Risk KPI', 'CRITICAL: Fund Count', 0, '[Fact].[usp_MergeKPIFact_PortfolioRisk]')


--// [Access.WebDev].[ufn_CashSummaryMain] checks
--// ReportDate = today (T)
--// Distinct count of funds = expected number of funds

--select * from [Access.WebDev].[ufn_CashLadderSummaryfundtotal](null)

if 
	(
		(select count(distinct fund) from [Access.WebDev].[ufn_CashLadderSummaryfundtotal](null) where AsOfDate = cast(getdate() as date)) = 
		(select count(Short_Name) from [dbo].[T_MASTER_FND] where Valuation_Period is not null)-- and [SHORT_NAME] not in (select short_name from @ExcludeFund))
	) 
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Cash Summary', 'CRITICAL: Fund Count', 1, '[Access.WebDev].[ufn_CashSummaryMain]')
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Cash Summary', 'CRITICAL: Fund Count', 0, '[Access.WebDev].[ufn_CashSummaryMain]')
	

--// [Access.WebDev].[ufn_EDMDIPsGetDIPsBreakdown] checks
--// Subscriptions and Redemptions (Subs & Reds) data, need more information on business rules but check its not empty.
if 
	(
		(select count(AgentName) from [Access.WebDev].[ufn_EDMDIPsGetDIPsBreakdown](null)) > 0
	) 
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('SubsReds Summary', 'CRITICAL: Has data', 1, '[Access.WebDev].[ufn_EDMDIPsGetDIPsBreakdown]')
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('SubsReds Summary', 'CRITICAL: Has data', 0, '[Access.WebDev].[ufn_EDMDIPsGetDIPsBreakdown]')

	

--// [Access.WebDev].[ufn_GeographicalExposure] checks
--// Position_Date = T-1 (last business day)
--// AUM_Date = T (today)
--// Price_Date = T-1 (last business day) for all securities
--select * from [Access.WebDev].[ufn_GeographicalExposure](null)
--select cast(max(Aum_Date) as date) from [Access.WebDev].[ufn_GeographicalExposure](null)

if 
	(
		--// replace with proper last business day function
		(select count(distinct Fund_Short_Name) from [Access.WebDev].[ufn_GeographicalExposure](null) where Position_date = @prevBusinessDate) = 
		(select count(Short_Name) from [dbo].[T_MASTER_FND] where Valuation_Period is not null and [SHORT_NAME] not in (select short_name from @ExcludeFund))
	) 
	begin
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Geographical Summary', 'CRITICAL: Fund Count', 1, '[Access.WebDev].[ufn_GeographicalExposure]')

		--// AUM_Date = T (today)
		if 
			(
				-- DSB Changed here to use @PositionDate instead of getdate() and greater than instead of '='
				(select cast(max(Aum_Date) as date) from [Access.WebDev].[ufn_GeographicalExposure](null)) >= cast(@PositionDate as date)
			) 
				insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Geographical Summary', 'CRITICAL: AUM Date', 1, '[Access.WebDev].[ufn_GeographicalExposure]')
		else
			insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Geographical Summary', 'CRITICAL: AUM Date', 0, '[Access.WebDev].[ufn_GeographicalExposure]')


		--// Price_Date = T-1 (last business day) for all securities
		if 
			(
				--// replace with proper last business day function
				(select cast(max(Price_Date) as date) from [Access.WebDev].[ufn_GeographicalExposure](null)) = @prevBusinessDate
			) 
				insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Geographical Exposure', 'CRITICAL: Price Date', 1, '[Access.WebDev].[ufn_GeographicalExposure]')
		else
			insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Geographical Exposure', 'CRITICAL: Price Date', 0, '[Access.WebDev].[ufn_GeographicalExposure]')

	end
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Geographical Exposure', 'CRITICAL: Fund Count', 0, '[Access.WebDev].[ufn_GeographicalExposure]')


--// [Access.WebDev].[ufn_GetAUMs] checks
--// Fund count
--// AUM values are not null
--select * from [Access.WebDev].[ufn_GetAUMs](null)


if 
	(	-- DSB for [Access.WebDev].[ufn_GetAUMs](null) rowcount comparison derive the rowcount based on the max LastUpdatedDate instead of LastUpdatedDate = getdate()
		(select count(distinct Fund_Short_Name) from [Access.WebDev].[ufn_GetAUMs](null) where cast(LastUpdatedDate as date) = (select max(cast(LastUpdatedDate as date)) from [Access.WebDev].[ufn_GetAUMs](null))) = 
		(select count(Short_Name) from [dbo].[T_MASTER_FND])
	) 
	begin
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('AUMs', 'CRITICAL: Fund Count', 1, '[Access.WebDev].[ufn_GetAUMs]')

		if 
			(
				(select count(Value) from [Access.WebDev].[ufn_GetAUMs](null) where Value is null) = 0 
			) 
				insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('AUMs', 'CRITICAL: AUM values', 1, '[Access.WebDev].[ufn_GetAUMs]')
		else
			insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('AUMs', 'CRITICAL: AUM values', 0, '[Access.WebDev].[ufn_GetAUMs]')

	end
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('AUMs', 'CRITICAL: Fund Count', 0, '[Access.WebDev].[ufn_GetAUMs]')






--// [Access.WebDev].[ufn_GetFundHoldingsMarketValue] checks
--// Fund count = expected all funds
--// Position_Date = T-1 (last business day)
--// Has a market value
--// Price_Date = T-1 (last business day) for all securities
if 
	( --select * from [Access.WebDev].[ufn_GetFundHoldingsMarketValue](null)
		--// replace with proper last business day function
		(select count(distinct Fund_Short_Name) from [Access.WebDev].[ufn_GetFundHoldingsMarketValue](null) where Position_date >= @prevBusinessDate) = 
		(select count(Short_Name) from [dbo].[T_MASTER_FND] where Valuation_Period is not null and [SHORT_NAME] not in (select short_name from @ExcludeFund))
	) 
	begin
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Fund Holdings', 'CRITICAL: Fund Count', 1, '[Access.WebDev].[ufn_GetFundHoldingsMarketValue]')

		--// Has a Market value
		if 
			(
				(select count(Market_Value_Base) from [Access.WebDev].[ufn_GetFundHoldingsMarketValue](null) where Market_Value_Base is not null) > 0
			) 
				insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Fund Holdings', 'CRITICAL: Mkt Value', 1, '[Access.WebDev].[ufn_GetFundHoldingsMarketValue]')
		else
			insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Fund Holdings', 'CRITICAL: Mkt Value', 0, '[Access.WebDev].[ufn_GetFundHoldingsMarketValue]')


		--// Price_Date = T-1 (last business day) for all securities
		if 
			(
				--// replace with proper last business day function
				(select cast(max(Price_Date) as date) from [Access.WebDev].[ufn_GetFundHoldingsMarketValue](null)) >= @prevBusinessDate
			) 
				insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Fund Holdings', 'CRITICAL: Price Date', 1, '[Access.WebDev].[ufn_GetFundHoldingsMarketValue]')
		else
			insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Fund Holdings', 'CRITICAL: Price Date', 0, '[Access.WebDev].[ufn_GetFundHoldingsMarketValue]')

	end
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Fund Holdings', 'CRITICAL: Fund Count', 0, '[Access.WebDev].[ufn_GetFundHoldingsMarketValue]')




--// [Access.WebDev].[ufn_GetFundPerformance] checks
--// Fund count = expected all funds
--// ReportDate = T-1 (last business day)
--select * from [Access.WebDev].[ufn_GetFundPerformance](null)
if 
	(
		--// replace with proper last business day function
		(select count(distinct FundCode) from [Access.WebDev].[ufn_GetFundPerformance](null) where ReportDate = cast(dateadd(dd, -1, getdate()) as date) and FundCode <> 'ALL_LIVE') = 
		(select count(Short_Name) from [dbo].[T_MASTER_FND] where Valuation_Period is not null)
	) 
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Fund Performance', 'CRITICAL: Fund Count for T-1', 1, '[Access.WebDev].[ufn_GetFundPerformance]')
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Fund Performance', 'CRITICAL: Fund Count for T-1', 0, '[Access.WebDev].[ufn_GetFundPerformance]')


--// [Access.WebDev].[ufn_GetInFlows] checks
--// Count of flows, should be flows most days
--// Check flows are only for T-1 or later
if 
	(
		--// replace with proper last business day function
		(select count(FUND_SHORT_NAME) from [Access.WebDev].[ufn_GetInFlows](null,null) where IN_FLOW_DATE is not null) > 0 
	) 
	begin
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('SubsRedsFlows', 'CRITICAL: SubsReds Count', 1, '[Access.WebDev].[ufn_GetInFlows]')

		--// Has a Market value
		if 
			(
				(select min(IN_FLOW_DATE) from [Access.WebDev].[ufn_GetInFlows](null,null) where IN_FLOW_DATE is not null and IN_FLOW_DATE >= @prevBusinessDate ) > 0
			) 
				insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('SubsRedsFlows', 'CRITICAL: >= T-1', 1, '[Access.WebDev].[ufn_GetInFlows]')
		else
			insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('SubsRedsFlows', 'CRITICAL: >= T-1', 0, '[Access.WebDev].[ufn_GetInFlows]')
	end
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('SubsRedsFlows', 'CRITICAL: SubsReds Count', 0, '[Access.WebDev].[ufn_GetInFlows]')




--// [Access.WebDev].[ufn_GetOverdraftDaysCount] checks
--// Expect overdrafts

--select * from [Access.WebDev].[ufn_GetOverdraftDaysCount](null)
--select * from [Access.WebDev].[ufn_GetOverdraftDaysCount]('18 may 2017') order by fund_short_name
--select * from [Access.WebDev].[ufn_GetOverdraftDaysCount]('17 may 2017') order by fund_short_name
--select * from [Access.WebDev].[ufn_GetOverdraftDaysCount]('16 may 2017') order by fund_short_name

if 
	(
		--// replace with proper last business day function
		(select count(distinct FUND_SHORT_NAME) from [Access.WebDev].[ufn_GetOverdraftDaysCount](null)) > 0
	) 
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Overdrafts', 'CRITICAL: Count > 0', 1, '[Access.WebDev].[ufn_GetOverdraftDaysCount]')
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Overdrafts', 'CRITICAL: Count > 0', 0, '[Access.WebDev].[ufn_GetOverdraftDaysCount]')



--// [Access.WebDev].[ufn_GetYTDInFlows] checks
--// Expect inflows
if 
	(
		--// replace with proper last business day function
		(select count(distinct FUND_SHORT_NAME) from [Access.WebDev].[ufn_GetYTDInFlows]()) > 0
	) 
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('SubsRedsYTD', 'CRITICAL: Count > 0', 1, '[Access.WebDev].[ufn_GetYTDInFlows]')
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('SubsRedsYTD', 'CRITICAL: Count > 0', 0, '[Access.WebDev].[ufn_GetYTDInFlows]')



--// [Access.WebDev].[ufn_MarketCommentary] checks
--// Commentary for T-1
if 
	(
		(select count(CommentaryId) from [Access.WebDev].[ufn_MarketCommentary](null) where CommentaryDate >= @prevBusinessDate ) > 0
	) 
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('MktCommentary', 'CRITICAL: Exists T-1', 1, '[Access.WebDev].[ufn_MarketCommentary]')
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('MktCommentary', 'CRITICAL: Exists T-1', 0, '[Access.WebDev].[ufn_MarketCommentary]')



--// [Access.WebDev].[ufn_RegulatoryDetails] checks
--// RegulatoryDetails for T
if 
	(
		(select count(Effective_date) from [Access.WebDev].[ufn_RegulatoryDetails](null) where Effective_date >= cast(getdate() as date)) > 0
	) 
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('RegulatoryDetails', 'CRITICAL: Exists T-1', 1, '[Access.WebDev].[ufn_RegulatoryDetails]')
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('RegulatoryDetails', 'CRITICAL: Exists T-1', 0, '[Access.WebDev].[ufn_RegulatoryDetails]')


--select * from [Access.WebDev].[ufn_RegulatoryLimits](null)
--// [Access.WebDev].[ufn_RegulatoryLimits] checks
--// RegulatoryLimits for T
if 
	(
		(select count(Reportdate) from [Access.WebDev].[ufn_RegulatoryLimits](null) where Reportdate >= cast(getdate() as date)) > 0
	) 
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('RegulatoryLimits', 'CRITICAL: Exists T-1', 1, '[Access.WebDev].[ufn_RegulatoryLimits]')
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('RegulatoryLimits', 'CRITICAL: Exists T-1', 0, '[Access.WebDev].[ufn_RegulatoryLimits]')


--// [Access.WebDev].[ufn_TradingReport] checks
--// Trades exist for T-1
--// Security names are populated, indicating security static data is present
if 
	(
		(select count(asofTradeDate) from [Access.WebDev].[ufn_TradingReport](null,null) where asofTradeDate >= @prevBusinessDate ) > 0
	) 
	begin
		insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('TradingReport', 'CRITICAL: Exists T-1', 1, '[Access.WebDev].[ufn_TradingReport]')

		--// Has a Market value
		if 
			(
				(select count(asofTradeDate) from [Access.WebDev].[ufn_TradingReport](null,null) where asofTradeDate >= @prevBusinessDate and SECURITY_NAME is not null) > 0
			) 
				insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('TradingReport', 'CRITICAL: Has SecurityNames', 1, '[Access.WebDev].[ufn_TradingReport]')
		else
			insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('TradingReport', 'CRITICAL: Has SecurityNames', 0, '[Access.WebDev].[ufn_TradingReport]')
	end
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('TradingReport', 'CRITICAL: Exists T-1', 0, '[Access.WebDev].[ufn_TradingReport]')



--// [Access.WebDev].[ufn_WIMPerformance] checks
--// Trades exist for T-1
--// Security names are populated, indicating security static data is present
-- select * from [Access.WebDev].[ufn_WIMPerformance](null,'WIM Peer Performance') 
if 
	(
		(select count(PRICE_DATE) from [Access.Webdev].[FEFundPerformanceBySectorVw] where PRICE_DATE >= dateadd(dd, -7, cast(getdate() as date)) ) > 0
	) 
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Financial Express Performance', 'CRITICAL: Exists last 7days', 1, '[Access.Webdev].[FEFundPerformanceBySectorVw]')
else
	insert into @Output ([TestCategory], [TestName], [IsPassed], [SqlFunction]) values ('Financial Express Performance', 'CRITICAL: Exists last 7days', 0, '[Access.Webdev].[FEFundPerformanceBySectorVw]')


update @output
set asat = getdate()

RETURN

END

