﻿CREATE VIEW "CADIS"."DG_FUNCTION107_RESULTS" AS 
SELECT ET."UnquotedSecuritiesFundInvestmentId",ET."UnquotedSecuritiesId",ET."FundCode",ET."NumberOfShares",ET."FundAllocation",ET."TotalAmountInvested",ET."PercentageHeldAtClosing",ET."StampDuty",ET."WorkflowVersionGUID",ET."JoinGUID",ET."UnquotedSecuritiesCreationDate",ET."UnquotedSecuritiesCreatedByPersonId",ET."UnquotedSecuritiesLastModifiedDate",ET."UnquotedSecuritiesLastModifiedByPersonId",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Organisation"."UnquotedSecuritiesFundInvestments" ET WITH (NOLOCK)