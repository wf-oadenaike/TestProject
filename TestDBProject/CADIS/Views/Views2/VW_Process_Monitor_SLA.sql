﻿CREATE VIEW "CADIS"."VW_Process_Monitor_SLA"
AS
SELECT 
  SRC.SOURCE
, SRC.ENTITY
, SRC.[DESCRIPTION]
, SRC.DIRECTION
, CONVERT(DATE,DATEADD (hh,1,PH.RUNSTART)) AS DATE
, CONVERT(DATETIME,CONVERT(DATE,DC.SLA_DATE)) +  cast(convert(time, DC.EXPECTED_DELIVERY_TIME) as datetime)  AS EXPECTED_DELIVERY_TIME

, DATEADD (hh,1,PH.RUNSTART) AS ACTUAL_DELIVERY

, convert(BIT,CASE WHEN (CONVERT(DATETIME,CONVERT(DATE,DC.SLA_DATE)) +  cast(convert(time, DC.EXPECTED_DELIVERY_TIME) as datetime)) > 
DATEADD (hh,1,PH.RUNSTART) then 1 ELSE 0 END) as DELIVERY_SLA_MET


, Cast(convert(date, DC.SLA_DATE)as datetime) +
 cast(convert(time, DC.EXPECTED_SLA_COMPLETION) as datetime) AS EXPECTED_SLA_COMPLETION

, DATEADD (hh,1,PH.RUNEND) AS ACTUAL_SLA_COMPLETION


, CONVERT(BIT,CASE WHEN DATEADD (hh,1,PH.RUNEND) >= Cast(convert(date, DC.SLA_DATE)as datetime) +
 cast(convert(time, DC.EXPECTED_SLA_COMPLETION) as datetime) THEN 0 ELSE 1 END) AS PROCESSING_SLA_MET

 
, cast(convert(time, PH.RUNTIME) as time) AS PROCESSING_TIME

, SRC.DATA_CHANNEL_ID
, DC.SLA_DATE AS CURRENT_SLA_DATE
, SRC.MARKIT_SOLUTION
, SRC.MORNING_CHECK
FROM T_REF_SOURCE_SLA SRC
JOIN T_DS_DATA_CHANNEL DC ON SRC.DATA_CHANNEL_ID = DC.DataChannelID
LEFT JOIN T_PROCESS_MONITOR PM ON SRC.SOURCE = PM.SOURCE AND SRC.ENTITY = PM.ENTITY AND SRC.[DESCRIPTION] = PM.[DESCRIPTION]
JOIN CADIS.vwProcessHistory PH ON PH.RUNID = PM.TOP_LEVEL_RUNID
WHERE DC.IS_ACTIVE = 1
AND PM.RUN_DATE BETWEEN CONVERT(DATETIME,CONVERT(DATE,DATEADD(DAY, -1, GETDATE()))) +  CAST(CONVERT(TIME, '22:00:00.000') AS DATETIME) AND GETDATE()
AND GETDATE() > = Cast(convert(date, GETDATE())as datetime) + cast(convert(time, '06:30:00.0000000') as datetime)
and DATEPART(DW,GETDATE()) BETWEEN 2 AND 6

UNION

-- WHERE THE VALUES DOES NOT EXIST I.E. THE JOB HAS NOT RUN YET
SELECT * FROM
(
SELECT 
  SRC.SOURCE
, SRC.ENTITY
, SRC.[DESCRIPTION]
, SRC.DIRECTION
, CONVERT(DATE,DATEADD (hh,1,PH.RUNSTART)) AS DATE
, CONVERT(DATETIME,CONVERT(DATE,DC.SLA_DATE)) +  cast(convert(time, DC.EXPECTED_DELIVERY_TIME) as datetime)  AS EXPECTED_DELIVERY_TIME

, DATEADD (hh,1,PH.RUNSTART) AS ACTUAL_DELIVERY

, convert(BIT,CASE WHEN (CONVERT(DATETIME,CONVERT(DATE,DC.SLA_DATE)) +  cast(convert(time, DC.EXPECTED_DELIVERY_TIME) as datetime)) > 
DATEADD (hh,1,PH.RUNSTART) then 1 ELSE 0 END) as DELIVERY_SLA_MET


, Cast(convert(date, DC.SLA_DATE)as datetime) +
 cast(convert(time, DC.EXPECTED_SLA_COMPLETION) as datetime) AS EXPECTED_SLA_COMPLETION

, DATEADD (hh,1,PH.RUNEND) AS ACTUAL_SLA_COMPLETION



, CONVERT(BIT,CASE WHEN DATEADD (hh,1,ISNULL(PH.RUNEND,'9999-01-01 06:00:00.000')) >= Cast(convert(date, DC.SLA_DATE)as datetime) +
 cast(convert(time, DC.EXPECTED_SLA_COMPLETION) as datetime) THEN 0 ELSE 1 END) AS PROCESSING_SLA_MET

 
, cast(convert(time, PH.RUNTIME) as time) AS PROCESSING_TIME

, SRC.DATA_CHANNEL_ID
, DC.SLA_DATE AS CURRENT_SLA_DATE
, SRC.MARKIT_SOLUTION
, SRC.MORNING_CHECK

FROM T_REF_SOURCE_SLA SRC
JOIN T_DS_DATA_CHANNEL DC ON SRC.DATA_CHANNEL_ID = DC.DataChannelID
LEFT JOIN
(
SELECT *
FROM T_PROCESS_MONITOR PM 
JOIN CADIS.vwProcessHistory PH ON PH.RUNID = PM.TOP_LEVEL_RUNID
WHERE PM.RUN_DATE BETWEEN CONVERT(DATETIME,CONVERT(DATE,DATEADD(DAY, CASE DATEPART(DW,GETDATE()) WHEN 2 THEN -3 ELSE -1 END, GETDATE()))) +  CAST(CONVERT(TIME, '22:00:00.000') AS DATETIME) AND GETDATE() -- CASE STATEMENT SETS THE DATEADD - DAY TO FRIDAY IF THE CURRENT DAY IS MONDAY
) PH
ON SRC.DESCRIPTION = PH.DESCRIPTION
WHERE DC.IS_ACTIVE = 1
AND PH.SOURCE IS NULL
AND GETDATE() > = Cast(convert(date, GETDATE())as datetime) + cast(convert(time, '06:30:00.0000000') as datetime)
and DATEPART(DW,GETDATE()) BETWEEN 2 AND 6
) d
WHERE EXPECTED_SLA_COMPLETION < GETDATE() -- THE SLA TIME HAS NOT BEEN BREACHED YET BECCUASE THE PROCESS HAS RUN BEFORE THE TIME IN THE SLA
