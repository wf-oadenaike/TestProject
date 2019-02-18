CREATE VIEW "CADIS"."DG_FUNCTION329_RESULTS" AS 
SELECT ET."AgentName",ET."FundShortName",ET."Subscriptions",ET."SubscriptionsDisplay",ET."Redemptions",ET."RedemptionsDisplay",ET."Total",ET."TotalDisplay",ET."LastUpdatedDate" FROM "Access.WebDev"."ufn_EDMDIPsGetDIPsBreakdown"(NULL) ET
