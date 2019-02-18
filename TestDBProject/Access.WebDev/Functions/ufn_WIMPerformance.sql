/*

Modified by JT 2018-01-05
Added report name parameter 
DAP-1567
*/

CREATE FUNCTION [Access.WebDev].[ufn_WIMPerformance]
(
    @ReportDate DATE = NULL,
	@ReportName varchar(50)='WIM Peer Performance'

)
RETURNS @Output TABLE (
        [ReportDate] date,
		[LatestExecutionDate] [datetime],
        [Rowid] int,
        [GroupInvestment] varchar(max) NULL,
        [W1_ReturnCumulative] varchar(max) NULL,
        [W1_PeerGroupRank] varchar(max) NULL,
        [W1_PeerGroupQuartile] varchar(max) NULL,
        [W1_BLANK]varchar(max) NULL,

        [W3_ReturnCumulative] varchar(max)NULL,
        [W3_PeerGroupRank] varchar(max) NULL,
        [W3_PeerGroupQuartile] varchar(max) NULL,
        [W3_BLANK] varchar(max) NULL,

        [M1_ReturnCumulative] varchar(max) NULL,
        [M1_PeerGroupRank] varchar(max) NULL,
        [M1_PeerGroupQuartile] varchar(max) NULL,
        [M1_BLANK] varchar(max) NULL,

        [Q_ReturnCumulative] varchar(max) NULL,
        [Q_PeerGroupRank] varchar(max) NULL,
        [Q_PeerGroupQuartile] varchar(max) NULL,
        [Q_BLANK] varchar(max) NULL,

        [YTD_ReturnCumulative] varchar(max) NULL,
        [YTD_PeerGroupRank] varchar(max) NULL,
        [YTD_PeerGroupQuartile] varchar(max) NULL,
        [YTD_BLANK] varchar(max) NULL,

        [Y_ReturnCumulative] varchar(max) NULL,
        [Y_PeerGroupRank] varchar(max) NULL,
        [Y_PeerGroupQuartile] varchar(max) NULL,
        [Y_BLANK] varchar(max) NULL,

        [SI_ReturnCumulative] varchar(max) NULL,
        [SI_PeerGroupRank] varchar(max) NULL,
        [SI_PeerGroupQuartile] varchar(max) NULL
    

)

AS
BEGIN
DECLARE @ReportDateInt int;
-- DECLARE @ReportName varchar(50)='WIM Peer Performance';
DECLARE @LatestExecutionDate datetime;
    
IF @ReportDate IS NULL
   BEGIN
	SET @ReportDateInt = (SELECT MAX(ReportDate) FROM [Core].[StaticSpreadsheetData] where reportName=@ReportName);
	SET @ReportDate = CONVERT (date,convert(char(8),@ReportDateInt));
   END;
ELSE 
    SET @ReportDateInt = (SELECT CAST (CONVERT(VARCHAR(10), @ReportDate, 112) as int));

	
 SET @LatestExecutionDate = (SELECT MAX ([ReportExecutionDate]) FROM [Core].[StaticSpreadsheetData] WHERE ReportName=@ReportName);
	
 INSERT INTO @Output
 (
 [ReportDate],
 [LatestExecutionDate],
 RowId,
 [GroupInvestment],
        [W1_ReturnCumulative],
        [W1_PeerGroupRank],
        [W1_PeerGroupQuartile],
        [W1_BLANK],

        [W3_ReturnCumulative],
        [W3_PeerGroupRank],
        [W3_PeerGroupQuartile],
        [W3_BLANK],

        [M1_ReturnCumulative],
        [M1_PeerGroupRank],
        [M1_PeerGroupQuartile],
        [M1_BLANK],

        [Q_ReturnCumulative],
        [Q_PeerGroupRank],
        [Q_PeerGroupQuartile],
        [Q_BLANK],

        [YTD_ReturnCumulative],
        [YTD_PeerGroupRank],
        [YTD_PeerGroupQuartile],
        [YTD_BLANK],

        [Y_ReturnCumulative],
        [Y_PeerGroupRank],
        [Y_PeerGroupQuartile],
        [Y_BLANK],

        [SI_ReturnCumulative],
        [SI_PeerGroupRank],
        [SI_PeerGroupQuartile]
	
 )
 SELECT
 @ReportDate,
 @LatestExecutionDate,
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
      FROM [Core].[StaticSpreadsheetData]
    WHERE ReportDate=@ReportDateInt and
    ReportName=@ReportName
    and ReportExecutionDate =(select max(ReportExecutionDate) from 
    [Core].[StaticSpreadsheetData] where ReportDate=@ReportDateInt and
    ReportName=@ReportName)
    and F1 is not null
    
  RETURN
  
END


