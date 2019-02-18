
CREATE FUNCTION [Access.Webdev].[ufn_GetFEFundPerformanceBySector]
(
	@Sector varchar(20) = NULL
)
RETURNS  TABLE 
AS

-------------------------------------------------------------------------------------- 
-- Name: [Access.Webdev].[ufn_GetFEFundPerformanceBySector]
-- 
-- Params: @Sector
-- Returns: Table
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 01/05/2018 JIRA: DAP-1911 - Created

-------------------------------------------------------------------------------------- 

RETURN
(
SELECT	FILE_DATE,
		CITI_CODE,
		SECTOR,
		PRICE_DATE,
		UNIT_NAME,
		M1_PERFORMANCE,
		M1_RANK,
		M1_QUARTILE,
		Y1_PERFORMANCE,
		Y1_RANK,
		Y1_QUARTILE,
		YTD_PERFORMANCE,
		YTD_RANK,
		YTD_QUARTILE,
		Y3_PERFORMANCE,
		Y3_RANK,
		Y3_QUARTILE,
		D20140616_PERFORMANCE,
		D20140616_RANK,
		D20140616_QUARTILE,
		D20170412_PERFORMANCE,
		D20170412_RANK,
		D20170412_QUARTILE,
		CADIS_SYSTEM_INSERTED,
		CADIS_SYSTEM_UPDATED,
		CADIS_SYSTEM_CHANGEDBY
 FROM	[dbo].[T_FE_FUND_PERFORMANCE]
 WHERE	SECTOR = @Sector
 AND	PRICE_DATE = (SELECT MAX(PRICE_DATE) FROM [dbo].[T_FE_FUND_PERFORMANCE] WHERE	SECTOR = @Sector)
)

