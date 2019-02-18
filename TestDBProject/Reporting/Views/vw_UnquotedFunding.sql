
CREATE VIEW [Reporting].[vw_UnquotedFunding]
/******************************
** Desc: Reporting view over Master Unquoted Funding
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

	FUNDING_ID,
	ISSUER,
	EDM_SEC_ID,
	TRADE_DATE,
	SETTLEMENT_DATE,
	FUNDING_STATUS,
	IS_LEGAL,
	IS_REPUTATIONAL,
	FUNDING_TYPE,
	FUNDING_SUB_TYPE,
	PUSH_BACK_UNIT,
	PUSH_BACK_MAGNITUDE,
	PULL_FORWARD_UNIT,
	PULL_FORWARD_MAGNITUDE,
	TECH_STATUS,
	CADIS_SYSTEM_INSERTED,
	CADIS_SYSTEM_UPDATED,
	CADIS_SYSTEM_CHANGEDBY



FROM [dbo].[T_UNQUOTED_FUNDING]

