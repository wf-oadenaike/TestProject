CREATE FUNCTION [Compliance].[GetMonitoringThemeRecords_uf] ()
RETURNS @MonitoringThemeRecords TABLE 
(
    MonitoringThemeId INT NOT NULL,
	RecordId INT NOT NULL,
    CreationDate DATETIME NULL,
	Text NVARCHAR(max) NULL
)
AS     
BEGIN

    INSERT INTO @MonitoringThemeRecords
	(MonitoringThemeId, RecordId, CreationDate, Text)
	SELECT 1 as MonitoringThemeId
         , crp.ConflictId as RecordId
		 , crp.RecognitionDate as CreationDate
		 , p.PersonsName as Text
	FROM [Compliance].[ConflictsRegisterPotential] crp 
    INNER JOIN [Core].[Persons] p
	ON crp.NotifyingPersonId = p.PersonId
	WHERE crp.RecognitionDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION 
	SELECT 2 as MonitoringThemeId
         , crp.ConflictId as RecordId
		 , crp.RecognitionDate as CreationDate		 
		 , crc.ConflictsRegisterCategory as Text
	FROM [Compliance].[ConflictsRegisterPotential] crp 
	INNER JOIN [Compliance].[ConflictsRegisterIdentification] cri
	ON crp.ConflictId = cri.ConflictId
	INNER JOIN [Compliance].[ConflictsRegisterCategories] crc
	ON cri.ConflictsRegisterCategoryId1 = crc.ConflictsRegisterCategoryId
	WHERE crp.RecognitionDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
    UNION
	SELECT 3 as MonitoringThemeId
         , crp.ConflictId as RecordId
		 , crp.RecognitionDate as CreationDate
		 , CASE WHEN closed.ActionDate IS NOT NULL THEN 'Closed' ELSE 'Open' END as Text
	FROM [Compliance].[ConflictsRegisterPotential] crp 
    LEFT OUTER JOIN [Compliance].[ConflictsRegisterActions] closed 
	ON closed.ConflictId = crp.ConflictId 
	AND closed.ActionTypeId = 3
	WHERE crp.RecognitionDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()	
    UNION
	SELECT 4 as MonitoringThemeId
         , crp.ConflictId as RecordId
		 , LatestReview.LatestActionDate as CreationDate
		 , p.PersonsName as Text
	FROM [Compliance].[ConflictsRegisterPotential] crp 
    INNER JOIN [Core].[Persons] p
	ON crp.NotifyingPersonId = p.PersonId
	INNER JOIN (SELECT ConflictId, MAX(ActionDate) as LatestActionDate
	            FROM [Compliance].[ConflictsRegisterActions]
				WHERE ActionTypeId = 1
				GROUP BY ConflictId) LatestReview 
	ON LatestReview.ConflictId = crp.ConflictId
	WHERE NOT EXISTS (SELECT 1
	                  FROM  [Compliance].[ConflictsRegisterActions] closed
					  WHERE closed.ConflictId = crp.ConflictId 
					  AND closed.ActionTypeId = 3)
	AND LatestReview.LatestActionDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION
	SELECT 5 as MonitoringThemeId 
		 , gee.ExpenseId as RecordId
         , gee.ExpenseIncurredDate as CreationDate
	     , CASE WHEN gee.AccountName IS NULL THEN p.PersonsName ELSE gee.AccountName + ' - ' + p.PersonsName END
	FROM [Compliance].[GiftEntertainmentExpenses] gee
	INNER JOIN [Core].[Persons] p
	ON gee.[RelatesToPersonId] = p.PersonId
	WHERE gee.[GivenOrReceived]='Received'
	AND gee.[GiftOrEntertainment] in ('Gift','Entertainment')
	AND gee.[ExpenseApproved]=0
	AND gee.[CurrencyCode] = 'GBP'
	AND gee.[ExpenseAmount] >= 100
	AND gee.[ExpenseIncurredDate] BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION
	SELECT 6 as MonitoringThemeId 
		 , gee.ExpenseId as RecordId
         , gee.ExpenseIncurredDate as CreationDate
	     , CASE WHEN gee.AccountName IS NULL THEN p.PersonsName ELSE gee.AccountName + ' - ' + p.PersonsName END
	FROM [Compliance].[GiftEntertainmentExpenses] gee
	INNER JOIN [Core].[Persons] p
	ON gee.[RelatesToPersonId] = p.PersonId
	WHERE gee.[GivenOrReceived]='Received'
	AND gee.[GiftOrEntertainment] ='Entertainment'
	AND gee.[CurrencyCode] = 'GBP'
	AND gee.[ExpenseAmount] >= 100
	AND gee.[ExpenseIncurredDate] BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	AND (SELECT COUNT(*) 
	       FROM [Compliance].[GiftEntertainmentExpenses] gee1
		   WHERE gee1.AccountName = gee.AccountName
		   AND gee1.[GivenOrReceived]='Received'
	       AND gee1.[GiftOrEntertainment] ='Entertainment'
	       AND gee1.[CurrencyCode] = 'GBP'
	       AND gee1.[ExpenseAmount] >= 100
		   AND gee1.[ExpenseIncurredDate] BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()) >= 3
    UNION
	SELECT 7 as MonitoringThemeId 
		 , gee.ExpenseId as RecordId
         , gee.ExpenseIncurredDate as CreationDate
	     , CASE WHEN gee.AccountName IS NULL THEN p.PersonsName ELSE gee.AccountName + ' - ' + p.PersonsName END
	FROM [Compliance].[GiftEntertainmentExpenses] gee
	INNER JOIN [Core].[Persons] p
	ON gee.[RelatesToPersonId] = p.PersonId
	WHERE gee.[GivenOrReceived]='Given'
	AND gee.[GiftOrEntertainment] ='Entertainment'
	AND gee.[CurrencyCode] = 'GBP'
	AND gee.[ExpenseAmount] >= 100
	AND gee.[ExpenseIncurredDate] BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	AND (SELECT COUNT(*) 
	       FROM [Compliance].[GiftEntertainmentExpenses] gee1
		   WHERE gee1.AccountName = gee.AccountName
		   AND gee1.[GivenOrReceived]='Given'
	       AND gee1.[GiftOrEntertainment] ='Entertainment'
	       AND gee1.[CurrencyCode] = 'GBP'
	       AND gee1.[ExpenseAmount] >= 100
		   AND gee1.[ExpenseIncurredDate] BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()) >= 3	
    UNION
    SELECT 8 as MonitoringThemeId 
		 , gee.ExpenseId as RecordId
         , gee.ExpenseIncurredDate as CreationDate
	     , CASE WHEN gee.AccountName IS NULL THEN p.PersonsName ELSE gee.AccountName + ' - ' + p.PersonsName END
	FROM [Compliance].[GiftEntertainmentExpenses] gee
	INNER JOIN [Core].[Persons] p
	ON gee.[RelatesToPersonId] = p.PersonId
	WHERE gee.[GivenOrReceived]='Given'
	AND gee.[GiftOrEntertainment] ='Gift'
	AND gee.[CurrencyCode] = 'GBP'
	AND gee.[ExpenseAmount] >= 100
	AND gee.[ExpenseIncurredDate] BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
    UNION
	SELECT 9 as MonitoringThemeId 
		 , gee.ExpenseId as RecordId
         , gee.ExpenseIncurredDate as CreationDate
	     , CASE WHEN gee.AccountName IS NULL THEN p.PersonsName ELSE gee.AccountName + ' - ' + p.PersonsName END
	FROM [Compliance].[GiftEntertainmentExpenses] gee
	INNER JOIN [Core].[Persons] p
	ON gee.[RelatesToPersonId] = p.PersonId
	WHERE gee.[GivenOrReceived]='Received'
	AND gee.[GiftOrEntertainment] ='Gift'
	AND gee.[CurrencyCode] = 'GBP'
	AND gee.[ExpenseAmount] >= 100
	AND gee.[ExpenseIncurredDate] BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()	
    UNION
	SELECT 10 as MonitoringThemeId 
		 , gee.ExpenseId as RecordId
         , gee.ExpenseIncurredDate as CreationDate
	     , CASE WHEN gee.AccountName IS NULL THEN p.PersonsName ELSE gee.AccountName + ' - ' + p.PersonsName END
	FROM [Compliance].[GiftEntertainmentExpenses] gee
	INNER JOIN [Core].[Persons] p
	ON gee.[RelatesToPersonId] = p.PersonId
	WHERE gee.[GivenOrReceived]='Received'
	AND gee.[GiftOrEntertainment] ='Gift'
	AND gee.[CurrencyCode] = 'GBP'
	AND gee.[ExpenseIncurredDate] BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	AND (SELECT SUM(gee1.[ExpenseAmount])
	     FROM [Compliance].[GiftEntertainmentExpenses] gee1
		 WHERE gee1.[RelatesToPersonId] = gee.[RelatesToPersonId]
		 AND gee1.[GivenOrReceived]='Received'
		 AND gee1.[GiftOrEntertainment] ='Gift'
	     AND gee1.[CurrencyCode] = 'GBP'
		 AND gee1.[ExpenseIncurredDate] BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()) >= 200
	UNION
    SELECT 11 as MonitoringThemeId
         , er.EBIRegisterId as RecordId
		 , er.EBIRegisterCreationDatetime as CreationDate
		 , er.EBISummary as Text
	FROM [Compliance].[EBIRegister]  er
	WHERE er.DateIdentified BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()	 
	UNION 		 
    SELECT 12 as MonitoringThemeId
         , er.EBIRegisterId as RecordId
		 , er.EBIRegisterCreationDatetime as CreationDate
		 , er.EBISummary as Text
	FROM [Compliance].[EBIRegister]  er
	INNER JOIN [Compliance].[EBICategorisations] ec
	ON ec.EBICategorisationId = er.EBICategorisationId
	WHERE er.DateIdentified BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	AND ec.[EBICategorisationName] in ('Critical','High')
	UNION 		 
    SELECT 13 as MonitoringThemeId
         , er.EBIRegisterId as RecordId
		 , er.EBIRegisterCreationDatetime as CreationDate
		 , er.EBISummary as Text
	FROM [Compliance].[EBIRegister]  er
	WHERE er.DateIdentified BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	AND er.ReimbursementRequiredYesNo = 1	
	UNION 		 
    SELECT 14 as MonitoringThemeId
         , er.EBIRegisterId as RecordId
		 , er.EBIRegisterCreationDatetime as CreationDate
		 , er.EBISummary as Text
	FROM [Compliance].[EBIRegister]  er
	WHERE er.DateIdentified BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	AND er.EBIClosureDate IS NOT NULL
    AND (MitigationSteps IS NULL OR IncidentReportFinalizationDate IS NULL OR ExternalNotificationRequiredYesNo IS NULL 
	     OR NotifiedDepartmentHeadId IS NULL OR ReimbursementRequiredYesNo IS NULL OR SentBackYesNo IS NULL OR DisputedPendingLitigationYesNo IS NULL
		 OR InvestmentRelatedYesNo IS NULL)	
	UNION 		 
    SELECT 95 as MonitoringThemeId
         , er.EBIRegisterId as RecordId
		 , er.EBIRegisterCreationDatetime as CreationDate
		 , er.EBISummary as Text
	FROM [Compliance].[EBIRegister]  er
	WHERE er.DateIdentified BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	AND ISNULL([EBIResolvedYesNo],0) = 0
	UNION 		 
    SELECT 96 as MonitoringThemeId
         , er.EBIRegisterId as RecordId
		 , er.EBIRegisterCreationDatetime as CreationDate
		 , er.EBISummary as Text
	FROM [Compliance].[EBIRegister]  er
	WHERE er.DateIdentified BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	AND (ABS(DATEDIFF(day,er.EBIRegisterCreationDatetime,er.DateIdentified)) >1
	OR ABS(DATEDIFF(day,er.DateIdentified,er.EBIClosureDate)) >1)		 
	UNION 		 
    SELECT 15 as MonitoringThemeId
         , cr.ComplaintRegisterId as RecordId
		 , cr.ComplaintDate as CreationDate
		 , cr.ComplainantClientName as Text
	FROM [Compliance].[ComplaintsRegister]  cr
	WHERE cr.ComplaintDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION 		 
    SELECT 16 as MonitoringThemeId
         , cr.ComplaintRegisterId as RecordId
		 , cr.ComplaintDate as CreationDate
		 , cr.ComplainantClientName + ' - ' + cc.Category as Text
	FROM [Compliance].[ComplaintsRegister]  cr
	INNER JOIN [Compliance].[ComplaintCategories] cc
	ON cr.ComplaintCategoryId = cc.CategoryId
	WHERE cr.ComplaintDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION 		 
    SELECT 17 as MonitoringThemeId
         , cr.ComplaintRegisterId as RecordId
		 , cr.ComplaintDate as CreationDate
		 , cr.ComplainantClientName + ' - ' + crc.RootCause as Text
	FROM [Compliance].[ComplaintsRegister]  cr
	INNER JOIN [Compliance].[ComplaintRootCauses] crc
	ON cr.ComplaintRootCauseId = crc.RootCauseId
	WHERE cr.ComplaintDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION 		 
    SELECT 18 as MonitoringThemeId
         , cr.ComplaintRegisterId as RecordId
		 , cr.ComplaintDate as CreationDate
		 , cr.ComplainantClientName as Text
	FROM [Compliance].[ComplaintsRegister]  cr
	WHERE cr.ComplaintDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()	
	AND (PartyComplaintAgainst IS NULL OR ReportedBy IS NULL OR FundsAffected IS NULL OR ComplaintDate IS NULL
	     OR ReportedToWIMDate IS NULL OR RemedialAction IS NULL OR ComplaintCategoryId IS NULL OR ComplaintRootCauseId IS NULL
		 OR RootCauseDetails IS NULL OR (ExternalPartyFwdTo IS NOT NULL AND ThirdPartyId IS NULL))
	UNION 		 
    SELECT 19 as MonitoringThemeId
         , cr.ComplaintRegisterId as RecordId
		 , cr.ComplaintDate as CreationDate
		 , cr.ComplainantClientName as Text
	FROM [Compliance].[ComplaintsRegister]  cr
	LEFT OUTER JOIN (SELECT cre.ComplaintRegisterId 
	                      , MAX(cre.EventDate) as EventDate
	                 FROM [Compliance].[ComplaintsRegisterEvents] cre
					 INNER JOIN [Compliance].[ComplaintEventTypes] cet
					 ON cre.ComplaintEventTypeId = cet.ComplaintEventTypeId
					 WHERE cet.ComplaintEventType IN ('Final Response','Summary Response')
					 GROUP BY cre.ComplaintRegisterId) cres
	ON cr.ComplaintRegisterId = cres.ComplaintRegisterId
	WHERE cr.ComplaintDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	AND ABS(DATEDIFF(day,cr.ComplaintDate,cres.EventDate)) > 3
	UNION 		 
    SELECT 20 as MonitoringThemeId
         , cr.ComplaintRegisterId as RecordId
		 , cr.ComplaintDate as CreationDate
		 , cr.ComplainantClientName as Text
	FROM [Compliance].[ComplaintsRegister]  cr
	WHERE cr.ComplaintDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()	
	AND (CompOrRestitutionSummary IS NOT NULL )	
	UNION 		 
    SELECT 21 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Anti-Financial Crime' as Text
	FROM [Access.ManyWho].[PersonsActiveVw] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
							  WHERE tr.TrainingTitle = 'Anti-Financial Crime')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'Anti-Financial Crime'
						   AND tr.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'Anti-Financial Crime'
						   AND tr.TrainingStatus != 'Completed'
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
	FROM [Access.ManyWho].[PersonsActiveVw] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
							  WHERE tr.TrainingTitle = 'Code of Ethics & Conduct')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'Code of Ethics & Conduct'
						   AND tr.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'Code of Ethics & Conduct'
						   AND tr.TrainingStatus != 'Completed'
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
	FROM [Access.ManyWho].[PersonsActiveVw] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
							  WHERE tr.TrainingTitle = 'Compliance Manual')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'Compliance Manual'
						   AND tr.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'Compliance Manual'
						   AND tr.TrainingStatus != 'Completed'
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
	FROM [Access.ManyWho].[PersonsActiveVw] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
							  WHERE tr.TrainingTitle = 'Gifts & Entertainment')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'Gifts & Entertainment'
						   AND tr.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'Gifts & Entertainment'
						   AND tr.TrainingStatus != 'Completed'
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
	FROM [Access.ManyWho].[PersonsActiveVw] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
							  WHERE tr.TrainingTitle = 'PA Dealing')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'PA Dealing'
						   AND tr.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'PA Dealing'
						   AND tr.TrainingStatus != 'Completed'
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
		 , tr.TraineeName + ' - ' + tr.TrainingTitle as Text
	FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
	INNER JOIN [Access.ManyWho].[PersonsActiveVw] pa
	ON tr.TraineePersonId = pa.PersonId
	WHERE tr.TrainingTitle = 'Financial Promotions'
	AND tr.TrainingType = 'Regulatory'
	--AND tr.TrainingStatus != 'Completed'
	AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
	                       FROM [Compliance].[TrainingRegister] tr1
						   WHERE tr.TraineePersonId = tr1.TraineePersonId
						   AND tr.TrainingCourseId = tr1.TrainingCourseId)
	AND ABS(DATEDIFF(month,tr.ProposedDate, GetDate())) > 12	
	UNION
    SELECT 23 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Compliance Induction' as Text
	FROM [Access.ManyWho].[PersonsActiveVw] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
							  WHERE tr.TrainingTitle = 'Compliance Induction')
		OR pa.PersonId IN (SELECT TraineePersonId 
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'Compliance Induction'
						   AND ABS(DATEDIFF(d,rpr.JoinDate,tr.ProposedDate)) > 30 )
			)
	AND rpr.JoinDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION
    SELECT 25 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Compliance Induction' as Text
	FROM [Access.ManyWho].[PersonsActiveVw] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	INNER JOIN [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
	ON tr.TraineePersonId = pa.PersonId
	WHERE tr.TrainingTitle = 'Compliance Induction'
	AND tr.TrainingStatus != 'Completed'
	AND ABS(DATEDIFF(d,rpr.JoinDate,tr.ProposedDate)) > 30
	AND rpr.JoinDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION
    SELECT 26 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'Organisational Risk Management' as Text
	FROM [Access.ManyWho].[PersonsActiveVw] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
							  WHERE tr.TrainingTitle = 'Organisational Risk Management')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'Organisational Risk Management'
						   AND tr.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))	
	UNION
    SELECT 26 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , rpr.JoinDate as CreationDate
		 , pa.PersonsName + ' - ' + 'IT Acceptable Use & Information Security' as Text
	FROM [Access.ManyWho].[PersonsActiveVw] pa
	INNER JOIN (SELECT PersonId
	                ,  MIN(ActiveFromDatetime) as JoinDate
			    FROM [Core].[RolePersonRelationship]
				GROUP BY PersonId) rpr
	ON pa.PersonId = rpr.PersonId
	WHERE (pa.PersonId NOT IN (SELECT TraineePersonId 
	                          FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
							  WHERE tr.TrainingTitle = 'IT Acceptable Use & Information Security')
		OR pa.PersonId IN (SELECT TraineePersonId
	                       FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
						   WHERE tr.TrainingTitle = 'IT Acceptable Use & Information Security'
						   AND tr.TrainingStatus != 'Completed'
						   AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
												  FROM [Compliance].[TrainingRegister] tr1
												  WHERE tr.TraineePersonId = tr1.TraineePersonId
												  AND tr.TrainingCourseId = tr1.TrainingCourseId)
						   AND ABS(DATEDIFF(m,tr.ProposedDate, GetDate()))>12))
	UNION -- Annual Declarations 
    SELECT 27 as MonitoringThemeId
         , pa.PersonId as RecordId
		 , tr.ProposedDate as CreationDate
		 , pa.PersonsName + ' - ' + tr.TrainingTitle as Text
	FROM [Access.ManyWho].[TrainingRegisterReadOnlyVw]  tr
	INNER JOIN [Access.ManyWho].[PersonsActiveVw] pa
	ON tr.TraineePersonId = pa.PersonId
	WHERE tr.TrainingTitle = 'APER Declaration'
	AND tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
	                       FROM [Compliance].[TrainingRegister] tr1
						   WHERE tr.TraineePersonId = tr1.TraineePersonId
						   AND tr.TrainingCourseId = tr1.TrainingCourseId)
	AND ABS(DATEDIFF(month,tr.ProposedDate, GetDate())) > 12
	UNION
    SELECT 52 as MonitoringThemeId
         , pdrr.PADealingRequestRegisterId as RecordId
		 , pdrr.RequestedDate as CreationDate
		 , pa.PersonsName + ' - ' + pdrr.InvestmentName as Text
	FROM [Compliance].[PADealingRequestRegister] pdrr
	INNER JOIN [Access.ManyWho].[PersonsActiveVw] pa
	ON pdrr.RequestorPersonId = pa.PersonId
	AND pdrr.RequestedDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()	
	UNION
    SELECT 53 as MonitoringThemeId
         , pdrr.PADealingRequestRegisterId as RecordId
		 , pdrr.RequestedDate as CreationDate
		 , pa.PersonsName + ' - ' + pdrr.InvestmentName as Text
	FROM [Compliance].[PADealingRequestRegister] pdrr
	INNER JOIN [Access.ManyWho].[PersonsActiveVw] pa
	ON pdrr.RequestorPersonId = pa.PersonId
	AND ABS(DATEDIFF(d,pdrr.RequestedDate,pdrr.ComplianceDecisionDate)) > 1
	AND pdrr.RequestedDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION
    SELECT 34 as MonitoringThemeId
         , slr.StopListId as RecordId
		 , slr.CleansedDate as CreationDate
		 , ISNULL(pa.PersonsName+ ' - ','') + slr.StoppedCompanyName as Text
	FROM [Compliance].[StopListRegister] slr
	LEFT OUTER JOIN [Core].[Persons] pa
	ON slr.CleanseRequestorPersonId = pa.PersonId
	WHERE slr.[IsCleansed]=1
	AND pa.[ActiveFlag] = 1
    AND NOT EXISTS (SELECT 1
					FROM [Compliance].[StopListEvents] sle
					INNER JOIN [Compliance].[StopListEventTypes] slet
					ON sle.[StopListEventTypeId] = slet.[StopListEventTypeId]
					WHERE sle.StopListId = slr.StopListId
					AND slet.[StopListEventType]='Cleanse Reason')
	AND slr.CleansedDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()	
	UNION
    SELECT 35 as MonitoringThemeId
         , slr.StopListId as RecordId
		 , slr.StoppedDate as CreationDate
		 , ISNULL(pa.PersonsName+ ' - ','') + slr.StoppedCompanyName as Text
	FROM [Compliance].[StopListRegister] slr
	LEFT OUTER JOIN [Core].[Persons] pa
	ON slr.SubmittedByPersonId = pa.PersonId
	WHERE (ISNULL(slr.[IsStopped],0) = 1
	OR ISNULL(slr.[IsCleansed],0) = 1)
	AND pa.[ActiveFlag] = 1
	AND EXISTS ( SELECT 1
	             FROM [dbo].[T_MASTER_BBAIM_TRADE] mbbt
				 WHERE mbbt.UniqueBloombergID = slr.BloombergId
				 AND mbbt.[TransactionType] not like 'C%' -- not cancelled
				 AND CAST(mbbt.TradeDate as DateTime) BETWEEN DATEADD(HOUR,1,slr.StoppedDate) AND ISNULL(slr.CleansedDate, GetDate()) )
	AND slr.StoppedDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION
    SELECT 36 as MonitoringThemeId
         , slr.StopListId as RecordId
		 , slr.StoppedDate as CreationDate
		 , ISNULL(pa.PersonsName+ ' - ','') + slr.StoppedCompanyName as Text
	FROM [Compliance].[StopListRegister] slr
	LEFT OUTER JOIN [Core].[Persons] pa
	ON slr.SubmittedByPersonId = pa.PersonId
	WHERE (ISNULL(slr.[IsStopped],0) = 1
	OR ISNULL(slr.[IsCleansed],0) = 1)
	AND pa.[ActiveFlag] = 1
	AND EXISTS ( SELECT 1
	             FROM [dbo].[T_MASTER_BBAIM_TRADE] mbbt
				 WHERE mbbt.UniqueBloombergID = slr.BloombergId
				 AND mbbt.[TransactionType] not like 'C%' -- not cancelled
				 AND CAST(mbbt.TradeDate as DateTime) BETWEEN DATEADD(d,-1,slr.StoppedDate) AND slr.StoppedDate )
	AND slr.StoppedDate BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()
	UNION
    SELECT 100 as MonitoringThemeId
         , [VIOLATION_VIOLID] as RecordId
		 , [VIOLATION_VIOLDATETIME] as CreationDate
		 , [VIOLATION_VIOLSEVERITY] as Text
	FROM [dbo].[T_MASTER_COMPLIANCE_VIOL]
    WHERE [VIOLATION_VIOLSTATUS]='Pending'
	AND VIOLATION_VIOLDATETIME BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()	
	UNION
    SELECT 101 as MonitoringThemeId
         , cv.[VIOLATION_VIOLID] as RecordId
		 , cv.[VIOLATION_VIOLDATETIME] as CreationDate
		 , ISNULL(cvnd.[NOTEDETAILS_DATETIME]+ ' - ','')  +  ISNULL(cvnd.[NOTEDETAILS_USER]+ ' - ','') + 'hours difference= ' + CAST(ABS(datediff(hour,cv.[VIOLATION_VIOLDATETIME],cvnd.[NOTEDETAILS_DATETIME])) as varchar) as Text
	FROM [dbo].[T_MASTER_COMPLIANCE_VIOL] cv
	INNER JOIN [dbo].[T_MASTER_COMPLIANCE_VIOL_NOTE_DETAIL] cvnd
	ON cv.[CADIS_RUN_ID] = cvnd.[CADIS_RUN_ID]
	AND cv.[CADIS_ROW_ID] = cvnd.[CADIS_PARENT_ID]	
	WHERE cv.VIOLATION_TYPE='Trade'
	AND ABS(datediff(hour,cv.[VIOLATION_VIOLDATETIME],cvnd.[NOTEDETAILS_DATETIME]))>1
	AND cvnd.[NOTEDETAILS_NOTE] IS NOT NULL
	AND cv.VIOLATION_VIOLDATETIME BETWEEN DATEADD(month, DATEDIFF(month, 0, dateadd(year,-1,getdate())), 0) AND GetDate()	

	;


	RETURN
END
;
