
CREATE VIEW [Reporting].[vw_UnquotedAllocation]
/******************************
** Desc: Reporting view over Master Unquoted Allocation
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

	ALLOCATION_ID,
	FUND_SHORT_NAME,
	ALLOCATION,
	FUNDING_ID,
	REVALUATION_ID,
	CADIS_SYSTEM_INSERTED,
	CADIS_SYSTEM_UPDATED,
	CADIS_SYSTEM_CHANGEDBY



FROM [dbo].[T_UNQUOTED_ALLOCATION]

