CREATE FUNCTION [Access.Webdev].[ufn_BBGFundPerformanceAttributionByFund] 
(
@FUND_SHORT_NAME	varchar(15),
@WEEK_END_DATE		datetime,
@TOP_OR_BOTTOM		varchar(6)
)

-------------------------------------------------------------------------------------- 
-- Name: [Access.Webdev].[ufn_BBGFundPerformanceAttributionByFund]
-- 
-- Params:	@FUND_SHORT_NAME Fund Short Name
--			@WEEK_END_DATE	 WTD end date
--			@TOP_OR_BOTTOM		sort on CTR ascending/descending
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 22/08/2017 JIRA: DAP-1243 [Returns top/bottom 5 securities for given WTD for given Fund based on WTD fund performance contribution]
--
-- 
-------------------------------------------------------------------------------------- 

RETURNS @Output TABLE (  
	[ROW_NUM] integer NULL
	, [SECTION] varchar(6)
	, [FUND_SHORT_NAME] VARCHAR(10) NULL   
	, [START_DATE] datetime NULL  
	, [END_DATE] datetime NULL  
	, [ASSET_NAME] varchar(100) NULL  
	, [TICKER] varchar(26) NULL  
	, [CTR_TO_RTN_PORT] decimal(20,10) NULL  
 )   AS  
 
BEGIN
IF @TOP_OR_BOTTOM = 'TOP'
BEGIN
INSERT	INTO @Output
		([ROW_NUM]
		, [SECTION]
		, [FUND_SHORT_NAME]
		, [START_DATE]
		, [END_DATE]
		, [ASSET_NAME]
		, [TICKER]
		, [CTR_TO_RTN_PORT]
		)
SELECT	 TOP 5 ROW_NUMBER() OVER(ORDER BY [CTR_TO_RTN_PORT] DESC) As ROW_NUM
		, 'TOP'
		, [FUND_SHORT_NAME]
		, [START_DATE]
		, [END_DATE]
		, [ASSET_NAME]
		, [TICKER]
		, [CTR_TO_RTN_PORT]
FROM	dbo.T_BBG_FUND_PERFORMANCE_ATTRIBUTION
WHERE	FUND_SHORT_NAME = @FUND_SHORT_NAME
AND		END_DATE = @WEEK_END_DATE
and		[CTR_TO_RTN_PORT] is not null
ORDER	BY [CTR_TO_RTN_PORT] DESC
END

ELSE

BEGIN
INSERT	INTO @Output
		([ROW_NUM]
		, [SECTION]
		, [FUND_SHORT_NAME]
		, [START_DATE]
		, [END_DATE]
		, [ASSET_NAME]
		, [TICKER]
		, [CTR_TO_RTN_PORT]
		)
SELECT	TOP 5 ROW_NUMBER() OVER(ORDER BY [CTR_TO_RTN_PORT] ASC) As ROW_NUM
		, 'BOTTOM'
		, [FUND_SHORT_NAME]
		, [START_DATE]
		, [END_DATE]
		, [ASSET_NAME]
		, [TICKER]
		, [CTR_TO_RTN_PORT] 
FROM	dbo.T_BBG_FUND_PERFORMANCE_ATTRIBUTION
WHERE	FUND_SHORT_NAME = @FUND_SHORT_NAME
AND		END_DATE = @WEEK_END_DATE
and		[CTR_TO_RTN_PORT] is not null
ORDER	BY [CTR_TO_RTN_PORT] ASC
END

RETURN 

END

