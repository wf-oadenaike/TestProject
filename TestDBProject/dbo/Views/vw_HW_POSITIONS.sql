
CREATE VIEW  [dbo].[vw_HW_POSITIONS]
AS

-------------------------------------------------------------------------------------- 
-- Name: [Schema].[ViewName]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu: 15/05/2017 JIRA: DAP-2379 [Brief Description]
--
-- 
-------------------------------------------------------------------------------------- 



 SELECT DISTINCT  INSTRUMENT_UII,   CADIS_SYSTEM_INSERTED,CADIS_SYSTEM_UPDATED, CADIS_SYSTEM_CHANGEDBY   from  T_HW_POSITIONS_STAGE 

