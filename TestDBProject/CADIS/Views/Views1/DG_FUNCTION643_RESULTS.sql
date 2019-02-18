﻿CREATE VIEW "CADIS"."DG_FUNCTION643_RESULTS" AS 
SELECT ET."ID",ET."SecurityAllocationID",ET."PortfolioID",ET."AllocationAmount",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Investment"."T_UnquotedFundingPortfolioAllocations" ET WITH (NOLOCK)
