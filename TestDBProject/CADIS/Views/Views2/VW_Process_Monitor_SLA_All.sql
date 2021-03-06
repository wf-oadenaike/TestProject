﻿CREATE VIEW "CADIS"."VW_Process_Monitor_SLA_All"
AS
SELECT [SOURCE]
      ,[ENTITY]
      ,[DESCRIPTION]
      ,[DIRECTION]
      ,[CURRENT_SLA_DATE]
      ,[EXPECTED_DELIVERY_TIME]
      ,[ACTUAL_DELIVERY]
      ,[DELIVERY_SLA_MET]
      ,[EXPECTED_SLA_COMPLETION]
      ,[ACTUAL_SLA_COMPLETION]
      ,[PROCESSING_SLA_MET]
      ,[PROCESSING_TIME]
      ,[DATA_CHANNEL_ID]
FROM [CADIS].[VW_Process_Monitor_SLA_Latest]
  UNION
SELECT [SOURCE]
      ,[ENTITY]
      ,[DESCRIPTION]
      ,[DIRECTION]
      ,[DATE]
      ,[EXPECTED_DELIVERY_TIME]
      ,[ACTUAL_DELIVERY_TIME]
      ,[DELIVERY_SLA_MET]
      ,[EXPECTED_SLA_COMPLETION]
      ,[ACTUAL_SLA_COMPLETION]
      ,[PROCESSING_SLA_MET]
      ,[PROCESSING_TIME]
      ,[DATA_CHANNEL_ID]
FROM [dbo].[T_PROCESS_MONITOR_SLA_STORE]
