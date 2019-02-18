
CREATE VIEW [Reporting].[vw_REF_TouchType]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[vw_REF_TouchType]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu : 12/10/2017 JIRA: DAP-2201 [Create View Over Investment Objects]
--
-- 
-------------------------------------------------------------------------------------- 

SELECT

  ID,
  TouchTypeName,
  TouchType
FROM dbo.T_REF_TOUCH_TYPE

