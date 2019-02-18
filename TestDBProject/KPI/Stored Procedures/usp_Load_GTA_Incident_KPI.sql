-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [KPI].[usp_Load_GTA_Incident_KPI]
	-- Add the parameters for the stored procedure here
@KPIDBBK varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
Declare @FirstDate date;
DECLARE @FACT_KPIID int;
DECLARE @KPIBK int;
Select @FACT_KPIID=KPIID, @KPIBK=KPIBK from KPI.MeasuredKPIs where KPIDBBK=@KPIDBBK
Set @FirstDate='2014-04-01';
--delete from [FACT].[KPIFACT] where KPIID=@FACT_KPIID;
BEGIN TRAN;

BEGIN TRY



--Part 1 just insert where KPIdate exists

INSERT INTO [Fact].[KPIFact]
           ([MeasureDateId]
           ,[KPIId]
           ,[MeasureValue]
           ,[LastUpdatedDatetime]
           ,[ControlId]
           ,[SourceSystemId])
           
Select distinct D.KPIDATADATE,@FACT_KPIID,D.ActualValue,D.UpdatedAt,-1,3  from [FACT].[KPIFACT] F join  [Staging.KPI].[KPIData] D on 
F.KPIID=@FACT_KPIID and D.KPIIDBK=@KPIBK  and F.MEASUREDATEID=D.KPIDATADATE
where D.UpdatedAt>
(Select max(lastUpdatedDateTime) from [FACT].[KPIFACT] where MEASUREDATEID=D.KPIDATADATE and KPIID=F.KPIID )
and F.MeasureValue<>D.ActualValue
and D.KPIIDBK=@KPIBK 
and isnull(D.Notes,'')='Step2'


--insert the new rows
INSERT INTO [Fact].[KPIFact]
           ([MeasureDateId]
           ,[KPIId]
           ,[MeasureValue]
           ,[LastUpdatedDatetime]
           ,[ControlId]
           ,[SourceSystemId])
Select distinct D.KPIDATADATE,@FACT_KPIID,D.ActualValue,D.UpdatedAt,-1,3 
from [FACT].[KPIFACT] F right join  [Staging.KPI].[KPIData] D on 
F.KPIID=@FACT_KPIID and D.KPIIDBK=@KPIBK  and F.MEASUREDATEID=D.KPIDATADATE
where F.KPIID is null
and D.KPIIDBK=@KPIBK 
and isnull(D.Notes,'')='Step2'


--insert the zero rows
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
-- '1900-01-01 00:00:00' as lastupdated 
getdate()  as lastupdated
,-1,3

from GetDates
where not exists (select * from [FACT].[KPIFACT] where 
KPIID=@FACT_KPIID and MEASUREDATEID=format(TheDate, 'yyyyMMdd')
)
and format(TheDate, 'yyyyMMdd')<=format(getDate(), 'yyyyMMdd')
OPTION (MAXRECURSION 2500)
COMMIT TRAN
END TRY

BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber
     ,ERROR_SEVERITY() AS ErrorSeverity
     ,ERROR_STATE() AS ErrorState
     ,ERROR_PROCEDURE() AS ErrorProcedure
     ,ERROR_LINE() AS ErrorLine
     ,ERROR_MESSAGE() AS ErrorMessage;
	ROLLBACK TRAN
END CATCH




END
