CREATE VIEW [Access.WebDev].[DataGeneratorInboxVw]
AS
SELECT 
	   cadis.[COMPONENTID]
      ,cadis.[IDENTIFIER]
      ,cadis.[GUID]
      ,cadis.[NAME]
      ,cadis.[CODE]
      ,cadis.[OBSOLETE]
      ,cadis.[INSERTED]
      ,cadis.[UPDATED]
      ,cadis.[CHANGEDBY]
      ,cadis.[DEFINITION]
      ,cadis.[CRC]
      ,cadis.[Info1]
      ,cadis.[Info2]
      ,cadis.[ENABLED]
      ,cadis.[TIMECODE]
      ,cadis.[COMPONENT_NAME]
  FROM [Core].[WebDevViewBaseTableMapping] wd
  INNER JOIN [CADIS_SYS].[VW_ALL_PROCESSES] cadis ON wd.DataGeneratorName = cadis.Name AND cadis.COMPONENT_NAME = 'DataGeneratorInbox'
  WHERE cadis.[OBSOLETE]=0
