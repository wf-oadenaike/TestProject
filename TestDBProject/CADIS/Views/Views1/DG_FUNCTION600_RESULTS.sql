﻿CREATE VIEW "CADIS"."DG_FUNCTION600_RESULTS" AS 
SELECT ET."PLATFORM",ET."SOURCE",ET."ENTITY",ET."SUB_ENTITY",ET."DESCRIPTION",ET."DIRECTION",ET."RECORDS",ET."TOLERANCE_PRECENT",ET."SOLUTION",ET."TABLE_NAME",ET."EXPECTED_TIME_GMT",ET."EXPECTED_TIME_TOLERANCE_MINUTES",ET."EMAIL_RECIPIENT",ET."OWNER",ET."SEND_SLACK",ET."SEND_EMAIL",ET."IS_ACTIVE",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "dbo"."T_SLA_PARAM" ET WITH (NOLOCK)