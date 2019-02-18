CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION224_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @CADIS_SYSTEM_INSERTED DATETIME, @CADIS_SYSTEM_INSERTED_UPDATE BIT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @TraineePersonId SMALLINT, @TraineePersonId_UPDATE BIT, @ProposedDate DATE, @ProposedDate_UPDATE BIT, @ExpiryDate DATE, @ExpiryDate_UPDATE BIT, @TrainingCourseId INT, @TrainingCourseId_UPDATE BIT, @TrainingStatusId SMALLINT, @TrainingStatusId_UPDATE BIT, @ApprovalDate DATE, @ApprovalDate_UPDATE BIT, @ManagerPersonId SMALLINT, @ManagerPersonId_UPDATE BIT, @TrainerPersonId SMALLINT, @TrainerPersonId_UPDATE BIT, @Notes VARCHAR (MAX), @Notes_UPDATE BIT, @ManagerComments VARCHAR (MAX), @ManagerComments_UPDATE BIT, @TrainerComments VARCHAR (MAX), @TrainerComments_UPDATE BIT, @EstimatedCost DECIMAL (19, 2), @EstimatedCost_UPDATE BIT, @TrainingProvider VARCHAR (128), @TrainingProvider_UPDATE BIT, @OptAttendanceApproverPersonId SMALLINT, @OptAttendanceApproverPersonId_UPDATE BIT, @WorkFlowLink VARCHAR (2000), @WorkFlowLink_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @TrainingLastModifiedDate DATETIME, @TrainingLastModifiedDate_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


