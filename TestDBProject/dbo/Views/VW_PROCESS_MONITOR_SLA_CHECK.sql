﻿
CREATE VIEW DBO.VW_PROCESS_MONITOR_SLA_CHECK
-------------------------------------------------------------------------------------- 
-- Name: [DBO].[VW_PROCESS_MONITOR_SLA_CHECK]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- R.Dixon: 10/05/2018 JIRA: DAP-2000 Compares process completion times against SLA times for key data feeds.
-- R.Dixon: 17/05/2018 JIRA: DAP-2029 Calculate Expected Completion datetime correctly
-- R.Dixon: 31/05/2018 JIRA: DAP-2063 SLA data feed checks to compare with latest run from process logs for given EDM solution
-- R.Dixon: 18/06/2018 JIRA: DAP-2050 Joins to T_REF_DELIVERY_SCHEDULE to handle different file schedules
-------------------------------------------------------------------------------------- 

AS

SELECT	*
FROM	(
		SELECT	SRC.SOURCE
				, SRC.ENTITY
				, SRC.[DESCRIPTION]
				, SRC.DIRECTION
				, CONVERT(DATE,PH.RUNSTART) AS DATE
				, DC.EXPECTED_DELIVERY_TIME
				, PH.RUNSTART AS ACTUAL_DELIVERY
				, CASE WHEN DC.EXPECTED_DELIVERY_TIME > PH.RUNSTART THEN 1 
						ELSE 0 
						END AS DELIVERY_SLA_MET
				, DC.EXPECTED_SLA_COMPLETION
				, PH.RUNEND AS ACTUAL_SLA_COMPLETION
				, CASE WHEN ISNULL(PH.RUNEND,'9999-01-01 23:59:00.000') >= DC.EXPECTED_SLA_COMPLETION THEN 0 
						ELSE 1 
						END AS PROCESSING_SLA_MET
				, CAST(CONVERT(TIME, PH.RUNTIME) AS TIME) AS PROCESSING_TIME
				, SRC.DATA_CHANNEL_ID
				, DC.SLA_DATE AS CURRENT_SLA_DATE
				, SRC.MARKIT_SOLUTION
				, SRC.MORNING_CHECK
		FROM	[dbo].[T_REF_SOURCE_SLA] SRC
		INNER	JOIN [dbo].[T_REF_DELIVERY_SCHEDULE_SLA] REF
		ON		REF.DELIVERY_SCHEDULE_ID = SRC.DELIVERY_SCHEDULE_ID
		INNER	JOIN (
				SELECT	DATACHANNELID,
						SLA_DATE,
						IS_ACTIVE,
						CASE WHEN CONVERT(TIME, EXPECTED_DELIVERY_TIME) >= '08:00:00.000' THEN
								CONVERT(DATETIME,CONVERT(DATE, SLA_DATE)) +  CAST(CONVERT(TIME, EXPECTED_DELIVERY_TIME) AS DATETIME)  
							WHEN CONVERT(TIME, EXPECTED_DELIVERY_TIME) < '08:00:00.000' THEN
								DATEADD(dd,1,CONVERT(DATETIME,CONVERT(DATE, SLA_DATE))) +  CAST(CONVERT(TIME, EXPECTED_DELIVERY_TIME) AS DATETIME)
						END	AS EXPECTED_DELIVERY_TIME
						, CASE WHEN CONVERT(TIME, EXPECTED_SLA_COMPLETION) >= '08:00:00.000' THEN
							 CONVERT(DATETIME,CONVERT(DATE, SLA_DATE)) +  CAST(CONVERT(TIME, EXPECTED_SLA_COMPLETION) AS DATETIME) 
								WHEN CONVERT(TIME, EXPECTED_SLA_COMPLETION) < '08:00:00.000' THEN
								DATEADD(dd,1,CONVERT(DATETIME,CONVERT(DATE, SLA_DATE))) +  CAST(CONVERT(TIME, EXPECTED_SLA_COMPLETION) AS DATETIME)
							END	AS EXPECTED_SLA_COMPLETION
				FROM	[dbo].[T_DS_DATA_CHANNEL] 
				) DC 
		ON		SRC.DATA_CHANNEL_ID = DC.DATACHANNELID
		LEFT	OUTER JOIN
				(
				SELECT	*
				FROM	(
						SELECT	*, ROW_NUMBER() OVER(PARTITION BY [DESCRIPTION] order by RUN_DATE desc) as ROWNUM
						FROM	T_PROCESS_MONITOR PM 
						JOIN	CADIS.VWPROCESSHISTORY PH ON PH.RUNID = PM.TOP_LEVEL_RUNID
						WHERE	PM.RUN_DATE BETWEEN DATEADD(hh,-2, getdate()) AND GETDATE() 
						) x
				WHERE	x.ROWNUM = 1
				) PH
		ON		SRC.DESCRIPTION = PH.DESCRIPTION
		WHERE	DC.IS_ACTIVE = 1
		AND		(
					(DATEPART(DW,DC.SLA_DATE) = 1 AND REF.SUNDAY = 1)
				OR
					(DATEPART(DW,DC.SLA_DATE) = 2 AND REF.MONDAY = 1)
				OR
					(DATEPART(DW,DC.SLA_DATE) = 3 AND REF.TUESDAY = 1)
				OR
					(DATEPART(DW,DC.SLA_DATE) = 4 AND REF.WEDNESDAY = 1)
				OR
					(DATEPART(DW,DC.SLA_DATE) = 5 AND REF.THURSDAY = 1)
				OR
					(DATEPART(DW,DC.SLA_DATE) = 6 AND REF.FRIDAY = 1)
				OR
					(DATEPART(DW,DC.SLA_DATE) = 7 AND REF.SATURDAY = 1)
				)
		AND		REF.ACTIVE = 1
		) D
WHERE	EXPECTED_SLA_COMPLETION < GETDATE() -- We'd have expected file by now
-- Only check for files that were expected in last hour
AND		CAST(D.EXPECTED_DELIVERY_TIME AS TIME)  BETWEEN CAST(DATEADD(hh, -1, GETDATE()) as TIME) AND CAST(GETDATE() as TIME)

