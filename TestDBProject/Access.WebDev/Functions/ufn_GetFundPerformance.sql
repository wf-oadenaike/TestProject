

-------------------------------------------------------------------------------------- 
-- Name:  [Access.WebDev].[ufn_GetFundPerformance] 
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu: 20/08/2018 JIRA: DAP-1668 [Modify Function with new table]
--
-- 
-------------------------------------------------------------------------------------- 

CREATE function  [Access.WebDev].[ufn_GetFundPerformance] 
(
    @ReportDate varchar(20) = NULL
)


-------------------------------------------------------------------------------------- 
-- Name: [Schema].[usp_FuncName]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu:  29/06/2018 JIRA: DAP-
--
-- 
-------------------------------------------------------------------------------------- 


returns @OutputTable table
(
    BenchMark				varchar(100) null,
	FundCode                varchar(100)       ,
    ReportDate              varchar(20)          null ,
    EndWeightPort           decimal(18,2) null ,
    EndWeightBench          decimal(18,2) null ,
    EndWeightDelta          decimal(18,2) null ,
    RtnDayPort              decimal(18,2) null ,
    RtnDayBench             decimal(18,2) null ,
    RtnDayDelta             decimal(18,2) null ,
    RtnWtdPort              decimal(18,2) null ,
    RtnWtdBench             decimal(18,2) null ,
    RtnWtdDelta             decimal(18,2) null ,
    RtnMtdPort              decimal(18,2) null ,
    RtnMtdBench             decimal(18,2) null ,
    RtnMtdDelta             decimal(18,2) null ,
    RtnQtdPort              decimal(18,2) null , -- IanMc 1.12.16 Added new QTD cols
    RtnQtdBench             decimal(18,2) null ,
    RtnQtdDelta             decimal(18,2) null ,
    RtnYtdPort              decimal(18,2) null ,
    RtnYtdBench             decimal(18,2) null ,
    RtnYtdDelta             decimal(18,2) null
)
as

begin

    if @ReportDate is null

        set @ReportDate =
        (
              select   max(ReportDate)
            from       [dbo].[T_BBG_DAILY_FUND_PERFORMANCE]
		)
    insert into @OutputTable
    (
		BenchMark          ,
	    FundCode           ,
        ReportDate         ,
        EndWeightPort      ,
        EndWeightBench     ,
        EndWeightDelta     ,
        RtnDayPort         ,
        RtnDayBench        ,
        RtnDayDelta        ,
        RtnWtdPort         ,
        RtnWtdBench        ,
        RtnWtdDelta        ,
        RtnMtdPort         ,
        RtnMtdBench        ,
        RtnMtdDelta        ,
        RtnQtdPort         , -- IanMc 1.12.16 Added new QTD cols
        RtnQtdBench        ,
        RtnQtdDelta        ,
        RtnYtdPort         ,
        RtnYtdBench        ,
        RtnYtdDelta
    )
   select     
				PortfolioGroup as BenchMark,
				Fund as FundCode ,
				ReportDate as ReportDate,
                isnull(EndWeightPort,0) as EndWeightPort,
                isnull(EndWeightBench,0) as EndWeightBench  ,
				isnull(ENDWeight,0) AS  EndWeightDelta ,
                isnull([RtnDayPort],0) as RtnDayPort,
                isnull(RtnDayBench,0)  as RtnDayBench,
                isnull(RtnDay,0)    as   RtnDayDelta,
                isnull(RtnWtdPort,0)  as RtnWtdPort      ,
                isnull(RtnWtdBench,0)  as RtnWtdBench     ,
                isnull(RtnWTD,0) as RtnWtdDelta      ,
				isnull(RtnMtdPort,0)  as RtnMtdPort  , 
                isnull(RtnMtdBench,0) as RtnMtdBench        ,
                isnull(RtnMtd,0) as RtnMtdDelta        ,
                isnull(RtnQtdPort,0) as RtnQtdPort         , 
                isnull(RtnQtdBench,0) as  RtnQtdBench        ,
                isnull(RtnQtd,0) as  RtnQtdDelta        ,
                isnull(RtnYtdPort,0) as RtnYtdPort         ,
                isnull(RtnYtdBench,0) as RtnYtdBench        ,
                isnull(RtnYtd,0) as RtnYtdDelta
    from        [dbo].[T_BBG_DAILY_FUND_PERFORMANCE]
    where       ReportDate =  @ReportDate


	return
end

