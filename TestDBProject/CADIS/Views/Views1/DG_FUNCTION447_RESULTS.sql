﻿CREATE VIEW "CADIS"."DG_FUNCTION447_RESULTS" AS 
SELECT ET."OrderBrokerId",ET."OrderId",ET."Broker",ET."BrokerName",ET."TotalShares",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Access.ManyWho"."TCAOrderBrokersReadOnlyVw" ET WITH (NOLOCK)