﻿CREATE VIEW "CADIS"."DG_FUNCTION642_RESULTS" AS 
SELECT ET."ID",ET."FundingID",ET."SecurityID",ET."AllocationAmount",ET."RevaluationID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Investment"."T_UnquotedFundingSecurityAllocations" ET WITH (NOLOCK)
