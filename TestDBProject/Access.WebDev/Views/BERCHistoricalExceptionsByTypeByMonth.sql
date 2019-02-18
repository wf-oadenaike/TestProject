CREATE VIEW [Access.WebDev].[BERCHistoricalExceptionsByTypeByMonth]
AS
/******************************
** Desc:
** Auth: W.Stubbs
** Date: 11/01/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1569     11/01/2018  W.Stubbs	Initial version of view
** DAP-1764		06/02/2018	W.Stubbs	Major rewrite - deagg data, exceptions and 
										resoncodes in tables
** DAP-1798		15/02/2018	R.Walker	Expose Reason Codes & Description
*******************************/

     SELECT  
		 YEAR(TCA.Trade_Date_time)					AS 'Year'
        ,MONTH(TCA.Trade_Date_time)					AS 'Month'
		,rc.Description								AS 'ReasonCode'
		,rc.Narrative								AS 'ReasonCodeDescriptive'
		,Count(1)									AS 'NoOfInstances'
	FROM 
        [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED]    tca
	LEFT OUTER JOIN dbo.T_BBG_ReasonCode rc
		ON tca.ReasonCode = rc.Description
	CROSS APPLY dbo.ufn_DetectTCAException(tca.Country,tca.B1NETPCTCST, tca.B2NETPCTCST, DEFAULT) AS tvf
	WHERE
		tca.REASONCODE IS NOT NULL
    GROUP BY 
        YEAR(tca.Trade_Date_time),
        MONTH(tca.Trade_Date_time),
		rc.Description,
        rc.Narrative

