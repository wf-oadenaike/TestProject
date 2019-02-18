
CREATE VIEW [Access.ManyWho].[TrainingRegisterVw]
	AS
	SELECT   tr.TrainingRegisterId
	       , tr.TraineePersonId
	       , tr.ProposedDate
	       , tr.ExpiryDate
	       , tr.TrainingCourseId
	       , tr.TrainingStatusId
	       , tr.ApprovalDate	
	       , tr.ManagerPersonId
	       , tr.TrainerPersonId	
	       , tr.Notes	
	       , tr.ManagerComments
	       , tr.TrainerComments
		   , tr.TrainingProvider
		   , tr.EstimatedCost
		   , tr.OptAttendanceApproverPersonId
		   , tr.WorkFlowLink
	       , tr.DocumentationFolderLink
	       , tr.JoinGUID	
	       , tr.TrainingCreationDate
	       , tr.TrainingLastModifiedDate
	FROM [Compliance].[TrainingRegister] tr
		;
