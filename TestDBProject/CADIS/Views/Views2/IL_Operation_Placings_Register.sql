﻿CREATE VIEW "CADIS"."IL_Operation_Placings_Register" AS 
SELECT V."PlacingRegisterId" AS "Placing Register ID",V."PlacingName" AS "Placing Name",V."PlacingStatus" AS "Placing Status",V."IsThisThroughABroker" AS "Is This Through A Broker",V."BrokerContactName" AS "Broker Contact Name",V."BrokerSalesforceId" AS "Broker Salesforce ID", J6.DF AS "Submitter Person ID", J7.DF AS "Project Lead ID",V."InitialAllocations" AS "Initial Allocations",V."FundCode" AS "Fund Code",V."SettlementType" AS "Settlement Type",V."SettlementInstructions" AS "Settlement Instructions",V."SettlementDate" AS "Settlement Date",V."TradeDate" AS "Trade Date",V."EstimatedDate" AS "Estimated Date",V."ApprovalDate" AS "Approval Date",V."PaymentMethod" AS "Payment Method",V."Ticker" AS "Ticker",V."IsStopRequiredYesNo" AS "Is Stop Required Yes No",V."AddedToStopListYesNo" AS "Added To Stop List Yes No",V."DateStopped" AS "Date Stopped",V."IPOorPlacing" AS "IPO or Placing",V."Notes" AS "Notes",V."JiraIssueKey" AS "Jira Issue Key",V."IrrevocableYesNo" AS "Irrevocable Yes No",V."OperationsComments" AS "Operations Comments",V."DealDocumentationFolderLink" AS "Deal Documentation Folder Link",V."AllocDocumentationFolderLink" AS "Alloc Documentation Folder Link",V."AdditionalFolderLink" AS "Additional Folder Link",V."RaiseAmount" AS "Raise Amount",V."Exchange" AS "Exchange",V."WestJiraTaskKey" AS "West Jira Task Key",V."PreMoneyRange" AS "Pre Money Range",V."IsFCARegulated" AS "Is FCA Regulated",V."IsSRARegulated" AS "Is SRA Regulated",V."JoinGUID" AS "Join GUID",V."PlacingCreationDatetime" AS "PlacingCreation Datetime",V."PlacingLastModifiedDatetime" AS "Placing Last Modified",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_TIMESTAMP",V."CADIS_SYSTEM_LASTMODIFIED",V."IsUnquoted" FROM "Operation"."PlacingsRegister" V LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J6 ON  J6.JF=V."SubmitterPersonId" LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J7 ON  J7.JF=V."ProjectLeadId"