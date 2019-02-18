
CREATE VIEW [TCA].[V_REC_CHILD_LEVEL_BLOOMBERG_TCA_OUT_EXCEPTION_REASON]
AS

/********************************************************
-- Name: [TCA].[V_REC_CHILD_LEVEL_BLOOMBERG_TCA_OUT_EXCEPTION_REASON]
-- Decription: Give reasons for Bloomberg to TCA exceptions.

** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
-- DAP-1858		23/03/2018  V.Khatri	Initial Version
				15/04/2018	V.Khatri	Amended exceptions
				19/04/2018  V.Khatri	Some exceptions were being excluded due to a having condition. 
-- 
********************************************************/

SELECT DISTINCT O.ORDER_ID                                                                                       ORDER_ID,
                COALESCE(R1.REASON + ', ', '') + COALESCE(R2.REASON + ', ', '') + COALESCE(R3.REASON + ', ', '') AS REASON
FROM (

     SELECT I_TSORDNUM ORDER_ID
     FROM TCA.TCAOUT
     UNION
     SELECT ORDERID AS ORDER_ID
     FROM [TCA].[BETA_TCAOUTPUTRESULTS]
) O
LEFT OUTER JOIN (
     SELECT ORDER_ID,
            ACCOUNT                          AS ACCOUNT,

            COUNT(ISNULL(BROKERID, ''))      AS BROKERID,
            REASON
     FROM (
          SELECT DISTINCT ORDERID              AS ORDER_ID,
                          ACCOUNT              AS ACCOUNT,
                          ISNULL(BROKERID, '') AS BROKERID,
						  'ITG HAS MULTIPLE BROKERS TO AN ACCOUNT' AS REASON
          FROM [TCA].[BETA_TCAOUTPUTRESULTS]
		  UNION
		  	SELECT 	distinct	I_TSORDNUM				AS ORDER_ID,
				C_ACCOUNT				AS ACCOUNT,
				c_broker				as brokerID,
				'BLOOMBERG HAS MULTIPLE BROKERS TO AN ACCOUNT' AS REASON
			FROM TCA.TCAOut
     ) A
     GROUP BY ORDER_ID,
              ACCOUNT,
			  REASON
     HAVING COUNT(ISNULL(BROKERID, '')) > 1

) R1


     ON O.ORDER_ID = R1.ORDER_ID


LEFT OUTER JOIN (
     SELECT ORDER_ID,
            'TCA PARENTORDERID IS NOT AT THE TOP LEVEL' AS REASON
     FROM (
          SELECT DISTINCT I_TSORDNUM AS ORDER_ID
          FROM TCA.TCAOUT
          WHERE TOP_LEVEL_DERIVED = 1

     ) A
) R2

     ON O.ORDER_ID = R2.ORDER_ID
LEFT OUTER JOIN (
     SELECT DISTINCT B.ORDER_ID,
                     'TOTAL CORRECT PER ACCOUNT AND BROKER' AS reason
     FROM (
          SELECT i_TSORDNUM              ORDER_ID,
                 C_ACCOUNT               ACCOUNT,
                 C_BROKER                BROKERID,
                 SUM(ALLOCATED_QUANTITY) ALLOCATED_QUANTITY
          FROM TCA.TCAOUT
          GROUP BY i_TSORDNUM,
                   C_ACCOUNT,
                   C_BROKER
     ) B
     INNER JOIN (
          SELECT OrderID                             ORDER_ID,
                 ACCOUNT,
                 BROKERID,
                 SUM(CAST(Shares AS decimal(18, 6))) ALLOCATED_QUANTITY
          FROM [TCA].[BETA_TCAOUTPUTRESULTS]
          GROUP BY OrderID,
                   ACCOUNT,
                   BROKERID
     ) T
          ON B.ORDER_ID = T.ORDER_ID
          AND B.ACCOUNT = T.ACCOUNT
          AND B.BROKERID = T.BROKERID
          AND B.ALLOCATED_QUANTITY = T.ALLOCATED_QUANTITY
) R3
     ON O.ORDER_ID = R3.ORDER_ID
WHERE COALESCE(R1.REASON, R2.REASON, R3.REASON) IS NOT NULL