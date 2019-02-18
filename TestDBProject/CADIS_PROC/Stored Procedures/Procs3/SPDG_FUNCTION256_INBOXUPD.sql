CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION256_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @SignatoryReviewEventId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @EventId INT, @EventId_UPDATE BIT, @SignatoryRoleId SMALLINT, @SignatoryRoleId_UPDATE BIT, @SignatoryPersonId SMALLINT, @SignatoryPersonId_UPDATE BIT, @EventDetails VARCHAR (MAX), @EventDetails_UPDATE BIT, @EventDate DATETIME, @EventDate_UPDATE BIT, @EventStatus VARCHAR (25), @EventStatus_UPDATE BIT, @EventTrueFalse BIT, @EventTrueFalse_UPDATE BIT, @JiraTaskKey VARCHAR (128), @JiraTaskKey_UPDATE BIT, @SubmittedByPersonId SMALLINT, @SubmittedByPersonId_UPDATE BIT, @LastModifiedByPersonId SMALLINT, @LastModifiedByPersonId_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @SignatoryReviewEventLastModifiedDatetime DATETIME, @SignatoryReviewEventLastModifiedDatetime_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


