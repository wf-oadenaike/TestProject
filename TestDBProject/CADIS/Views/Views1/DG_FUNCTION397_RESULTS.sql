CREATE VIEW "CADIS"."DG_FUNCTION397_RESULTS" AS 
SELECT ET."DepartmentId",ET."CalendarYear",ET."DepartmentName",ET."PassCount",ET."FailCount",ET."PartialCount",ET."NotTakenCount",ET."ReTestCount" FROM "Access.ManyWho"."BCPTestPlanDeptResultReadOnlyVw" ET WITH (NOLOCK)
