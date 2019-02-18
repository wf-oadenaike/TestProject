CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION15_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @FinPromRegisterId INT, @FinPromEventType VARCHAR (128), @EventDate DATETIME, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @EventPersonId SMALLINT, @EventPersonId_UPDATE BIT, @EventRoleId SMALLINT, @EventRoleId_UPDATE BIT, @EventTrueFalse BIT, @EventTrueFalse_UPDATE BIT, @EventComments VARCHAR (2048), @EventComments_UPDATE BIT, @WorkflowVersionGUID UNIQUEIDENTIFIER, @WorkflowVersionGUID_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @FinPromEventCreationDate DATETIME, @FinPromEventCreationDate_UPDATE BIT, @FinPromEventLastModifiedDate DATETIME, @FinPromEventLastModifiedDate_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


