﻿CREATE VIEW "CADIS"."DG_FUNCTION238_RESULTS" AS 
SELECT ET."UnquotedCompanyId",ET."InvestmentCategorisationMeetingDate",ET."InvestmentCategory",ET."AnnualConfluenceChecklistUrl",ET."WorkflowVersionGUID",ET."JoinGUID",ET."InvestmentCategorisationCreationDate",ET."InvestmentCategorisationCreatedByPersonId",ET."InvestmentCategorisationModifiedDate",ET."InvestmentCategorisationLastModifiedByPersonId",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Organisation"."UnquotedCompanyInvestmentCategorisations" ET WITH (NOLOCK)
