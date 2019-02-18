﻿
CREATE VIEW [Reporting].[vw_MasterDealsInProgress]
/******************************
** Desc: Reporting view over Master Deals In Progress
**		 
** Auth: R. Walker
** Date: 05/03/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1785     05/03/2018  R.Walker	Initial version of view
*******************************/

AS

SELECT 

	ASSET,
	ASSET_NAME,
	[I/A],
	SUB_FUND,
	SUB_FUND_NAME,
	DEALING_PERIOD_ID,
	ORDER_DATE,
	ORDER_REF,
	MAIN_OWNER,
	MAIN_OWNER_NAME,
	TYPE,
	STATUS,
	DEAL_CLASS,
	[UNITS/SHARES],
	CCY,
	VALUE,
	PLAN_ID,
	DESIGNATION,
	PRODUCT_NAME,
	DESCRIPTION,
	AGENT,
	AGENT_NAME,
	[ADMIN_FEE_%],
	[CREATION_PLUS_%],
	[INITIAL_CHARGE_%],
	[FEE_DISCOUNT_%],
	[PRICE_DISCOUNT_%],
	[COMMISSION_%],
	COMMISSION_VALUE,
	[COMMISSION_WAIVER_%],
	[RENEWAL_COMMISSION_%],
	PRICE_TYPE,
	VALUATION_POINT,
	PRICING_DEALING_PERIOD_ID,
	DEAL_TYPE,
	CONTRACT_NOTE_COMMENTS,
	[FX_REQD?],
	[FX_CONFIRMED?],
	FX_INSTRUCTION,
	INDICATIVE_FX_RATE,
	[CONFIRMED/SPOT_RATE],
	SETTLEMENT_CCY,
	SETTLEMENT_AMT,
	[DL_%],
	DL_AMOUNT,
	[EXEMPT?],
	[ESTIMATED?],
	[EXTERNAL?],
	IN_SPECIE,
	US_WITHHOLDING_TAX,
	QUOTED_PRICE,
	DEAL_PRICE,
	PRICE_ADJUSTMENT,
	[%_OF_FUND_VALUE],
	COUNT,
	DEALING_PERIOD_CLOSE_DATE,
	DEALING_PERIOD_CUT_OFF_DATE,
	CUT_OFF_OVERRIDDEN,
	EXTERNAL_SOURCE,
	CADIS_SYSTEM_INSERTED,
	CADIS_SYSTEM_UPDATED,
	CADIS_SYSTEM_CHANGEDBY,
	CADIS_SYSTEM_PRIORITY,
	CADIS_SYSTEM_LASTMODIFIED

FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
