
CREATE FUNCTION [Access.WebDev].[ufn_RiskDashboard]
(
	@ReportDate DATE = NULL

)
RETURNS @Output TABLE (
		[KPIID] [int],
		[lastupdateddatetime] [datetime] NULL,
		[MeasureDateID] [int],
		[MeasureValue] [decimal](19,8) NULL
)

AS
BEGIN
DECLARE @ReportDateInt int
DECLARE @ReportName varchar(50)='RiskDashBoard'
	
IF @ReportDate IS NULL
    SET @ReportDateInt = (SELECT MAX(MeasureDateID) FROM Fact.KPIFact);
ELSE 
	SET @ReportDateInt = (SELECT CAST (CONVERT(VARCHAR(10), @ReportDate, 112) as int));


  INSERT INTO @Output
  (
	[KPIID] ,
	[lastupdateddatetime],
	[MeasureDateID] ,
	[MeasureValue] 
  )

  SELECT F.KPIID,F.lastupdatedDatetime,F.MeasureDateID,F.MeasureValue 
  FROM Fact.KPIFACT F 
			JOIN KPI.MeasuredKPIs K on K.KPIID=F.KPIID
			JOIN Core.RiskDashboardKPIDBBK C on C.KPIDBBK=K.KPIDBBK
	WHERE lastupdatedDatetime=(select max(lastupdateddatetime) FROM 
		Fact.KPIFACT WHERE KPIID=F.KPIID AND MeasureDateID=F.MeasureDateID)
		AND MeasureDateID=@ReportDateInt

   RETURN
   
END
