CREATE VIEW "CADIS"."DG_FUNCTION350_RESULTS" AS 
SELECT ET."reportdate",ET."fundcode",ET."ruleid",ET."rulename",ET."rulelimit",ET."value",ET."asatdate" FROM "Access.WebDev"."ufn_RegulatoryLimits"(NULL) ET
