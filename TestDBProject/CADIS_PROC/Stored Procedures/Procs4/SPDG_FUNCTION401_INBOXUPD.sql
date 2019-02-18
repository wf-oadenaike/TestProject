CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION401_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @ComplaintsRegisterEventId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @ComplaintRegisterId INT, @ComplaintRegisterId_UPDATE BIT, @ComplaintEventTypeId SMALLINT, @ComplaintEventTypeId_UPDATE BIT, @RecordedByPersonId SMALLINT, @RecordedByPersonId_UPDATE BIT, @EventDetails VARCHAR (MAX), @EventDetails_UPDATE BIT, @EventDate DATETIME, @EventDate_UPDATE BIT, @EventTrueFalse BIT, @EventTrueFalse_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @ComplaintEventCreationDate DATETIME, @ComplaintEventCreationDate_UPDATE BIT, @ComplaintEventLastModifiedDate DATETIME, @ComplaintEventLastModifiedDate_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


