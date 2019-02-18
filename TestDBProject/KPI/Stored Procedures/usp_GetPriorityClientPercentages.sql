
--PriorityClientsTime
--NPriorityClientTimeCount
--PriorityClientsTimeCount

CREATE Procedure [KPI].[usp_GetPriorityClientPercentages]
@p_KPIDBBK varchar(25)
as

BEGIN
Declare @KPIDBBK varchar (25)
Set @KPIDBBK=@p_KPIDBBK
DEclare @KPIid_PriorityClientCount int
DEclare @KPIid_NPriorityClientCount int
Declare @RefreshFrequency int
Declare @StartDate date
Declare @EndDate date
DECLARE @KPIBK int
Declare @Data table
    (KPI_ID int,
    MeasureId int,
    percentage decimal(19,5),
    LastUpdated varchar(30))
Select @KPIid_PriorityClientCount = KPIId from [KPI].[MeasuredKPIs] where [KPIDBBK]='PriorityClientsTimeCount'
Select @KPIid_NPriorityClientCount = KPIId from [KPI].[MeasuredKPIs] where [KPIDBBK]='NPriorityClientTimeCount'
--select @KPIid_PriorityClientCount,@KPIid_NPriorityClientCount
Select @RefreshFrequency = RefreshFrequencyId,@KPIBK=KPIBK from [KPI].[MeasuredKPIs] where [KPIDBBK]=@KPIDBBK
DEclare StartEnd cursor for
Select distinct 
 case when @ReFreshFrequency=1 then [CalendarDate]
    when @ReFreshFrequency=2 then  DATEADD(day,
              -1 - (DATEPART(dw, GETDATE()) + @@DATEFIRST - 2) % 7,
              CalendarDate)  
   when @ReFreshFrequency=3 then [LastDayOfMonth]
    when @ReFreshFrequency=4 then [LastDayOfQuarter]
    when @ReFreshFrequency=5 then [LastDayOfYear]
    when @ReFreshFrequency=7 then [FiscalLastDayOfYear]
    end as periodEnd,
    case when @ReFreshFrequency=1 then [CalendarDate]
    when @ReFreshFrequency=2 then  DATEADD(day,
              -1 - (DATEPART(dw, GETDATE()) + @@DATEFIRST - 2) % 7,
              CalendarDate)  
   when @ReFreshFrequency=3 then [FirstDayOfMonth]
    when @ReFreshFrequency=4 then [FirstDayOfQuarter]
    when @ReFreshFrequency=5 then [FirstDayOfYear]
    when @ReFreshFrequency=7 then [FiscalFirstDayOfYear]
    end as periodStart
    from Core.Calendar

    OPEN StartEnd   
FETCH NEXT FROM StartEnd INTO @EndDate,@StartDate  

WHILE @@FETCH_STATUS = 0   
BEGIN


BEGIN TRY
     insert into @Data Select
     @KPIBK as KPI_ID,
      format(@EndDate,'yyyyMMdd') as MeasureDateId , 
      sum(case when KPIId=@KPIid_PriorityClientCount then isnull(MeasureValue,0) else 0 end) / sum(isnull(MeasureValue,0)) as percentage,
      format(@EndDate,'yyyy-MM-ddTHH:mm:ss')  as LastUpdated
       from  [Fact].[KPIFact] 
 where KPIId in (@KPIid_PriorityClientCount,@KPIid_NPriorityClientCount)
 and MeasureDateId>=format(@StartDate,'yyyyMMdd')
 and MeasureDateId<=format(@EndDate,'yyyyMMdd')
END TRY
BEGIN CATCH
END CATCH
      FETCH NEXT FROM StartEnd INTO @EndDate,@StartDate 
END   
Select KPI_ID,MeasureId,Percentage,0 as Target,LastUpdated from @Data where percentage is not null
CLOSE StartEnd   
DEALLOCATE StartEnd

END
