﻿CREATE VIEW "CADIS"."DG_FUNCTION213_RESULTS" AS 
SELECT ET."PlacingRegisterId",ET."PlacingName",ET."PlacingStatus",ET."IsThisThroughABroker",ET."BrokerContactName",ET."BrokerSalesforceId",ET."SubmitterPersonId",ET."SubmittedBy",ET."ProjectLeadId",ET."ProjectLead",ET."InitialAllocations",ET."FundCode",ET."SettlementType",ET."SettlementInstructions",ET."SettlementDate",ET."TradeDate",ET."EstimatedDate",ET."ApprovalDate",ET."PaymentMethod",ET."Ticker",ET."IsStopRequiredYesNo",ET."AddedToStopListYesNo",ET."DateStopped",ET."IPOorPlacing",ET."Notes",ET."OperationsComments",ET."JiraIssueKey",ET."IrrevocableYesNo",ET."RaiseAmount",ET."Exchange",ET."WestJiraTaskKey",ET."PreMoneyRange",ET."DealDocumentationFolderLink",ET."AllocDocumentationFolderLink",ET."AdditionalFolderLink",ET."IsFCARegulated",ET."IsSRARegulated",ET."JoinGUID",ET."PlacingCreationDatetime",ET."PlacingLastModifiedDatetime" FROM "Access.ManyWho"."PlacingsRegisterReadOnlyVw" ET WITH (NOLOCK)
