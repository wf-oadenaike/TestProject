﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION30_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @RiskRegisterId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @SubCategoryId SMALLINT, @SubCategoryId_UPDATE BIT, @IdentifiedByPersonId SMALLINT, @IdentifiedByPersonId_UPDATE BIT, @RiskEvent NVARCHAR (MAX), @RiskEvent_UPDATE BIT, @RiskCause NVARCHAR (MAX), @RiskCause_UPDATE BIT, @MitigationAndControls NVARCHAR (MAX), @MitigationAndControls_UPDATE BIT, @GrossImpactId SMALLINT, @GrossImpactId_UPDATE BIT, @GrossProbabilityId SMALLINT, @GrossProbabilityId_UPDATE BIT, @NetImpactId SMALLINT, @NetImpactId_UPDATE BIT, @NetProbabilityId SMALLINT, @NetProbabilityId_UPDATE BIT, @ImpactOnICAAPYesNo BIT, @ImpactOnICAAPYesNo_UPDATE BIT, @MonetaryImpact DECIMAL (19, 2), @MonetaryImpact_UPDATE BIT, @Liklihoodfactor DECIMAL (5, 2), @Liklihoodfactor_UPDATE BIT, @FrequencyRating INT, @FrequencyRating_UPDATE BIT, @FinLossWorstCaseRating INT, @FinLossWorstCaseRating_UPDATE BIT, @FinLossBaseCaseRating INT, @FinLossBaseCaseRating_UPDATE BIT, @ActionRequired VARCHAR (MAX), @ActionRequired_UPDATE BIT, @ActionRoleId SMALLINT, @ActionRoleId_UPDATE BIT, @ActionPersonId SMALLINT, @ActionPersonId_UPDATE BIT, @ActionDeadlineDate DATETIME, @ActionDeadlineDate_UPDATE BIT, @ICAAPComments VARCHAR (MAX), @ICAAPComments_UPDATE BIT, @RiskReviewed BIT, @RiskReviewed_UPDATE BIT, @RiskStatus VARCHAR (128), @RiskStatus_UPDATE BIT, @ReviewStatus VARCHAR (128), @ReviewStatus_UPDATE BIT, @RiskOccurrenceDate DATETIME, @RiskOccurrenceDate_UPDATE BIT, @SalesForceThirdPartyServiceIssueID VARCHAR (25), @SalesForceThirdPartyServiceIssueID_UPDATE BIT, @HORJiraKey VARCHAR (128), @HORJiraKey_UPDATE BIT, @ROJiraKey VARCHAR (128), @ROJiraKey_UPDATE BIT, @RiskRegisterCreationDate DATETIME, @RiskRegisterCreationDate_UPDATE BIT, @WorkflowVersionGUID UNIQUEIDENTIFIER, @WorkflowVersionGUID_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


