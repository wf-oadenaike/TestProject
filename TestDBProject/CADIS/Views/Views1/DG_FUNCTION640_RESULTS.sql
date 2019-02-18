CREATE VIEW "CADIS"."DG_FUNCTION640_RESULTS" AS 
SELECT ET."CADIS_RUN_ID",ET."CADIS_ROW_ID",ET."Date",ET."Time",ET."RuleID",ET."PostTradeExceptionCategory",ET."TradeTicketNumber",ET."TradedSecurity",ET."SecIdent",ET."TraderNotes",ET."LastNote",ET."ApprLogin",ET."DetailedReasonNotes",ET."SecurityName",ET."Year",ET."Month",ET."slck_OrderID",ET."slck_Message",ET."slck_PostedBy",ET."slck_Date",ET."AsAtDate",ET."AsofDate" FROM "Access.WebDev"."BERCPostTradeViolations" ET WITH (NOLOCK) WHERE (
[Date] < CONVERT(VARCHAR(6), GETDATE(), 112) + '01'
AND
 [Date] >= DATEADD(yy, -1, (CONVERT(VARCHAR(6), GETDATE(), 112) + '01')) /* Get rolling full years worth of data */
AND
RuleID IN 
('H_EXTSET'
,'H_NOBKDT'
,'H_PSTCHK'
,'H_SETT1'
,'H_SETTUS' /* decommissioned but left in for legacy reporting */
,'Z_SETTUS')/* restrict to 5 rules */

)

