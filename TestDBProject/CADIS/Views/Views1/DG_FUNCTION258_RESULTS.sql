﻿CREATE VIEW "CADIS"."DG_FUNCTION258_RESULTS" AS 
SELECT ET."UnquotedCompanyId",ET."UnquotedCompanyName",ET."UnquotedCompanySalesforceId",ET."PrimaryContactSalesforceId",ET."InvestmentAnalystPersonId",ET."InvestmentAnalystName",ET."InvestmentAnalystSalesforceUserId",ET."InvestmentManagerOwnerPersonId",ET."InvestmentManagerOwnerName",ET."InvestmentManagerOwnerSalesforceUserId",ET."InvestmentManagerOwnerRoleId",ET."CurrentUnquotedCompanyStage",ET."CurrentUnquotedCompanyStageDescription",ET."InitialMeetingDate",ET."Attendees",ET."NextReviewDate",ET."CompanyOverview",ET."NotesForSalesTeam",ET."CurrentPrice",ET."CurrencyCode",ET."UnquotedCompanyRootFolderURL",ET."UnquotedCompanyRootFolderId",ET."InitialInformationFolderURL",ET."InitialDueDiligenceFolderURL",ET."FinalInvestmentFolderURL",ET."InitialInvestmentRulesAssessment",ET."JiraEpicKey",ET."JiraIssueKey",ET."WorkflowVersionGUID",ET."JoinGUID",ET."UnquotedCompaniesCreationDate",ET."UnquotedCompaniesLastModifiedDate",ET."IMCommentary",ET."IMCommentaryBy",ET."IMCommentaryDate",ET."IMDecision",ET."IMDeferDecisionDate",ET."IMDecisionBy",ET."IMDecisionDate",ET."IDDCommentary",ET."IDDCommentaryBy",ET."IDDCommentaryDate",ET."IDDDecision",ET."IDDDeferDecisionDate",ET."IDDDecisionBy",ET."IDDDecisionDate",ET."TSCommentary",ET."TSCommentaryBy",ET."TSCommentaryDate",ET."TSDecision",ET."TSDeferDecisionDate",ET."TSDecisionBy",ET."TSDecisionDate",ET."DDDCommentary",ET."DDDCommentaryBy",ET."DDDCommentaryDate",ET."DDDDecision",ET."DDDDeferDecisionDate",ET."DDDDecisionBy",ET."DDDDecisionDate",ET."ComplianceChecksComplete",ET."InvestmentTrustBoardReporting",ET."InitialInvestmentDate",ET."CCommentary",ET."CCommentaryBy",ET."CCommentaryDate",ET."CDecisionBy",ET."CDecisionDate" FROM "Access.ManyWho"."UnquotedPipelineReadOnlyVw" ET WITH (NOLOCK)
