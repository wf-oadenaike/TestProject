CREATE FUNCTION [Access.WebDev].[ufn_CashSummaryUnquoted]
(
	@ReportDate DATE = NULL

)

-- DSB	26-09-2017	DAP-1390 for the FUND column (F3) when there is no value in the undewrlying table then present the value as 'NONE'
-- DSB	13-10-2017	DAP-1448 for the TYPE column (F2) when there is no value in the undewrlying table then present the value as 'NONE'

RETURNS @Output TABLE (
		[Rowid] int,
		[Name] varchar(max) NULL,
		[Type] varchar(max) NULL,
		[Fund] varchar(max) NULL,

		[OMNIS1] varchar(max) NULL,
		[OMWEIF] varchar(max) NULL,
		[SJPDST] varchar(max) NULL,
		[SJPHIY] varchar(max) NULL,
		[SPJNUK] varchar(max) NULL,
		[SPJXUK] varchar(max) NULL,

		[WEST01] varchar(max) NULL,
		[WIMEIF]varchar(max) NULL,
		[WIMPCT] varchar(max) NULL,

		ReportDate Date NULL
)

AS
BEGIN
DECLARE @ReportDateInt int
DECLARE @ReportName varchar(50)='Cash Summary Unquoted'
	
IF @ReportDate IS NULL
    SET @ReportDateInt = (SELECT MAX(ReportDate) FROM [Core].[StaticSpreadsheetData] where reportName=@ReportName);
ELSE 
	SET @ReportDateInt = (SELECT CAST (CONVERT(VARCHAR(10), @ReportDate, 112) as int));


  INSERT INTO @Output
  (
  		[Rowid] ,
		[Name] ,
		[Type] ,
		[Fund] ,
		[OMNIS1] ,
		[OMWEIF] ,
		[SJPDST] ,
		[SJPHIY] ,
		[SPJNUK] ,
		[SPJXUK] ,
		[WEST01] ,
		[WIMEIF],
		[WIMPCT],
		ReportDate 
  )
  SELECT
  ReportRow,
       [F1]
      ,ISNULL([F2], 'NONE')
      ,ISNULL([F3], 'NONE')
      ,[F4]
      ,[F5]
      ,[F6]
      ,[F7]
      ,[F8]
      ,[F9]
      ,[F10]
      ,[F11]
      ,[F12]
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

