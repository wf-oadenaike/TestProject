
CREATE VIEW [Access.ManyWho].[TrainingCoursesReadOnlyVw]
	AS
	SELECT   tc.TrainingCourseId
	       , tc.TrainingTitle
	       , tc.TrainingTypeId
		   , tt.TrainingType
           , tc.AttestationRequiredYesNo
           , tc.AnnualTrainingYesNo
		   , tc.AttendanceApproverPersonId
		   , ap.PersonsName as AttendanceApprover
		   , tc.AttestationText
		   , tc.IsActive
		   , tc.JoinGUID
	       , tc.TrainingCourseCreationDate
	       , tc.TrainingCourseLastModifiedDate
	FROM [Compliance].[TrainingCourses] tc
	INNER JOIN [Compliance].[TrainingTypes] tt
	ON tc.TrainingTypeId = tt.TrainingTypeId
	LEFT OUTER JOIN [Core].[Persons] ap
	ON tc.AttendanceApproverPersonId = ap.PersonId
		;
