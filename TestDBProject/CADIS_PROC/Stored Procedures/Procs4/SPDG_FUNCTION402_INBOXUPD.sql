﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION402_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @ComplaintRegisterId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @ComplainantClientName VARCHAR (128), @ComplainantClientName_UPDATE BIT, @PartyComplaintAgainst VARCHAR (2048), @PartyComplaintAgainst_UPDATE BIT, @ReferenceNumbers VARCHAR (2048), @ReferenceNumbers_UPDATE BIT, @ComplaintStatus VARCHAR (25), @ComplaintStatus_UPDATE BIT, @RecordedByPersonId SMALLINT, @RecordedByPersonId_UPDATE BIT, @ReportedBy VARCHAR (2048), @ReportedBy_UPDATE BIT, @ReportedByCompany VARCHAR (2048), @ReportedByCompany_UPDATE BIT, @ComplaintCategoryId SMALLINT, @ComplaintCategoryId_UPDATE BIT, @FundsAffected VARCHAR (2048), @FundsAffected_UPDATE BIT, @ComplaintDetails VARCHAR (MAX), @ComplaintDetails_UPDATE BIT, @ComplaintDate DATE, @ComplaintDate_UPDATE BIT, @ReportedToWIMDate DATE, @ReportedToWIMDate_UPDATE BIT, @CompOrRestitutionSummary VARCHAR (MAX), @CompOrRestitutionSummary_UPDATE BIT, @ComplaintRootCauseId SMALLINT, @ComplaintRootCauseId_UPDATE BIT, @RootCauseDetails VARCHAR (MAX), @RootCauseDetails_UPDATE BIT, @RemedialAction NVARCHAR (MAX), @RemedialAction_UPDATE BIT, @MitigationSteps NVARCHAR (MAX), @MitigationSteps_UPDATE BIT, @ComplaintClosed BIT, @ComplaintClosed_UPDATE BIT, @ThirdPartyId SMALLINT, @ThirdPartyId_UPDATE BIT, @ExternalPartyFwdTo VARCHAR (128), @ExternalPartyFwdTo_UPDATE BIT, @JIRAIssueKey VARCHAR (255), @JIRAIssueKey_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @SubflowJoinGUID VARCHAR (2000), @SubflowJoinGUID_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @ComplaintCreationDate DATETIME, @ComplaintCreationDate_UPDATE BIT, @ComplaintLastModifiedDate DATETIME, @ComplaintLastModifiedDate_UPDATE BIT, @ThirdPartyComplaintReceived BIT, @ThirdPartyComplaintReceived_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


