﻿CREATE VIEW "CADIS"."DG_FUNCTION448_RESULTS" AS 
SELECT ET."OrderId",ET."SECURITY_NAME",ET."SIDE",ET."ORDERSHARES",ET."IsOrderFilled",ET."TOTAL_VALUE",ET."TRADER",ET."TraderName",ET."COUNTRY",ET."TCAException",ET."DAYSTOCOMPLETION",ET."FILLED_PERCENT_OF_INTERVAL_VOLUME",ET."ORDER_PERCENT_OF_INTERVAL_VOLUME",ET."PM_ORDER_TYPE",ET."B1ORIGBENCHPRICE",ET."B1PRETRADECOST",ET."B2ORIGBENCHPRICE",ET."B2PRETRADECOST",ET."ORDER_START_DATE_TIME",ET."ORDER_END_DATE_TIME",ET."Brokers",ET."Accounts",ET."ORIG_PRICE",ET."FILLED_PERCENT_OF_DAILY_VOLUME",ET."B1REALISEDCOSTBPS",ET."B1NETPCTCST",ET."B1NETREALDOLLAR",ET."B1TOTALDLRCOST",ET."B1MODELADJUSTEDARRIVAL",ET."B2REALISEDCOSTBPS",ET."B2NETPCTCST",ET."B2NETREALDOLLAR",ET."B2TOTALDLRCOST",ET."B3REALISEDCOSTBPS",ET."B3NETPCTCST",ET."B3MODELADJUSTEDARRIVAL",ET."B3NETREALDOLLAR",ET."B3TOTALDLRCOST",ET."B4REALISEDCOSTBPS",ET."B4NETPCTCST",ET."B4NETREALDOLLAR",ET."B4TOTALDLRCOST",ET."B5REALISEDCOSTBPS",ET."B5NETPCTCST",ET."B5NETREALDOLLAR",ET."B5TOTALDLRCOST",ET."B6REALISEDCOSTBPS",ET."B6NETPCTCST",ET."B6NETREALDOLLAR",ET."B6TOTALDLRCOST",ET."B7REALISEDCOSTBPS",ET."B7NETPCTCST",ET."B7NETREALDOLLAR",ET."B7TOTALDLRCOST",ET."B8REALISEDCOSTBPS",ET."B8NETPCTCST",ET."B8NETREALDOLLAR",ET."B8TOTALDLRCOST",ET."B9REALISEDCOSTBPS",ET."B9NETPCTCST",ET."B9NETREALDOLLAR",ET."B9TOTALDLRCOST",ET."B10REALISEDCOSTBPS",ET."B10NETPCTCST",ET."B10NETREALDOLLAR",ET."B10TOTALDLRCOST",ET."PnL",ET."Performance",ET."ChannelName",ET."ChannelId",ET."IsResolved",ET."DocumentationFolderLink",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Access.ManyWho"."TCAOrderRegisterReadOnlyVw" ET WITH (NOLOCK)
