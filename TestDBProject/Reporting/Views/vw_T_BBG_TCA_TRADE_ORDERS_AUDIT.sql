

CREATE VIEW  [Reporting].[vw_T_BBG_TCA_TRADE_ORDERS_AUDIT]
-------------------------------------------------------------------------------------- 
-- Name:   [Reporting].[vw_T_BBG_TCA_TRADE_ORDERS_AUDIT]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- Olu: 17/08/2018 JIRA: DAP-2286 [Create New View]
-- Olu: 17/08/2018 JIRA: DAP-2286 [Add new fields Currency, fund ]
-- Olu: 31/08/2018 JIRA: DAP-2307 [Add C_IPO field]

--
-- 
-------------------------------------------------------------------------------------- 
AS


select  LEFT(C_SECURITY,LEN(C_SECURITY)-3) as Ticker, C_SECURITY, C_SIDE,D_ASOFDATE,F_PRINCIPAL, F_QUANTITY, F_EX_RATE, C_ACCOUNT, C_CURRENCY, C_IPO  from  dbo.T_BBG_TCA_TRADE_ORDERS_AUDIT 
where left(C_SECURITY,1) = '.'
and C_EVENT = 'Activated Order'
