CREATE VIEW "CADIS"."DG_FUNCTION530_RESULTS" AS 
SELECT ET."TestCategory",ET."TestName",ET."IsPassed",ET."SqlFunction",ET."Todo",ET."AsAt" FROM "dbo"."UFN_MORNING_CHECKS"() ET
