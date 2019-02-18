﻿CREATE PROCEDURE [CADIS_PROC].[SPDG_FUNCTION357_INBOXINS]
@Inserted DATETIME, @ChangedBy NVARCHAR (256), @ValidationInfo NVARCHAR (4000), @CADIS_SYSTEM_INSERTED DATETIME, @CADIS_SYSTEM_INSERTED_UPDATE BIT, @CADIS_SYSTEM_UPDATED DATETIME, @CADIS_SYSTEM_UPDATED_UPDATE BIT, @CADIS_SYSTEM_CHANGEDBY NVARCHAR (50), @CADIS_SYSTEM_CHANGEDBY_UPDATE BIT, @CompanyName NVARCHAR (256), @CompanyName_UPDATE BIT, @CompanySalesforceId VARCHAR (18), @CompanySalesforceId_UPDATE BIT, @PrimaryContactSalesforceId VARCHAR (18), @PrimaryContactSalesforceId_UPDATE BIT, @InvestmentAnalystPersonId SMALLINT, @InvestmentAnalystPersonId_UPDATE BIT, @InvestmentManagerOwnerPersonId SMALLINT, @InvestmentManagerOwnerPersonId_UPDATE BIT, @CurrentUnquotedCompanyStage VARCHAR (5), @CurrentUnquotedCompanyStage_UPDATE BIT, @NextReviewDate DATETIME, @NextReviewDate_UPDATE BIT, @CompanyOverview VARCHAR (MAX), @CompanyOverview_UPDATE BIT, @NotesForSalesTeam VARCHAR (MAX), @NotesForSalesTeam_UPDATE BIT, @CurrentPrice DECIMAL (19, 2), @CurrentPrice_UPDATE BIT, @CurrencyCode CHAR (3), @CurrencyCode_UPDATE BIT, @CompanyRootFolderURL VARCHAR (2000), @CompanyRootFolderURL_UPDATE BIT, @InitialInformationFolderURL VARCHAR (2000), @InitialInformationFolderURL_UPDATE BIT, @InitialInvestmentRulesAssessment BIT, @InitialInvestmentRulesAssessment_UPDATE BIT, @SectorId INT, @SectorId_UPDATE BIT, @SubSectorId INT, @SubSectorId_UPDATE BIT, @CountryISOCode CHAR (2), @CountryISOCode_UPDATE BIT, @WIMEIFCompanyMaturityId INT, @WIMEIFCompanyMaturityId_UPDATE BIT, @WIMPCTCompanyMaturityId INT, @WIMPCTCompanyMaturityId_UPDATE BIT, @InvestmentDate DATE, @InvestmentDate_UPDATE BIT, @NAVatInvestment DECIMAL (10, 6), @NAVatInvestment_UPDATE BIT, @JiraEpicKey VARCHAR (32), @JiraEpicKey_UPDATE BIT, @JiraIssueKey VARCHAR (32), @JiraIssueKey_UPDATE BIT, @ComplianceChecksComplete BIT, @ComplianceChecksComplete_UPDATE BIT, @InvestmentTrustBoardReporting BIT, @InvestmentTrustBoardReporting_UPDATE BIT, @IsQuotedCompany BIT, @IsQuotedCompany_UPDATE BIT, @DevelopmentClassificationId INT, @DevelopmentClassificationId_UPDATE BIT, @PrimaryRelationInvestmentSourceId INT, @PrimaryRelationInvestmentSourceId_UPDATE BIT, @SecondaryRelationEstEvergreenVentureId INT, @SecondaryRelationEstEvergreenVentureId_UPDATE BIT, @IsFCARegulated BIT, @IsFCARegulated_UPDATE BIT, @IsSRARegulated BIT, @IsSRARegulated_UPDATE BIT, @JoinGUID UNIQUEIDENTIFIER, @JoinGUID_UPDATE BIT, @CompaniesLastModifiedDate DATETIME, @CompaniesLastModifiedDate_UPDATE BIT, @CADIS_SYSTEM_LASTMODIFIED DATETIME, @CADIS_SYSTEM_LASTMODIFIED_UPDATE BIT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END


