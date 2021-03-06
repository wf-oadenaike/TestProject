﻿CREATE VIEW "CADIS"."DM_SECURITY_HUBWISE_INFOALL" AS 
SELECT
    MP.CADISID 		as "CADIS Id", 
    MP.CADISPRIORITY	as "CADIS Priority", 
    SR.*, 
    RESULT.PROVISIONAL	as "Provisional", 
    RULES.CONFIDENCELEVEL	as "Rule Confidence", 
    RESULT.RULEID	as "Rule Id", 
    RULES.DESCRIPTION	as "Rule Description", 
CASE WHEN (RESULT.COMMENT IS NULL AND RULES.RULETYPE = 'DefaultInsert' AND MP.CADISCHANGEDBY='DataMatcherIdGenerator') THEN 'Created by Id Generator'
	WHEN (RESULT.COMMENT IS NULL AND RULES.RULETYPE = 'DefaultInsert') THEN 'Default Insertion'
	WHEN (RESULT.COMMENT IS NULL AND RULES.RULETYPE <> 'DefaultInsert' AND RULES.CONFIDENCELEVEL < SO.AUTOCONFIDENCELEVEL) THEN 'Low Confidence Match'
	WHEN (RESULT.COMMENT IS NULL AND RULES.RULETYPE <> 'DefaultInsert' AND RULES.CONFIDENCELEVEL >= SO.AUTOCONFIDENCELEVEL) THEN 'High Confidence Match'
	WHEN (RESULT.COMMENT LIKE 'Remarked match as provisional as subsequent rule processing has failed%') THEN 'Subsequent Processing No Match'
	WHEN (RESULT.COMMENT LIKE 'Remarked match as provisional as original match rule subsequently%') THEN 'Subsequent Processing Different Match'
	WHEN (RESULT.COMMENT LIKE 'Default insertion required because rule%') THEN 'Default Insertion Required To Prevent Duplicates'
	WHEN (RESULT.COMMENT LIKE 'Automatic rule result set as provisional because duplicate%') THEN 'High Confidence but Duplicate Match Marked Provisional'
	WHEN (RESULT.COMMENT LIKE 'Match assigned provisionally as the rule returned multiple matches%' AND RULES.CONFIDENCELEVEL >= SO.AUTOCONFIDENCELEVEL) THEN 'High Confidence Match to Multiple Ids'
	WHEN (RESULT.COMMENT LIKE 'Match assigned provisionally as the rule returned multiple matches%' AND RULES.CONFIDENCELEVEL < SO.AUTOCONFIDENCELEVEL) THEN 'Low Confidence Match to Multiple Ids'
	ELSE 'Set Provisionally For Manual Verification'
	END AS "Reason",
    RESULT.UPDATED	as "Match Updated Date", 
    MP.CADISINSERTED 	as "CADIS Inserted", 
    MP.CADISUPDATED 	as "CADIS Updated", 
    MP.CADISCHANGEDBY	as "CADIS Changed By", 
    MP.CADISROWID      as "CADIS Row Id", 
    RV.REVISION        as "CADIS Revision" 
    FROM "CADIS_PROC"."DM_MP2_SOURCE243" MP 
        LEFT OUTER JOIN "dbo"."vw_HW_POSITIONS" SR	
           ON MP."INSTRUMENT_UII" = SR."INSTRUMENT_UII"
        LEFT OUTER JOIN ( 
                    SELECT	"INSTRUMENT_UII", max(REVISION) as REVISION
                    FROM "CADIS_PROC"."DM_MP2_SOURCE243_REVISION" 
                    GROUP BY "INSTRUMENT_UII" 
                	) RV
           ON SR."INSTRUMENT_UII" = RV."INSTRUMENT_UII"
        INNER JOIN "CADIS_PROC"."DM_MP2_RESULT" RESULT 
           ON (RESULT.SOURCEID = 243 
           AND RESULT.SOURCEROWID = MP.CADISROWID)
        INNER JOIN CADIS_SYS.DM_RULE RULES 
           ON RESULT.RULEID = RULES.RULEID
        INNER JOIN CADIS_SYS.DM_SOURCE SO 
           ON SO.SOURCEID = 243 
