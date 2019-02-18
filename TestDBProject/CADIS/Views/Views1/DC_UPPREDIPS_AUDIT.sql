﻿CREATE VIEW "CADIS"."DC_UPPREDIPS_AUDIT" AS
SELECT
A.CADIS_SYSTEM_FIELDNAME
,A."ASSET"
,A."ORDER_REF"
,A."VALUATION_POINT"
,A."ESTIMATED?"
,CAST(A."CADIS_SYSTEM_NEWVAL" AS NVARCHAR(MAX)) AS NewValue
,H.RUNSTART AS AuditTime
,H.LAUNCHEDBY AS AuditName
,CASE
 WHEN A."CADIS_SYSTEM_RULEID" = -1 THEN 'Default Field' 
 WHEN A."CADIS_SYSTEM_RULEID" IS NULL AND A."CADIS_SYSTEM_NEWVAL" IS NOT NULL THEN 'Default Value' 
 WHEN A."CADIS_SYSTEM_RULEID" IS NULL AND A."CADIS_SYSTEM_NEWVAL" IS NULL THEN 'Null Value' 
 ELSE R.DESCRIPTION END AS RuleDescription
,A.CADIS_SYSTEM_RUNID
,H.TOPLEVELRUNID AS CADIS_SYSTEM_TOPRUNID
FROM "CADIS_PROC"."DC_UPPREDIPS_AUDIT" A
INNER JOIN
CADIS_SYS.DC_RUNINFO H ON
A."CADIS_SYSTEM_RUNID" = H.RUNID
LEFT OUTER JOIN
CADIS_SYS.DC_RULE R ON
A."CADIS_SYSTEM_RULEID" = R.RULEID
