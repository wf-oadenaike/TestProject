﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION104_INBOXUPD]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @UnquotedCompanyId INT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @UnquotedCompanyName NVARCHAR (256), @UnquotedCompanyName_UPDATE BIT, @UnquotedCompanySalesforceId VARCHAR (18), @UnquotedCompanySalesforceId_UPDATE BIT, @PrimaryContactSalesforceId VARCHAR (18), @PrimaryContactSalesforceId_UPDATE BIT, @InvestmentAnalystPersonId SMALLINT, @InvestmentAnalystPersonId_UPDATE BIT, @InvestmentManagerOwnerPersonId SMALLINT, @InvestmentManagerOwnerPersonId_UPDATE BIT, @InvestmentManagerOwnerRoleId SMALLINT, @InvestmentManagerOwnerRoleId_UPDATE BIT, @CurrentUnquotedCompanyStage VARCHAR (5), @CurrentUnquotedCompanyStage_UPDATE BIT, @InitialMeetingDate DATETIME, @InitialMeetingDate_UPDATE BIT, @Attendees VARCHAR (MAX), @Attendees_UPDATE BIT, @NextReviewDate DATETIME, @NextReviewDate_UPDATE BIT, @CompanyOverview VARCHAR (MAX), @CompanyOverview_UPDATE BIT, @NotesForSalesTeam VARCHAR (MAX), @NotesForSalesTeam_UPDATE BIT, @CurrentPrice DECIMAL (19, 2), @CurrentPrice_UPDATE BIT, @CurrencyCode CHAR (3), @CurrencyCode_UPDATE BIT, @UnquotedCompanyRootFolderURL VARCHAR (2000), @UnquotedCompanyRootFolderURL_UPDATE BIT, @InitialInformationFolderURL VARCHAR (2000), @InitialInformationFolderURL_UPDATE BIT, @InitialDueDiligenceFolderURL VARCHAR (2000), @InitialDueDiligenceFolderURL_UPDATE BIT, @FinalInvestmentFolderURL VARCHAR (2000), @FinalInvestmentFolderURL_UPDATE BIT, @InitialInvestmentRulesAssessment BIT, @InitialInvestmentRulesAssessment_UPDATE BIT, @JiraEpicKey VARCHAR (32), @JiraEpicKey_UPDATE BIT, @JiraIssueKey VARCHAR (32), @JiraIssueKey_UPDATE BIT, @IsFCARegulated BIT, @IsFCARegulated_UPDATE BIT, @IsSRARegulated BIT, @IsSRARegulated_UPDATE BIT, @WorkflowVersionGUID UNIQUEIDENTIFIER, @WorkflowVersionGUID_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @UnquotedCompaniesLastModifiedDate DATETIME, @UnquotedCompaniesLastModifiedDate_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


