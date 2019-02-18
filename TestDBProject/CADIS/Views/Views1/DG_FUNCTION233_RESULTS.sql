﻿CREATE VIEW "CADIS"."DG_FUNCTION233_RESULTS" AS 
SELECT ET."PADealingRegisterId",ET."RequestorPersonId",ET."RequestedDate",ET."Status",ET."OnStopList",ET."BloombergId",ET."InvestmentName",ET."InvestmentType",ET."TransactionType",ET."WoodfordInvestmentYesNo",ET."Value",ET."CurrencyCode",ET."NumOfShares",ET."SalaryPercentage",ET."EmployeeComments",ET."ComplianceComments",ET."ComplianceDecisionDate",ET."CompliancePersonId",ET."WithdrawalRequestedYesNo",ET."JIRAIssueKey",ET."DocumentationFolderLink",ET."JoinGUID",ET."PADealingCreationDatetime",ET."PADealingLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Compliance"."PADealingRegister" ET WITH (NOLOCK)
