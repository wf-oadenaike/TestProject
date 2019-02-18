CREATE VIEW [Reporting.Compliance].[TrainingRegisterVw]
AS
	SELECT tr.TraineePersonId
		 , pa.PersonsName as TraineeName
		 , tc.TrainingTitle
		 , ts.TrainingStatus
		 , tr.ProposedDate
	FROM [Compliance].[TrainingRegister]  tr
	INNER JOIN [Compliance].[TrainingCourses] tc
	ON tc.[TrainingCourseId] = tr.[TrainingCourseId]
	INNER JOIN [Compliance].[TrainingStatuses] ts
	ON ts.[TrainingStatusId] = tr.[TrainingStatusId]
	INNER JOIN [Core].[Persons] pa
	ON tr.TraineePersonId = pa.PersonId
	WHERE tr.ProposedDate = (SELECT MAX(tr1.ProposedDate)
	                         FROM [Compliance].[TrainingRegister] tr1
						     WHERE tr.TraineePersonId = tr1.TraineePersonId
						     AND tr.TrainingCourseId = tr1.TrainingCourseId)
	AND pa.[ActiveFlag]=1

	;
