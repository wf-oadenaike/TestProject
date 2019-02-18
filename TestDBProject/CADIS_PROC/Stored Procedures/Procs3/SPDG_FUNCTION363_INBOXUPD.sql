CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION363_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @SecurityRevaluationId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @SecurityBloombergId VARCHAR (30), @SecurityBloombergId_UPDATE BIT, @EventType VARCHAR (128), @EventType_UPDATE BIT, @EventOverview VARCHAR (2000), @EventOverview_UPDATE BIT, @EventDate DATETIME, @EventDate_UPDATE BIT, @FurtherFundingAmount DECIMAL (18, 6), @FurtherFundingAmount_UPDATE BIT, @Notes NVARCHAR (MAX), @Notes_UPDATE BIT, @PresentedToPricingCommittee BIT, @PresentedToPricingCommittee_UPDATE BIT, @RevaluationPreviousPrice DECIMAL (18, 6), @RevaluationPreviousPrice_UPDATE BIT, @RevaluationPrice DECIMAL (18, 6), @RevaluationPrice_UPDATE BIT, @RevaluationEndDate DATETIME, @RevaluationEndDate_UPDATE BIT, @IsActive BIT, @IsActive_UPDATE BIT, @Status VARCHAR (25), @Status_UPDATE BIT, @CurrencyCode CHAR (3), @CurrencyCode_UPDATE BIT, @IsComplete BIT, @IsComplete_UPDATE BIT, @JiraIssueKey VARCHAR (128), @JiraIssueKey_UPDATE BIT, @SubmittedByPersonId SMALLINT, @SubmittedByPersonId_UPDATE BIT, @DocumentationFolderLink VARCHAR (2000), @DocumentationFolderLink_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @SecurityRevaluationLastModifiedDate DATETIME, @SecurityRevaluationLastModifiedDate_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


