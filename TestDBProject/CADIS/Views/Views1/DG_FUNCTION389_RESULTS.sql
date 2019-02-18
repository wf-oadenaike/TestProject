﻿CREATE VIEW "CADIS"."DG_FUNCTION389_RESULTS" AS 
SELECT ET."CompanyId",ET."CompanyName",ET."SecurityBloombergId",ET."SecurityName",ET."FundCode",ET."EventType",ET."IsActive",ET."Status",ET."Notes",ET."PresentedToPricingCommittee",ET."RevaluationPreviousPrice",ET."RevaluationPrice",ET."EventDate",ET."RevaluationEndDate",ET."SecurityRevaluationCreationDate",ET."SecurityRevaluationLastModifiedDate" FROM "Access.ManyWho"."UnquotedSecuritiesInFundReadOnlyVw" ET WITH (NOLOCK)
