CREATE VIEW [Access.WebDev].[BERCMonthlyReasonCodesUnquotedVw]
AS
/******************************
** Desc:
** Auth: W.Stubbs
** Date: 02/02/2018
**************************
** Change History
**************************
** JIRA            Date        Author        Description
** ----            ----------  -------        ------------------------------------
** OSPREY-1917  02/02/2018  W.Stubbs    Initial version of view
** OSPREY-1914    30/04/2018    R.Walker    Add OrderDate - take the earliest date for that order
** DAP-2092        21/06/2018    R.Walker    Add slack commentary in the format of Significant Trades
** DAP-2144        29/06/2018    R.Walker       Use T_BBG_BROKER instead of static T_BLOOMBERG_BROKERINFO
** DAP-2269        06/09/2018    R.Walker       expand stock shortname to full name
**************************/

WITH CTE as
(
 SELECT distinct OrderID, PostedBy, EventDate, Narrative
 FROM [TCA].[TCANarrativeEvents]
 WHERE Narrative IS NOT NULL
)
SELECT
   X.[Year],
   X.[Month],
    X.[OrderDate],
   X.OrderId,
   X.Security_Name,
   X.[Broker],
   X.Country,
   X.TotalValue,
   X.Performance,
   X.TCAException,
   X.Benchmark,
   X.ReasonCode,
    slk.OrderID AS slck_OrderID,
    slk.Narrative AS slck_Message,
    slk.PostedBy AS slck_PostedBy,
    slk.EventDate
FROM
(
SELECT
        YEAR(A.D_DATE)                                                       AS 'Year'
        ,MONTH(A.D_DATE)                                                     AS 'Month'
        ,MIN(CONVERT(DATE,A.D_DATE,20))                                      AS 'OrderDate'
        ,A.I_TSORDNUM                                                        AS 'OrderID'
       ,COALESCE(    MIN(sec.Security_Name), MIN(A.C_SECURITY))              AS 'Security_Name'
       ,COALESCE(MIN(BBI.Broker_Short_Name), MIN(A.C_BROKER))                AS 'Broker'
       ,CASE MIN(A.C_ORDEREXCH)
        WHEN 'DC' THEN 'DK'
        WHEN 'FP' THEN 'FR'
        WHEN 'GR' THEN 'DE'
        WHEN 'GU' THEN 'GG'
        WHEN 'GY' THEN 'DE'
        WHEN 'IB' THEN 'IN'
        WHEN 'ID' THEN 'IE'
        WHEN 'LN' THEN 'GB'
        WHEN 'LON' THEN 'GB'
        WHEN 'LX' THEN 'LU'
        WHEN 'NO' THEN 'NO'
        WHEN 'NOT' THEN 'NO'
        WHEN 'SW' THEN 'CH'
        WHEN 'US' THEN 'US'
        WHEN 'VX' THEN 'CH'
        ELSE NULL
        END                                                                as 'Country'
       , SUM(A.F_PRICE * A.F_QUANTITY)                                    as 'TotalValue'
        ,NULL                                                            as 'Performance'
        ,NULL                                                            as 'TCAException'
        ,NULL                                                            as 'Benchmark'
        ,'UQ'                                                            as 'ReasonCode'
   FROM
[dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] A

    LEFT OUTER JOIN
        dbo.T_BBG_BROKER                    BBI
            ON A.C_BROKER = BBI.[Broker]
    LEFT OUTER JOIN
        [dbo].[Vw_SecuritySourceIDs] B
            ON  IIF(CHARINDEX(' ', A.C_SECURITY) > 1, LEFT(A.C_SECURITY, CHARINDEX(' ', A.C_SECURITY) - 1), NULL) = B.SECURITY_ID  
				AND B.IDENTIFIER = 'TICKER'
	LEFT OUTER JOIN   dbo.T_MASTER_SEC sec
	ON B.EDM_SEC_ID = sec.EDM_SEC_ID				 
    WHERE
        A.C_REASONCODE = 6
        AND (
        -- either year is one less than current and month is equal or greater
        (YEAR(A.D_DATE) = YEAR(GETDATE()) -1 AND MONTH(A.D_DATE) >= MONTH(GETDATE())
        or
        -- or year is equal to current and month is less
        YEAR(A.D_DATE) = YEAR(GETDATE()) AND MONTH(A.D_DATE) < MONTH(GETDATE()))
        ) 
    GROUP BY
       year(A.D_DATE),
       month(A.D_DATE),
       A.I_TSORDNUM
) X
    LEFT OUTER JOIN CTE    slk
            ON X.OrderID = slk.OrderID   
WHERE X.[Broker]  <> 'OPSTRAN'			     



