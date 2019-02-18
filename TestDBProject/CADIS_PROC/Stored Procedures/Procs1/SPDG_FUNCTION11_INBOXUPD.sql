CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION11_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @EBIRegisterId INT, @EBIEventTypeId SMALLINT, @EBIEventCreationDatetime DATETIME, @EventDetails NVARCHAR (MAX), @EventDetails_UPDATE BIT, @EventDate DATETIME, @EventDate_UPDATE BIT, @EventTrueFalse BIT, @EventTrueFalse_UPDATE BIT, @RecordedByPersonId SMALLINT, @RecordedByPersonId_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @WorkflowVersionGUID UNIQUEIDENTIFIER, @WorkflowVersionGUID_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @EBIEventLastModifiedDatetime DATETIME, @EBIEventLastModifiedDatetime_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


