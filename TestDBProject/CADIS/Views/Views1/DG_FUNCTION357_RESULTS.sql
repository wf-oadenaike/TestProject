﻿CREATE VIEW "CADIS"."DG_FUNCTION357_RESULTS" AS 
SELECT ET."CompanyId",ET."CompanyName",ET."CompanySalesforceId",ET."PrimaryContactSalesforceId",ET."InvestmentAnalystPersonId",ET."InvestmentManagerOwnerPersonId",ET."CurrentUnquotedCompanyStage",ET."NextReviewDate",ET."CompanyOverview",ET."NotesForSalesTeam",ET."CurrentPrice",ET."CurrencyCode",ET."CompanyRootFolderURL",ET."InitialInformationFolderURL",ET."InitialInvestmentRulesAssessment",ET."SectorId",ET."SubSectorId",ET."CountryISOCode",ET."WIMEIFCompanyMaturityId",ET."WIMPCTCompanyMaturityId",ET."InvestmentDate",ET."NAVatInvestment",ET."JiraEpicKey",ET."JiraIssueKey",ET."ComplianceChecksComplete",ET."InvestmentTrustBoardReporting",ET."IsQuotedCompany",ET."DevelopmentClassificationId",ET."PrimaryRelationInvestmentSourceId",ET."SecondaryRelationEstEvergreenVentureId",ET."IsFCARegulated",ET."IsSRARegulated",ET."JoinGUID",ET."CompaniesCreationDate",ET."CompaniesLastModifiedDate",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Investment"."Companies" ET WITH (NOLOCK)
