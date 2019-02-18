CREATE VIEW "CADIS"."DM_PARTY_SEARCH" AS 
SELECT convert(tinyint,1) as "DM__Status",
	S.LONGNAME as "DM__Source",
	CASE RS.SOURCEID
		WHEN 5 THEN 'BROKER: '+CONVERT(VARCHAR(8000),SYSS5."BROKER")
		WHEN 6 THEN 'MASTER_BROKER_NUMBER: '+CONVERT(VARCHAR(8000),SYSS6."MASTER_BROKER_NUMBER")
	END as "DM__Source Key",
	RS.CADISID as "Proposed Cadis Id",
	CASE
		WHEN RS.SOURCEID = 5 AND SYSS5.CADISID IS NOT NULL THEN SYSS5.CADISID
		WHEN RS.SOURCEID = 6 AND SYSS6.CADISID IS NOT NULL THEN SYSS6.CADISID
		ELSE RS.CADISID
	END as "Assigned Cadis Id",
	CONVERT(TINYINT,RS.PRIORITY) as "DM__Priority",
	RL.RULEID as "Rule Id",
	RL.DESCRIPTION as "Rule Description",
	RL.CONFIDENCELEVEL as "Rule Confidence",
CASE WHEN (RS.COMMENT IS NULL AND RL.RULETYPE = 'DefaultInsert' AND RS.CHANGEDBY='DataMatcherIdGenerator') THEN 'Created by Id Generator'
	WHEN (RS.COMMENT IS NULL AND RL.RULETYPE = 'DefaultInsert') THEN 'Default Insertion'
	WHEN (RS.COMMENT IS NULL AND RL.RULETYPE <> 'DefaultInsert' AND RL.CONFIDENCELEVEL < S.AUTOCONFIDENCELEVEL) THEN 'Low Confidence Match'
	WHEN (RS.COMMENT IS NULL AND RL.RULETYPE <> 'DefaultInsert' AND RL.CONFIDENCELEVEL >= S.AUTOCONFIDENCELEVEL) THEN 'High Confidence Match'
	WHEN (RS.COMMENT LIKE 'Remarked match as provisional as subsequent rule processing has failed%') THEN 'Subsequent Processing No Match'
	WHEN (RS.COMMENT LIKE 'Remarked match as provisional as original match rule subsequently%') THEN 'Subsequent Processing Different Match'
	WHEN (RS.COMMENT LIKE 'Default insertion required because rule%') THEN 'Default Insertion Required To Prevent Duplicates'
	WHEN (RS.COMMENT LIKE 'Automatic rule result set as provisional because duplicate%') THEN 'High Confidence but Duplicate Match Marked Provisional'
	WHEN (RS.COMMENT LIKE 'Match assigned provisionally as the rule returned multiple matches%' AND RL.CONFIDENCELEVEL >= S.AUTOCONFIDENCELEVEL) THEN 'High Confidence Match to Multiple Ids'
	WHEN (RS.COMMENT LIKE 'Match assigned provisionally as the rule returned multiple matches%' AND RL.CONFIDENCELEVEL < S.AUTOCONFIDENCELEVEL) THEN 'Low Confidence Match to Multiple Ids'
	ELSE 'Set Provisionally For Manual Verification'
	END as "Reason",	RS.INSERTED as "Matched Date",
	RS.UPDATED as "Match Updated Date",
	RS.CHANGEDBY as "Matched By",
	RS.SOURCEROWID as "Source Row Id"
	, NULL as "CADIS Inserted", NULL as "CADIS Updated"
	, NULL as "CADIS Changed By", NULL as "CADIS Row Id"
	, CASE 
		WHEN (RS.SOURCEID=5 AND SYSS5.CADISID IS NOT NULL) THEN ISNULL(CONVERT(VARCHAR(8000),S5."BROKER"),'')
		WHEN (RS.SOURCEID=6 AND SYSS6.CADISID IS NOT NULL) THEN ISNULL(CONVERT(VARCHAR(8000),S6."MASTER_BROKER_NUMBER"),'')
		ELSE 'Obsolete Row'
	END AS "Broker"
	, RS.SOURCEID as "DM__Source Id"
	FROM "CADIS_PROC"."DM_MP1_RESULT" RS
	INNER JOIN CADIS_SYS.DM_RULE RL ON RL.RULEID = RS.RULEID
	INNER JOIN CADIS_SYS.DM_SOURCE S ON S.SOURCEID = RS.SOURCEID
	LEFT OUTER JOIN "CADIS_PROC"."DM_MP1_SOURCE5" SYSS5 ON RS.SOURCEID = 5 AND RS.SOURCEROWID = SYSS5."CADISROWID"
	LEFT OUTER JOIN "dbo"."T_BBG_BROKER" S5 ON SYSS5."BROKER" = S5."BROKER"
	LEFT OUTER JOIN "CADIS_PROC"."DM_MP1_SOURCE6" SYSS6 ON RS.SOURCEID = 6 AND RS.SOURCEROWID = SYSS6."CADISROWID"
	LEFT OUTER JOIN "dbo"."T_BBG_MASTER_BROKER" S6 ON SYSS6."MASTER_BROKER_NUMBER" = S6."MASTER_BROKER_NUMBER"
	WHERE S.OBSOLETE = 0
	AND (
		(RS.SOURCEID = 5 AND S5."BROKER" IS NOT NULL)
		OR
		(RS.SOURCEID = 6 AND S6."MASTER_BROKER_NUMBER" IS NOT NULL)
	)
