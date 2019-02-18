﻿CREATE VIEW "CADIS"."DG_FUNCTION673_RESULTS" AS 
SELECT ET."PEPID",ET."ChecklistID",ET."FullName",ET."PersonDetails",ET."SubmittedByPersonID",ET."JoinGUID",ET."PoliticalPositionID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."IsActive" FROM "dbo"."Compliance_KYCPEP" ET WITH (NOLOCK)
