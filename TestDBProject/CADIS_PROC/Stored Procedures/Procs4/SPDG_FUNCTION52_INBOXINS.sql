CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION52_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @MeetingNameBK NVARCHAR (128), @MeetingTypeId SMALLINT, @MeetingTypeId_UPDATE BIT, @MeetingSummary VARCHAR (2048), @MeetingSummary_UPDATE BIT, @MeetingOwnerRoleId SMALLINT, @MeetingOwnerRoleId_UPDATE BIT, @AssigneeRoleId SMALLINT, @AssigneeRoleId_UPDATE BIT, @JIRAProjectKey VARCHAR (128), @JIRAProjectKey_UPDATE BIT, @LagDays SMALLINT, @LagDays_UPDATE BIT, @ActiveFlag BIT, @ActiveFlag_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @WorkflowVersionGUID UNIQUEIDENTIFIER, @WorkflowVersionGUID_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @MeetingDay VARCHAR (20), @MeetingDay_UPDATE BIT, @MeetingRegisterLastModifiedDatetime DATETIME, @MeetingRegisterLastModifiedDatetime_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


