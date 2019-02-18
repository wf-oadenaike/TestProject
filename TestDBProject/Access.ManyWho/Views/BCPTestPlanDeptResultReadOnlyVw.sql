CREATE VIEW [Access.ManyWho].[BCPTestPlanDeptResultReadOnlyVw]
	AS 
	WITH PassResults as (
						SELECT  tpr1.[DepartmentId] 
							,  tpe1.[CalendarYear]
							,  COUNT(*)  as ResultCount   
						FROM  [BAU].[BCPTestPlanRegister] tpr1
						INNER JOIN  [BAU].[BCPTestPlanEvents] tpe1
						ON tpr1.BCPTestPlanRegisterId = tpe1.BCPTestPlanRegisterId
						WHERE tpe1.TestPlanResult like 'Pass%' AND (tpe1.TestPlanStatus IS NULL OR tpe1.TestPlanStatus NOT IN ('inactive','Comments'))
						GROUP BY tpr1.[DepartmentId], tpe1.[CalendarYear]
						),
		PartialResults as (
						SELECT  tpr1.[DepartmentId] 
							,  tpe1.[CalendarYear]
							,  COUNT(*)  as ResultCount   
						FROM  [BAU].[BCPTestPlanRegister] tpr1
						INNER JOIN [BAU].[BCPTestPlanEvents] tpe1
						ON tpr1.BCPTestPlanRegisterId = tpe1.BCPTestPlanRegisterId
						WHERE tpe1.TestPlanResult like 'Partial%' AND (tpe1.TestPlanStatus IS NULL OR tpe1.TestPlanStatus NOT IN ('inactive','Comments'))
						GROUP BY tpr1.[DepartmentId], tpe1.[CalendarYear]
						),
		FailResults as (
						SELECT  tpr1.[DepartmentId] 
							,  tpe1.[CalendarYear]
							,  COUNT(*)  as ResultCount   
						FROM  [BAU].[BCPTestPlanRegister] tpr1
						INNER JOIN [BAU].[BCPTestPlanEvents] tpe1
						ON tpr1.BCPTestPlanRegisterId = tpe1.BCPTestPlanRegisterId
						WHERE tpe1.TestPlanResult like 'Fail%' AND (tpe1.TestPlanStatus IS NULL OR tpe1.TestPlanStatus NOT IN ('inactive','Comments'))
						GROUP BY tpr1.[DepartmentId], tpe1.[CalendarYear]
						),
		NoResults as (
						SELECT  tpr1.[DepartmentId] 
							,  tpe1.[CalendarYear]
							,  COUNT(*)  as ResultCount   
						FROM  [BAU].[BCPTestPlanRegister] tpr1
						INNER JOIN [BAU].[BCPTestPlanEvents] tpe1
						ON tpr1.BCPTestPlanRegisterId = tpe1.BCPTestPlanRegisterId
						WHERE tpe1.TestPlanResult IS NULL AND (tpe1.TestPlanStatus IS NULL OR tpe1.TestPlanStatus NOT IN ('inactive','Comments'))
						GROUP BY tpr1.[DepartmentId], tpe1.[CalendarYear]
					),
		ReTestResults as (
						SELECT  tpr1.[DepartmentId] 
							,  tpe1.[CalendarYear]
							,  COUNT(*)  as ResultCount   
						FROM  [BAU].[BCPTestPlanRegister] tpr1
						INNER JOIN [BAU].[BCPTestPlanEvents] tpe1
						ON tpr1.BCPTestPlanRegisterId = tpe1.BCPTestPlanRegisterId
						WHERE tpe1.IsReTest = 1
						GROUP BY tpr1.[DepartmentId], tpe1.[CalendarYear]
					)					
	SELECT    dcy.DepartmentId
			, d.DepartmentName
			, dcy.CalendarYear
			, ISNULL(pr.ResultCount,0) as PassCount
			, ISNULL(fr.ResultCount,0) as FailCount
			, ISNULL(par.ResultCount,0) as PartialCount
			, ISNULL(nr.ResultCount,0) as NotTakenCount
			, ISNULL(rr.ResultCount,0) as ReTestCount
	FROM  (SELECT DISTINCT tpr.[DepartmentId], tpe.[CalendarYear]
			FROM [BAU].[BCPTestPlanRegister] tpr
			INNER JOIN [BAU].[BCPTestPlanEvents] tpe
			ON tpr.BCPTestPlanRegisterId = tpe.BCPTestPlanRegisterId) dcy
	INNER JOIN [Core].[Departments] d
	ON dcy.[DepartmentId] = d.[DepartmentId]
	LEFT OUTER JOIN PassResults pr
	ON dcy.DepartmentId = pr.DepartmentId
	AND dcy.CalendarYear = pr.CalendarYear
	LEFT OUTER JOIN FailResults fr
	ON dcy.DepartmentId = fr.DepartmentId
	AND dcy.CalendarYear = fr.CalendarYear
	LEFT OUTER JOIN PartialResults par
	ON dcy.DepartmentId = par.DepartmentId
	AND dcy.CalendarYear = par.CalendarYear
	LEFT OUTER JOIN NoResults nr
	ON dcy.DepartmentId = nr.DepartmentId
	AND dcy.CalendarYear = nr.CalendarYear
	LEFT OUTER JOIN ReTestResults rr
	ON dcy.DepartmentId = rr.DepartmentId
	AND dcy.CalendarYear = rr.CalendarYear
;
