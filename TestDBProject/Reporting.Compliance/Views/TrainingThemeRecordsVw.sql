CREATE VIEW [Reporting.Compliance].[TrainingThemeRecordsVw]
AS

    SELECT 21 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Anti-Financial Crime' as Text
	FROM [Core].[Persons] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Compliance].[TrainingRegister]   tr
	                          INNER JOIN [Compliance].[TrainingCourses] tc
	                          ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
							  WHERE tc.TrainingTitle = 'Anti-Financial Crime')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister]   tr
	                       INNER JOIN [Compliance].[TrainingCourses] tc
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]		
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]
						   WHERE tc.TrainingTitle = 'Anti-Financial Crime'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister] tr
						   INNER JOIN [Compliance].[TrainingCourses] tc 
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]		
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]						   
						   WHERE tc.TrainingTitle = 'Anti-Financial Crime'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(d,rpr.JoinDate,tr.ProposedDate)) > 30
	                       AND rpr.JoinDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate())	
	UNION
    SELECT 21 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Code of Ethics & Conduct' as Text
	FROM [Core].[Persons] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Compliance].[TrainingRegister]   tr
	                          INNER JOIN [Compliance].[TrainingCourses] tc
	                          ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
							  WHERE tc.TrainingTitle = 'Code of Ethics & Conduct')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister]   tr
	                       INNER JOIN [Compliance].[TrainingCourses] tc
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]		
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]
						   WHERE tc.TrainingTitle = 'Code of Ethics & Conduct'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister] tr
						   INNER JOIN [Compliance].[TrainingCourses] tc 
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]		
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]						   
						   WHERE tc.TrainingTitle = 'Code of Ethics & Conduct'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(d,rpr.JoinDate,tr.ProposedDate)) > 30
	                       AND rpr.JoinDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate())	
	UNION
    SELECT 21 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Compliance Manual' as Text
	FROM [Core].[Persons] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Compliance].[TrainingRegister]   tr
	                          INNER JOIN [Compliance].[TrainingCourses] tc
	                          ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
							  WHERE tc.TrainingTitle = 'Compliance Manual')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister]   tr
	                       INNER JOIN [Compliance].[TrainingCourses] tc
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]		
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]
						   WHERE tc.TrainingTitle = 'Anti-Financial Crime'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister] tr
						   INNER JOIN [Compliance].[TrainingCourses] tc 
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]		
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]						   
						   WHERE tc.TrainingTitle = 'Compliance Manual'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(d,rpr.JoinDate,tr.ProposedDate)) > 30
	                       AND rpr.JoinDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate())	
	UNION
    SELECT 21 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Gifts & Entertainment' as Text
	FROM [Core].[Persons] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Compliance].[TrainingRegister]   tr
	                          INNER JOIN [Compliance].[TrainingCourses] tc
	                          ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
							  WHERE tc.TrainingTitle = 'Gifts & Entertainment')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister]   tr
	                       INNER JOIN [Compliance].[TrainingCourses] tc
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]		
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]
						   WHERE tc.TrainingTitle = 'Gifts & Entertainment'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister] tr
						   INNER JOIN [Compliance].[TrainingCourses] tc 
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]		
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]						   
						   WHERE tc.TrainingTitle = 'Gifts & Entertainment'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(d,rpr.JoinDate,tr.ProposedDate)) > 30
	                       AND rpr.JoinDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate())	
	UNION
    SELECT 21 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'PA Dealing' as Text
	FROM [Core].[Persons] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Compliance].[TrainingRegister]   tr
	                          INNER JOIN [Compliance].[TrainingCourses] tc
	                          ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
							  WHERE tc.TrainingTitle = 'PA Dealing')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister]   tr
	                       INNER JOIN [Compliance].[TrainingCourses] tc
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]		
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]
						   WHERE tc.TrainingTitle = 'PA Dealing'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister] tr
						   INNER JOIN [Compliance].[TrainingCourses] tc 
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]		
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]						   
						   WHERE tc.TrainingTitle = 'PA Dealing'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(d,rpr.JoinDate,tr.ProposedDate)) > 30
	                       AND rpr.JoinDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate())	
	
	UNION
	SELECT 22 as MonitoringThemeId
         , tr.TraineePersonId as RecordId
		 , tr.ProposedDate as CreationDate
		 , pa.PersonsName + ' - ' + tc.TrainingTitle as Text
	FROM [Compliance].[TrainingRegister]  tr
	INNER JOIN [Core].[Persons] pa
	ON tr.TraineePersonId = pa.PersonId
	INNER JOIN [Compliance].[TrainingCourses] tc
	ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
	WHERE tc.TrainingTitle = 'Financial Promotions'
	AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
	                       FROM [Compliance].[TrainingRegister] tr1
						   WHERE tr.TraineePersonId = tr1.TraineePersonId
						   AND tr.TrainingCourseId = tr1.TrainingCourseId)
	AND pa.[ActiveFlag]=1
	AND DATEDIFF(month,tr.ProposedDate, GetDate()) > 12	
	UNION
    SELECT 23 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Compliance Induction' as Text
	FROM [Core].[Persons] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Compliance].[TrainingRegister]  tr
							  INNER JOIN [Compliance].[TrainingCourses] tc
	                          ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
							  WHERE tc.TrainingTitle = 'Compliance Induction')
		OR pa.PersonId IN (SELECT TraineePersonId 
	                       FROM [Compliance].[TrainingRegister]  tr
						   INNER JOIN [Compliance].[TrainingCourses] tc
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
						   WHERE tc.TrainingTitle = 'Compliance Induction'
						   AND DATEDIFF(d,rpr.JoinDate,tr.ProposedDate) > 30 )
			)
	AND pa.[ActiveFlag]=1
	AND rpr.JoinDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION
    SELECT 25 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Compliance Induction' as Text
	FROM [Core].[Persons] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	INNER JOIN [Compliance].[TrainingRegister]  tr
	ON tr.TraineePersonId = pa.PersonId
	INNER JOIN [Compliance].[TrainingCourses] tc
	ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
	INNER JOIN [Compliance].[TrainingStatuses] ts
	ON ts.[TrainingStatusId] = tr.[TrainingStatusId]
	WHERE tc.TrainingTitle = 'Compliance Induction'
	AND ts.TrainingStatus != 'Completed'
	AND DATEDIFF(d,rpr.JoinDate,tr.ProposedDate) > 30
	AND pa.[ActiveFlag]=1
	AND rpr.JoinDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION
    SELECT 26 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Organisational Risk Management' as Text
	FROM [Core].[Persons] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Compliance].[TrainingRegister]  tr
						      INNER JOIN [Compliance].[TrainingCourses] tc
	                          ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
							  WHERE tc.TrainingTitle = 'Organisational Risk Management')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister]  tr
						   INNER JOIN [Compliance].[TrainingCourses] tc
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]
						   WHERE tc.TrainingTitle = 'Organisational Risk Management'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND DATEDIFF(m,tr.ProposedDate, GetDate())>12))	
			AND pa.[ActiveFlag]=1
	UNION
    SELECT 26 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'IT Acceptable Use & Information Security' as Text
	FROM [Core].[Persons] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Compliance].[TrainingRegister]  tr
							  INNER JOIN [Compliance].[TrainingCourses] tc
	                          ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
							  WHERE tc.TrainingTitle = 'IT Acceptable Use & Information Security')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Compliance].[TrainingRegister]  tr
						   INNER JOIN [Compliance].[TrainingCourses] tc
	                       ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
						   INNER JOIN [Compliance].[TrainingStatuses] ts
						   ON ts.[TrainingStatusId] = tr.[TrainingStatusId]
						   WHERE tc.TrainingTitle = 'IT Acceptable Use & Information Security'
						   AND ts.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND DATEDIFF(m,tr.ProposedDate, GetDate())>12))
		AND pa.[ActiveFlag]=1
	UNION -- Annual Declarations 
    SELECT 27 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , tr.ProposedDate as CreationDate
		 , pa.PersonsName + ' - ' + tc.TrainingTitle as Text
	FROM [Compliance].[TrainingRegister]  tr
	INNER JOIN [Compliance].[TrainingCourses] tc
	ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
	INNER JOIN [Core].[Persons] pa
	ON tr.TraineePersonId = pa.PersonId
	WHERE tc.TrainingTitle = 'APER Declaration'
	AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
	                       FROM [Compliance].[TrainingRegister] tr1
						   WHERE tr.TraineePersonId = tr1.TraineePersonId
						   AND tr.TrainingCourseId = tr1.TrainingCourseId)
	AND pa.[ActiveFlag]=1
	AND DATEDIFF(month,tr.ProposedDate, GetDate()) > 12

	;
