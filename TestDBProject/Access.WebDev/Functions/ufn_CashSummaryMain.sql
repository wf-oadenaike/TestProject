
CREATE FUNCTION [Access.WebDev].[ufn_CashSummaryMain]
(
	@ReportDate DATE = NULL

)
RETURNS @Output TABLE (
		[Rowid] int,
		[Fund] varchar(max) NULL,
		[Capital] varchar(max) NULL,
		[Income] varchar(max) NULL,

		[T_Flows] varchar(max) NULL,
		[T_FX]varchar(max) NULL,
		[T_Trades] varchar(max)NULL,
		[T_Income] varchar(max) NULL,
		[T_Corp_Action] varchar(max) NULL,
		[T_Projected_EOD] varchar(max) NULL,

		[T1_Flows] varchar(max) NULL,
		[T1_FX]varchar(max) NULL,
		[T1_Trades] varchar(max)NULL,
		[T1_Income] varchar(max) NULL,
		[T1_Corp_Action] varchar(max) NULL,
		[T1_Projected_EOD] varchar(max) NULL,

		[T2_Flows] varchar(max) NULL,
		[T2_FX]varchar(max) NULL,
		[T2_Trades] varchar(max)NULL,
		[T2_Income] varchar(max) NULL,
		[T2_Corp_Action] varchar(max) NULL,
		[T2_Projected_EOD] varchar(max) NULL,

		[Percent_Cash] varchar(max) NULL,

		[T3_Flows] varchar(max) NULL,
		[T3_FX]varchar(max) NULL,
		[T3_Trades] varchar(max)NULL,
		[T3_Income] varchar(max) NULL,
		[T3_Corp_Action] varchar(max) NULL,
		[T3_Projected_EOD] varchar(max) NULL,

		[T4_Flows] varchar(max) NULL,
		[T4_FX]varchar(max) NULL,
		[T4_Trades] varchar(max)NULL,
		[T4_Income] varchar(max) NULL,
		[T4_Corp_Action] varchar(max) NULL,
		[T4_Projected_EOD] varchar(max) NULL,

		[T5_Flows] varchar(max) NULL,
		[T5_FX]varchar(max) NULL,
		[T5_Trades] varchar(max)NULL,
		[T5_Income] varchar(max) NULL,
		[T5_Corp_Action] varchar(max) NULL,
		[T5_Projected_EOD] varchar(max) NULL,
		ReportDate Date NULL

)

AS
BEGIN
DECLARE @ReportDateInt int
DECLARE @ReportName varchar(50)='Cash Summary Main'
	
IF @ReportDate IS NULL
    SET @ReportDateInt = (SELECT MAX(ReportDate) FROM [Core].[StaticSpreadsheetData] where reportName=@ReportName);
ELSE 
	SET @ReportDateInt = (SELECT CAST (CONVERT(VARCHAR(10), @ReportDate, 112) as int));


  INSERT INTO @Output
  (
  		[Rowid] ,
		[Fund] ,
		[Capital] ,
		[Income] ,

		[T_Flows] ,
		[T_FX],
		[T_Trades] ,
		[T_Income] ,
		[T_Corp_Action] ,
		[T_Projected_EOD] ,

		[T1_Flows] ,
		[T1_FX],
		[T1_Trades] ,
		[T1_Income] ,
		[T1_Corp_Action] ,
		[T1_Projected_EOD] ,

		[T2_Flows] ,
		[T2_FX],
		[T2_Trades] ,
		[T2_Income] ,
		[T2_Corp_Action] ,
		[T2_Projected_EOD] ,

		[Percent_Cash] ,

		[T3_Flows] ,
		[T3_FX],
		[T3_Trades] ,
		[T3_Income] ,
		[T3_Corp_Action] ,
		[T3_Projected_EOD] ,

		[T4_Flows] ,
		[T4_FX],
		[T4_Trades] ,
		[T4_Income] ,
		[T4_Corp_Action] ,
		[T4_Projected_EOD],
		 
		[T5_Flows] ,
		[T5_FX],
		[T5_Trades] ,
		[T5_Income] ,
		[T5_Corp_Action] ,
		[T5_Projected_EOD],
		ReportDate
  )
  SELECT
  ReportRow,
       [F1]
      ,[F2]
      ,[F3]
      ,[F4]
      ,[F5]
      ,[F6]
      ,[F7]
      ,[F8]
      ,[F9]
      ,[F10]
      ,[F11]
      ,[F12]
      ,[F13]
      ,[F14]
      ,[F15]
      ,[F16]
      ,[F17]
      ,[F18]
      ,[F19]
      ,[F20]
      ,[F21]
      ,[F22]
      ,[F23]
      ,[F24]
      ,[F25]
      ,[F26]
      ,[F27]
      ,[F28]
	  ,[F29]
	  ,[F30]
	  ,[F31]
	  ,[F32]
	  ,[F33]
	  ,[F34]
	  ,[F35]
	  ,[F36]
	  ,[F37]
	  ,[F38]
	  ,[F39]
	  ,[F40]
	  ,ReportExecutionDate

       FROM [Core].[StaticSpreadsheetData]
	WHERE ReportDate=@ReportDateInt and
	ReportName=@ReportName
	and ReportExecutionDate =(select max(ReportExecutionDate) from 
	[Core].[StaticSpreadsheetData] where ReportDate=@ReportDateInt and
	ReportName=@ReportName)
	and F1 is not null
	
   RETURN
   
END
