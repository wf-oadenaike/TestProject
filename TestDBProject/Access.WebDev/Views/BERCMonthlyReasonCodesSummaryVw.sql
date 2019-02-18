CREATE VIEW [Access.WebDev].[BERCMonthlyReasonCodesSummaryVw]
AS
/******************************
** Desc:
** Auth: D.Fanning
** Date: 30/10/2017
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1405     30/10/2017  D.Fanning   Initial version of view
** DAP-1405     09/11/2017  D.Fanning   Remove TOP workaround for performance issue
** DAP-1405     14/11/2017  D.Fanning   Use raw Bloomberg audit data to include unquoted
** DAP-1764		06/02/2018	w.Stubbs	Use reasoncode table
** DAP-1798		15/02/2018	R.Walker	Expose Reason Codes & Description
*******************************/

SELECT
	X.[Year],
	X.[Month],
	X.ReasonCode,
	X.ReasonCodeDescriptive,
	NumberOfOrders = COUNT(X.I_TSORDNUM)
FROM
(
	select distinct [Year] = YEAR(tca.D_DATE), [Month] = MONTH(tca.D_DATE), tca.I_TSORDNUM, tca.C_IDENTIFIER, 
			ReasonCode = rc.description, ReasonCodeDescriptive = rc.Narrative
									 
	from [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] tca
	LEFT OUTER JOIN dbo.T_BBG_ReasonCode rc
		ON tca.C_REASONCODE = rc.code
	where tca.C_REASONCODE IS NOT NULL			
	and tca.C_EVENT NOT IN ('ORDER CANCELLED', 'MASTER POSTTRAD CANCELLED', 'CANCEL: ORDER WAS DELETED')
) X
GROUP BY
	X.[Year],
	X.[Month],
	X.ReasonCode,
	X.ReasonCodeDescriptive


