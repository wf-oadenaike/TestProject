
CREATE VIEW [dbo].[V_REF_DATA_CHANNEL]
AS
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[V_REF_DATA_CHANNEL]
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 05/07/2018 JIRA: DAP-2080

-------------------------------------------------------------------------------------- 

SELECT	[DATACHANNELID], [DESCRIPTION] + ' - ' + CONVERT(VARCHAR(8),[EXPECTED_DELIVERY_TIME]) AS [DESCRIPTION] 
FROM	[CADIS].[VW_SLA_SETTINGS]


