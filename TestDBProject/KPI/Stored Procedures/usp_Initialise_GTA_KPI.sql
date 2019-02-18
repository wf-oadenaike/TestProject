
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [KPI].[usp_Initialise_GTA_KPI]
	-- Add the parameters for the stored procedure here
@KPIBK int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
Declare @FirstDate date;
DECLARE @FACT_KPIID int;

Select @FACT_KPIID=KPIID from KPI.MeasuredKPIs where KPIBK=@KPIBK
Set @FirstDate='2014-04-01';
delete from [FACT].[KPIFACT] where KPIID=@FACT_KPIID;

;with GetDates As  
(  
select DATEADD(day,1,@FirstDate) as TheDate
UNION ALL  
select DATEADD(day,1, TheDate) from GetDates  
where TheDate < getdate()  
)




INSERT INTO [Fact].[KPIFact]
           ([MeasureDateId]
           ,[KPIId]
           ,[MeasureValue]
           ,[LastUpdatedDatetime]
           ,[ControlId]
           ,[SourceSystemId])
           
 
select  format(TheDate, 'yyyyMMdd') as KPIDate,@FACT_KPIID,0 MeasureValue,
'1900-01-01 00:00:00' as lastupdated ,-1,3
from GetDates
where not exists (select * from [FACT].[KPIFACT] where 
KPIID=@FACT_KPIID and MEASUREDATEID=format(TheDate, 'yyyyMMdd'))
OPTION (MAXRECURSION 2500)
END
