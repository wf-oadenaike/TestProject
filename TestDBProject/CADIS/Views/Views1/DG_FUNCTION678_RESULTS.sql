﻿CREATE VIEW "CADIS"."DG_FUNCTION678_RESULTS" AS 
SELECT ET."PEPID",ET."ChecklistID",ET."ChecklistName",ET."FullName",ET."PoliticalPosition",ET."RiskRating",ET."IsActive",ET."PersonDetails",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.ManyWho"."Compliance_KYCPEPReadOnlyVw" ET WITH (NOLOCK)
