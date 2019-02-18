﻿CREATE VIEW "CADIS"."DG_FUNCTION68_RESULTS" AS 
SELECT ET."MandateId",ET."PortfolioCode",ET."MandateName",ET."MandateDescription",ET."IsActive",ET."ClientId",ET."IsWoodfordMandate",ET."IsWeeklyValuationSignOff",ET."IsWeeklyReconciliation",ET."WeeklyValuationSignOffDay",ET."ReconciliationBoxFolderId",ET."JoinGUID",ET."MandateCreationDatetime",ET."MandateLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Investment"."Mandates" ET WITH (NOLOCK)
