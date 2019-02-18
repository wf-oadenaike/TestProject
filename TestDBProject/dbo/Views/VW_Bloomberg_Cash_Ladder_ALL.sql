CREATE VIEW [dbo].[VW_Bloomberg_Cash_Ladder_ALL] AS
-------------------------------------------------------------------------------------- 
-- Name:			[dbo].[VW_Bloomberg_Cash_Ladder]
-- 
-- Params:			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
-- D.Bacchus:		22/06/2017			JIRA: DAP-1032
--
-- 
-------------------------------------------------------------------------------------- 



select * from 
dbo.T_CASH_LADDER_STAGE_STORE
