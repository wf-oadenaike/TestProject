
CREATE VIEW [dbo].[Vw_SecuritySourceIDs]
/******************************
** Desc: Map EDM_SEC_ID to instrument identifiers
** Auth: R.Walker
** Date: 05/06/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-2084     05/06/2018  R.Walker	Initial version of view
*******************************/
AS

	SELECT EDM_SEC_ID, SECURITY_ID, IDENTIFIER
	FROM 
	(
		SELECT EDM_SEC_ID, CAST(ISIN AS VARCHAR(30)) AS ISIN, CAST(SEDOL AS VARCHAR(30)) AS SEDOL, CAST(CUSIP AS VARCHAR(30)) AS CUSIP, CAST(TICKER AS VARCHAR(30)) AS TICKER
		FROM dbo.T_MASTER_SEC 
    ) IDs
	UNPIVOT
	(
		SECURITY_ID FOR IDENTIFIER IN (ISIN, SEDOL, CUSIP, TICKER)
	) AS IDs



