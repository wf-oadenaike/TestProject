
CREATE VIEW [dbo].[V_REF_SUBSCRIBER]
AS
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[V_REF_SUBSCRIBER]
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 05/07/2018 JIRA: DAP-2080

-------------------------------------------------------------------------------------- 

SELECT	SUBSCRIBER_ID, [DESCRIPTION]
FROM	[DBO].[T_REF_SUBSCRIBER]
WHERE	[ACTIVE] = 1

