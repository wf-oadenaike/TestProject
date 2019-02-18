

CREATE VIEW  [Access.ManyWho].[TrainingRegisterReadOnlyVw]

AS

SELECT   tr.TrainingRegisterId
	       , tr.TraineePersonId
		   , tp.PersonsName as TraineeName
	       , tr.ProposedDate
	       , (CASE 
				WHEN tc.AnnualTrainingYesNo = 1 THEN Dateadd(year,1,tr.ProposedDate) 
				ELSE null END)  as ExpiryDate
		   , CAST(Case
				WHEN tr.TrainingRegisterId = (SELECT Top(1) TrainingRegisterId FROM [Compliance].[TrainingRegister]
													 WHERE TrainingStatusId not in (SELECT TrainingStatusId FROM [Compliance].[TrainingStatuses] WHERE TrainingStatus in ('Expired', 'Rejected', 'Requested')) and TrainingCourseId=tr.TrainingCourseId and TraineePersonId=tr.TraineePersonId 
													 ORDER By ProposedDate DESC, TrainingRegisterId DESC) THEN 1
				ELSE 0 END as BIT) as LatestTrainingYesNo
	       , tr.TrainingCourseId
		   , tc.TrainingTitle
		   , tc.TrainingType
		   , tc.AttestationRequiredYesNo
		   , tc.AnnualTrainingYesNo
		   , tc.AttendanceApproverPersonId
		   , tc.AttendanceApprover
		   , tc.IsActive
		   , tr.OptAttendanceApproverPersonId
		   , ap.PersonsName as OptionalAttendanceApprover	
		   , tc.AttestationText
	       , tr.TrainingStatusId
		   , ts.TrainingStatus
	       , tr.ApprovalDate	
	       , tr.ManagerPersonId
		   , mp.PersonsName as ManagerName
	       , tr.TrainerPersonId	
		   , trp.PersonsName as TrainerName
	       , tr.Notes	
	       , tr.ManagerComments
	       , tr.TrainerComments
		   , tr.TrainingProvider
		   , tr.EstimatedCost
		   , tr.WorkFlowLink
	       , tr.DocumentationFolderLink
	       , tr.JoinGUID	
	       , tr.TrainingCreationDate
	       , tr.TrainingLastModifiedDate
	FROM [Compliance].[TrainingRegister] tr
	INNER JOIN [Access.ManyWho].[TrainingCoursesReadOnlyVw] tc
	ON tr.TrainingCourseId = tc.TrainingCourseId
	INNER JOIN [Compliance].[Trainingstatuses] ts
	ON tr.TrainingStatusId = ts.TrainingStatusId
	INNER JOIN [Core].[Persons] tp
	ON tr.TraineePersonId = tp.PersonId
	LEFT OUTER JOIN [Core].[Persons] mp
	ON tr.ManagerPersonId = mp.PersonId
	LEFT OUTER JOIN [Core].[Persons] trp
	ON tr.TrainerPersonId = trp.PersonId
	LEFT OUTER JOIN [Core].[Persons] ap
	ON tr.OptAttendanceApproverPersonId = ap.PersonId
	;
